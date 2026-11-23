# FPGA 上电从 SPI Flash 启动

`top.FLASH_BOOT_ENABLE` 默认值为 1。加载器在 PLL 锁定并解除同步复位后等待约 10 ms，使用 SPI mode 0、标准 `03h + 24-bit address` 连续读命令，依次加载：

| Flash 物理地址（含端点） | CPU / HEX 字节地址（含端点） | 内容 |
| --- | --- | --- |
| `0x001000 .. 0x020FFF` | `0x00001000 .. 0x00020FFF` | IMEM，代码和 `.rodata`，128 KiB |
| `0x021000 .. 0x040FFF` | `0x7FF80000 .. 0x7FF9FFFF` | DMEM，含 `.data` / `.sdata` 初值，128 KiB |

兼容现有 `flash_upload.py` / `flashhex` 的存储映射，无需重新打包 HEX。Flash 中存放原始数据字节，加载器不解析 HEX 文本。因为现有格式没有长度头，两个区域均完整读取，未烧写处按 Flash 的实际内容加载。启动代码仍负责清零 BSS。

加载过程中 CPU 保持复位，加载器独占 SPI 引脚和 BRAM 下载写端口。最后一个字节提交、CS 回到高电平后，SPI 引脚交还原 SPI 外设，UART 切换为运行模式，CPU 自动从 `0x1000` 开始执行。加载时忽略 UART 的内存写入；应等待启动完成再使用终端。

默认系统时钟约 27 MHz，SPI 时钟为系统时钟 / 8，两个区域总加载时间约 0.63 秒。SPI CS 加入内部上拉，交接到尚未使能的 GPIO 驱动时保持 Flash 未选中。

## 使用

1. 用现有运行中的固件，通过 `riscv_fw_base/tools/flash_upload.py` 完整烧写 `test.ihex`，等待 `FLASH DONE`。
2. 在 Vivado 中打开更新后的 `project_fpga_riscv.xpr`，重新综合、实现并生成 bitstream，再配置 FPGA。
3. 若需要断电后自动启动 FPGA，本次新 bitstream 也必须保存到板卡原有的非易失 FPGA 配置存储中；仅通过 JTAG 配置不会跨断电保留。
4. 重新上电或触发 `sys_reset`，应在约 0.63 秒后看到固件启动输出和 `Init done`。

烧写命令和 `flashread` 仍然操作外部 Flash；更新 Flash 后需复位才会重新加载，不会立即覆盖正在运行的 RAM。

## 空白 Flash 与恢复

若代码区域前 4 字节全为 `FF` 或全为 `00`，加载器置 `flash_boot_error`，停止自动启动，保持 CPU 复位并释放 SPI，允许按原流程从 UART 下载 HEX 到 BRAM，收到 EOF 后运行。这种情况下需要先从 UART 启动含 Flash 烧写命令的固件，再重新烧写 Flash。

该检查仅识别明显空白/无响应情况，没有镜像 CRC、版本头或完整性保证。部分烧写的镜像不一定能被检测到。`flash_boot_busy/done/error` 可在仿真或 ILA 中观察。

设置 `top.FLASH_BOOT_ENABLE=0` 可恢复纯 UART/JTAG 加载模式。现有 `tb_firmware` 已明确关闭自动启动以保留其直接加载测试路径。

## 验证

安装了 Verilator、C++ 编译器及 make 的环境中，从工作区根目录运行：

```sh
python3 project_fpga_riscv/sim/run_flash_layout_test.py
# 保留构建目录：
python3 project_fpga_riscv/sim/run_flash_layout_test.py --build-dir /tmp/fpga-flash-layout
```

该回归不依赖厂商 IP：检查两次 SPI READ 的 opcode 和物理地址、全部 262144 字节、跨 64 KiB 边界、连续的 CPU 写入地址，以及完成时的 CS/busy 状态。DMEM 从 Flash `0x021000` 加载到 CPU `0x7FF80000`。实际固件运行至 `Init done` 的集成验证使用下面的 Vivado XSim 流程。

Vivado 工程已加入 `rtl/spi_flash_boot.v`。测试顶层不加入综合源。Verilator 测试不能替代 Vivado 实现、时序分析或板上验证。

### Vivado XSim

`tb_flash_system` 是带输入端口的集成测试模块，Verilator 的时钟、复位和 SPI Flash 由 `sim/test_flash_system.cpp` 驱动。在 Vivado 中改用 `tb_flash_system_xsim` 作为仿真顶层，它提供相同的激励、Flash 数据和超时检查。

1. 将当前工程目录下的 `rtl/testbench/tb_flash_system.sv` 和 `rtl/testbench/tb_flash_system_xsim.sv` 加入 **Simulation Sources**，保留工程原有 `s_32kx32` IP。不要加入 `sim/boot_ram_model.v`，否则会与 IP 重复定义。
2. 将 IHEX 转为地址/字节文本（不是普通 `$readmemh` 格式）：

   ```sh
   python3 sim/ihex_to_mem.py ../riscv_fw_base/output/test.ihex sim/firmware.mem
   ```

3. 在 Vivado Tcl Console 中设置顶层及文件参数，路径改为本机实际路径，Windows 路径使用 `/`：

   ```tcl
   set_property top tb_flash_system_xsim [get_filesets sim_1]
   set_property \
    -name {xsim.simulate.xsim.more_options} \
    -value {-testplusarg FW_MEM=D:/FPGA_DEV/github/project_fpga_riscv_v/sim/firmware.mem} \
    -objects [get_filesets sim_1]
   set_property xsim.simulate.runtime all [get_filesets sim_1]
   update_compile_order -fileset sim_1
   launch_simulation
   ```

测试先逐字节检查加载后的 IMEM/DMEM，再运行到 `Init done` 后结束。BRAM 检查按 `VERILATOR` 宏选择行为模型的 `mem`，或当前 Block Memory Generator v8.4.4 的 `inst.native_mem_module.blk_mem_gen_v8_4_4_inst.memory`。更换 IP 版本、输出模型或实例名时需同步检查该层次路径。

如果报错仍指向 `D:/FPGA_DEV/Github/...` 等旧目录，请在 Sources 中移除旧测试文件引用，添加本工程中的修改版本后重新启动仿真。

## 从旧版地址布局升级

DMEM 的 Flash 起始地址由 `0x200000` 改为 `0x021000`，结束地址为 `0x040FFF`（128 KiB）；CPU/HEX 地址保持 `0x7FF80000 .. 0x7FF9FFFF`，IMEM 布局不变。`flash_upload.py` 继续发送 CPU 地址的 Intel HEX，由运行中的新版 FW 执行物理地址转换，无需改写 HEX 地址。

1. 重新构建新版 FW 和 FPGA bitstream。
2. 先通过现有 UART 下载流程把新版 FW 加载到 RAM 并运行；可使用 `FLASH_BOOT_ENABLE=0` 的 FPGA 配置进行 UART 启动。旧版运行固件的 `flashhex` 仍会写入 `0x200000`，不能用于本次新布局烧写。
3. 运行 `python3 tools/flash_upload.py --port /dev/ttyUSB0 --file output/test.ihex`（在 `riscv_fw_base` 目录下），等待 `FLASH DONE`。用 `\flashread 21000 40` 检查 DMEM 初始数据。
4. 配置启用 Flash boot 的新版 FPGA bitstream，并按板卡原流程保存配置以支持断电启动，然后复位或重新上电验证。

旧 `0x200000 .. 0x21FFFF` 数据不会被本次上传自动清除，新引导器不再读取该区域。烧写仍按实际 HEX 记录涉及的 4 KiB 扇区擦除。
