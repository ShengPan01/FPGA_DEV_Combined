# UART 下载固件并观察 FW 输出

在工作区根目录运行（需要 Vivado/XSim，并已配置 Vivado 环境）：

```bash
vivado -mode batch -source project_fpga_riscv/sim/run_uart_firmware.tcl
```

也可以在已打开该工程的 Vivado Tcl Console 中执行：

```tcl
source /path/to/project_fpga_riscv/sim/run_uart_firmware.tcl
```

默认读取 `riscv_fw_base/output/test.ihex`，不需要转换成 mem。可在启动 Vivado 前通过环境变量 `FW_IHEX` 指定其他 IHEX 文件。脚本会选择 `tb_uart_firmware` 作为仿真顶层。

流程：复位并等待 PLL 锁定 → 按 115200 baud、8N1、低位先发驱动 RX → 每条记录的 LF 后等待 TX 返回 `.` → RTL 自行完成 IHEX 解析、RAM 写入和 CPU 复位释放 → 从物理 TX 引脚解码、打印并记录 FW 输出 → 匹配 `Init done` 后报告 PASS 并结束。

终端和 `uart_console.log` 包含串口实际输出（包括下载阶段的点号）。日志位于 XSim 工作目录，通常是 `project_fpga_riscv/project_fpga_riscv.sim/sim_1/behav/xsim/`。成功结束消息：

```text
PASS: UART-downloaded firmware printed Init done (... fetches)
```

testbench 检查 IHEX parser error、UART 起始位/停止位、下载应答、首次取指地址和总超时。缺失应答、缺失 EOF 或 FW 没有输出成功字符串会最终触发超时并打印下载/取指计数。默认总超时为 40000 ms 仿真时间，可通过 `TIMEOUT_MS` plusarg 修改；日志路径可通过 `UART_LOG` plusarg 修改。文件必须包含最后一个换行符。

当前文件包含 5969 条记录、95418 数据字节，下载约需 24 秒仿真时间。完整 CPU/外设仿真的实际运行时间可能很长；默认不记录全量波形。FW 的 SPI MISO 和 I2C 总线使用静态上下拉，与现有 `tb_firmware` 一致，不模拟真实外设内容。

该 testbench 不强制写 RAM，也不强制置位下载完成信号。预测器 RAM 的初值沿用已有 `tb_firmware` 的仿真初始化方式。它修改的是仿真工程顶层选择，不修改综合 RTL。

验证状态：已检查默认 IHEX 的所有记录长度、校验和及 EOF；当前 Linux 环境没有 Vivado/XSim，尚未运行完整系统仿真，不能据此声称已经看到 FW 的实际输出。
