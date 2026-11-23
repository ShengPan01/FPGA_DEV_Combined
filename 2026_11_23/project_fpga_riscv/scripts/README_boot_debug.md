# 串口下载/启动 ILA 调试

本次只增加 FPGA 被动观测逻辑，不修改 FW、LED、复位条件或 UART/AXI 功能。

新增探针位于 `bk3imcpj_wrapper`，名称为 `dbg_*`，均标记
`mark_debug` 和 `keep`，采样时钟使用 `osc_clk`。计数器只由系统
`reset_n` 清零，CPU 复位期间保留；32-bit 计数器溢出后回绕。
未添加外部引脚，LED 功能保持原样。

## 推荐：一条命令构建带 ILA 的 bitstream

在 Vivado 配套终端执行（路径可使用绝对路径）：

```sh
vivado -mode batch -source project_fpga_riscv/scripts/build_boot_debug.tcl
```

脚本打开当前目录的 XPR、重跑综合、插入 ILA，然后在当前内存设计中完成
opt/place/route。输出到 `project_fpga_riscv/boot_debug/`：

- `boot_debug.bit`、`boot_debug.ltx`：必须配对使用。
- `boot_debug_synth.dcp`、`boot_debug_routed.dcp`：调试检查点。
- `boot_debug_timing.rpt`、`boot_debug_utilization.rpt`：检查时序、资源。

脚本会重置 synth_1 运行；不会下载 FPGA，不改已有 XDC，也不会更新 impl_1。
若工程曾通过 save_constraints 保存过旧 ILA 约束，先移除旧 ILA 定义，避免重复。
如 XPR 引用旧机器的外部文件，请先在 Sources 中修复缺失路径，再运行构建。
脚本拒绝负 setup/hold slack；仍需检查时序报告中的未约束路径和其它告警。
本机没有 Vivado，尚未实际验证综合、布局布线和板上捕获。

## 手工生成带 ILA 的 bitstream

1. 重新综合修改后的工程，打开 Synthesized Design。
2. 在 Vivado Tcl Console 执行（路径按工作目录调整）：
   ```tcl
   source /path/to/project_fpga_riscv/scripts/insert_boot_ila.tcl
   save_constraints
   ```
3. 运行 implementation，生成 bitstream，同时导出对应 `.ltx`：
   ```tcl
   open_run impl_1
   write_debug_probes -force boot_debug.ltx
   ```
4. Hardware Manager 加载同一次构建的 `.bit` 和 `.ltx`。
   先 arm ILA，再复位系统并发送 ihex。深度 2048 不能覆盖整个下载过程，
   应分次设置触发，或使用计数器和锁存状态检查历史事件。

脚本显式执行后才插入 ILA；仅有 mark_debug 属性不会自动生成采集核。
若 probe 被优化为其它网名，脚本会报缺失；可以通过 Set Up Debug
手工选择相应标记网络。脚本尚需在实际 Vivado 综合结果上验证。

## 探针位定义

| 信号 | 内容 |
|---|---|
| `dbg_uart_status[31:24]` | 最近接收的 RX 数据；在 bit0=1 时采样 |
| `[23:20]` | HEX main_state：0=等待记录，12=错误锁死，13=等待 EOF 的 LF，14=等待 TX ready，11=完成脉冲 |
| `[19:16]` | 保留为 0 |
| `[15:12]` | RX中断使能、TX中断使能、RX中断状态、TX中断状态 |
| `[11:8]` | uart_intr、TX busy、固件 TX valid、TX ready |
| `[7:4]` | TX引脚、RX引脚、tx_error、HEX error |
| `[3:0]` | ram_wr_en、final_done、data_ready、RX valid |
| `dbg_boot_status[7:0]` | [7:6]=0、[5]=mtip、[4]=p_meip、[3]=CPU reset_n、[2]=download_reset_n、[1]=boot_done、[0]=boot_busy |
| `dbg_load_addr/data` | Flash/UART 仲裁后的下载地址、数据 |
| `dbg_load_en[8:0]` | load_wr_en、IMEM byte enable[3:0]、DMEM byte enable[3:0] |
| `dbg_if_addr/data` | 取指 AXI 地址/返回数据，分别在地址/返回握手时有效 |
| `dbg_if_status[5:0]` | rresp[1:0]、rvalid、rready、arvalid、arready |
| `dbg_data_raddr/rdata/waddr/wdata` | CPU data AXI，各字段仅在各自握手时有效 |
| `dbg_data_status[15:0]` | wstrb[3:0]、bresp[1:0]、rresp[1:0]、bvalid、bready、wvalid、wready、awvalid、awready、arvalid、arready |
| `dbg_data_read_status[1:0]` | data AXI rvalid、rready |
| `dbg_mcu_addr/wdata/rdata` | 本地 8-bit 外设总线地址/写数据/内部读数据 |
| `dbg_mcu_status[4:0]` | uart_intr、UART write、UART read、MCU write、MCU read |
| `dbg_load_count` | 实际选中 IMEM 或 DMEM 的下载字节写次数（含 Flash） |
| `dbg_fetch_count` | CPU 退出复位后的指令地址握手次数，不是执行指令数 |
| `dbg_uart_tx_count` | 固件 TX 寄存器写次数，不含下载期间硬件发送的 `.` |
| `dbg_last_if_addr` | 最近一次握手的取指地址，不等于退休 PC |

`dbg_seen` 是只置位的事件历史：

| bit | 事件 |
|---|---|
| 0 | HEX 解析错误 |
| 1 | data_ready 曾置位 |
| 2 | CPU 曾退出复位 |
| 3 | 曾发生取指地址握手 |
| 4 | 固件曾写 UART TX |
| 5 | 取指返回非 OKAY |
| 6 | data read 返回非 OKAY |
| 7 | data write 返回非 OKAY |

`tx_error` 仅表示 TX 非空闲时出现 RX valid，并非 UART 帧错误。
本次未增加退休 PC、mcause 或 mtval 探针。

## 推荐触发顺序

1. `dbg_uart_status[4] == 1`：捕获解析错误；正常下载后检查 bit1=data_ready。
2. `dbg_uart_status[2] == 1`：捕获 EOF 完成及 CPU reset_n 释放。
3. `dbg_if_status[1:0] == 3`：取指地址握手，第一笔预期 0x1000。
   当前目录旧 test.ihex 在该地址返回数据为 0x1AC0006F；重新编译后按新文件检查。
4. `dbg_mcu_status[3] == 1` 且 `dbg_mcu_addr == 0`：固件写 TX；
   检查写数据、TX busy/ready 和 TX 引脚。

启动后可立即抓取历史：load_count 非零但 seen[1]=0 表示仍未确认下载完成；
seen[2]=1、seen[3]=0 表示 CPU 已释放但无取指；seen[3]=1、seen[4]=0
表示有取指但未写串口，继续看取指地址、AXI 错误和 data 总线。


## 上板 debug 步骤（使用原来已验证的 FW）

### 1. 加载和采集准备

1. Hardware Manager 选择目标器件，Program Device 同时指定本次构建的
   `boot_debug.bit` 与 `boot_debug.ltx`。确认发现 `ila_boot`，采样时钟为 osc_clk。
2. 串口保持原 FW 使用的参数；当前 RTL 默认 115200、8N1。
   关闭软/硬流控，下载完成后停止发送额外字符。
3. ILA 选择 Basic Trigger，窗口 2048 samples，触发位置建议 512（约 25%）。
   完整窗口在 27 MHz 下仅约 75.9 us，不能覆盖整个 HEX 文件。
4. 每次独立复现都重新系统复位并发送完整 HEX；CPU 单独复位不会清历史计数器。
   如果 sys_reset 会停 PLL，复位期间 ILA 无采样时钟；先松开复位、等时钟稳定，
   再 arm ILA，最后开始串口下载。下载完成前 CPU 仍在复位，可捕获启动事件。

### 2. 第一轮：EOF 与 CPU 释放

触发 `dbg_uart_status[2] == 1`（final_done）。使用单 bit 比较或带 mask 的比较，
不要把整个 32-bit 总线设为等于 4。

预期先出现 final_done，接着 data_ready（bit1）置位；
`dbg_boot_status[2]`、`[3]` 随后为 1，busy（bit0）为 0。
UART 启动模式 FLASH_BOOT_ENABLE=0 时，boot_done（bit1）为 0 是正常现象。

- final_done 不出现且 HEX state=12/error=1：检查下载数据/校验/换行。
- state=13：等待 EOF 后的 LF；state=14：等待 TX ready。
- data_ready=1、busy=0，但 CPU reset_n 一直为 0：检查复位链。
- `dbg_load_en[8]=1` 而低 8 位全为 0：本次写地址不在 IMEM/DMEM 下载范围，数据被丢弃。

### 3. 第二轮：第一笔取指和 RAM 数据

重新复现，触发 `dbg_if_status[1:0] == 2'b11`，
并将 `dbg_if_addr == 32'h00001000` 作为 AND 条件。

检查首地址 0x1000，随后 rvalid/rready 握手返回 rresp=00。
当前随目录附带的旧 test.ihex 在 0x1000 的字值是 0x1AC0006F；
务必与实际下载 HEX 的低地址字节按小端重组结果比较，不固定依赖这个旧值。
指令可能压缩或预取，地址握手计数不是退休指令计数。

- CPU 已释放却无取指：看 arvalid/arready，区分 CPU 未发请求或总线不响应。
- 地址握手后没有返回：检查 AXI 桥和 BRAM 读延迟。
- 返回全零/错误指令：检查下载端字节地址、IMEM byte enable 和 BRAM 地址。
- rresp 非零：检查取指地址映射；seen[5] 会保留错误历史。

若怀疑 DMEM 下载，另开一轮：触发 `dbg_load_en[8]=1`，并添加
`dbg_load_addr >= 0x7ff80000`、`dbg_load_addr < 0x7ffa0000`，
检查低 4 位 byte enable 和数据。IMEM 对应范围 0x1000..0x20fff。

### 4. 第三轮：CPU 的 UART 访问

重新复现，触发 `dbg_mcu_status[3] == 1` AND `dbg_mcu_addr == 0`。
该事件是 CPU 写 UART TX，`dbg_mcu_wdata` 应出现首个待发送字符。

对应 CPU 数据总线地址为 TX=0x80000000、TX_ST=0x80000004、
INT=0x8000000c、INT_EN=0x80000010；MCU 地址分别为 0、1、3、4。
AW 和 W 是独立通道，只在各自握手时解释地址/数据，不要求同一拍。

- 数据 AXI 已写 0x80000000，但无 UART write：检查地址路由、MCU decode、WSTRB。
- UART write 出现：看 status[9] 固件 valid、[8] TX ready、[10] busy、[7] TX 引脚。
  valid 与 ready 应能交叠，随后 TX 出现起始位。
- 有 TX 引脚波形但 PC 不显示：检查顶层管脚、接收工具、波特率及端口占用。
  一帧 8N1 约 86.8 us，超过 2048 点窗口；可把窗口位置设到触发起点，
  或重新构建时将 C_DATA_DEPTH 改为 4096 以观察完整字符。
- 无 UART write 但持续取指：改用 Run Trigger Immediate 采样，检查最后取指地址及
  data AXI 是否卡在某个读写。data 返回错误由 seen[6]/[7] 锁存。

### 5. 无需再次等待触发，先看历史

下载结束、终端无输出时执行 Run Trigger Immediate，读取：

| 历史结果 | 下一步 |
|---|---|
| load_count=0 | 检查下载写使能和地址范围；点号不代表 RAM 已写入 |
| seen[1]=0 | 下载完成状态从未置位 |
| seen[2]=1、seen[3]=0 | CPU 已释放但没有取指地址握手 |
| seen[3]=1、seen[4]=0 | 有取指、没有固件 TX 写入；抓取指返回和 data 总线 |
| seen[4]=1 | CPU 至少写过 UART；继续检查 UART valid/ready/TX |
| seen[5:7] 任意为 1 | 曾有非 OKAY 总线返回；分别捕获 I-R、D-R、D-B 响应 |

计数器是 32-bit 回绕计数，不表示程序一定执行成功。
建议导出第一笔取指、UART 写入附近的 ILA 波形 CSV，连同 bit/ltx 构建时间、
下载文件名、seen/load_count/fetch_count/uart_tx_count/last_if_addr 一起保存。


## 下载后提示 debug hub 未检测到 / Dropping ila_boot

这组提示表示硬件 debug 发现失败，不足以证明 bitstream 没有 ILA。
LTX 中存在 ila_boot 只说明探针文件描述了它，不能证明板上使用了配套 bit。
先不要修改 FW。

1. 松开 sys_reset，确认板上差分时钟在运行。当前 sys_reset 会复位 MMCM，
   使 osc_clk 停止；即使成功 JTAG 下载，debug hub 仍可能无法访问。
2. 在 Hardware Manager 已连接目标、选中 xczu9 后执行：

   ```tcl
   source /path/to/project_fpga_riscv/scripts/refresh_boot_debug.tcl
   ```

   此脚本打印 PROGRAM.FILE/PROBES.FILE，关闭并以 1 MHz JTAG 重新打开当前目标，
   按新构建的 USER1 设置 BSCAN_SWITCH_USER_MASK=0001，然后刷新；不会重新烧录。
   对旧构建先核对实际扫描链；USER1/2/3/4 对应 mask 0001/0010/0100/1000。
3. 确认 PROGRAM.FILE 和 PROBES.FILE 来自同一个 `boot_debug/` 目录，
   不要把项目 `impl_1/top.bit` 与 `boot_debug.ltx` 混用。
   路径属性只是 GUI 当前选择，不是已编程内容的证明；有疑问就配对重新下载。
4. 仍失败时，用更新后的 build_boot_debug.tcl 重建。insert_boot_ila.tcl
   现在显式把 dbg_hub 时钟接到 osc_clk，设置输入频率 27 MHz、禁用分频、
   固定 USER1；构建报告 `boot_debug_cores.txt` 会记录调试核和配置。
5. 在独立 Vivado 会话检查本次构建的 routed DCP（不要用另一次 impl_1）：

   ```tcl
   open_checkpoint /path/to/boot_debug/boot_debug_routed.dcp
   get_debug_cores
   get_property C_USER_SCAN_CHAIN [get_debug_cores dbg_hub]
   get_property C_CLK_INPUT_FREQ_HZ [get_debug_cores dbg_hub]
   report_property [get_debug_ports dbg_hub/clk]
   ```

   应存在 ila_boot 和 dbg_hub，USER chain=1、频率属性=27000000。
   这些是网表/配置检查，不能证明物理板上时钟正在跳变。

本工程 27 MHz hub 不适合使用默认可能为 15 MHz 的 JTAG。
AMD UG908 要求 JTAG 时钟比 hub 时钟慢至少 2.5 倍，初次发现建议 1 MHz。
若降速、配对重新编程后仍失败，检查 MMCM 输入时钟、sys_reset 电平及 locked。
此前 UART 可打印点号仅证明当时 osc_clk 有运行，不能证明这次刷新时仍运行。

参考：[AMD UG908 时钟指南](https://docs.amd.com/r/2023.2-English/ug908-vivado-programming-debugging/Debug-Cores-Clocking-Guidelines)、
[AMD UG908 编程与扫描链](https://docs.amd.com/r/2020.2-English/ug908-vivado-programming-debugging/Programming-the-Hardware-Device)。
