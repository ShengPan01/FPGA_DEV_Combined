# 运行时串口烧写 W25Q32FV

固件新增命令（反斜杠是现有终端命令的起始字符，按 Enter 执行）：

- `\flashbegin`：检查 JEDEC ID EF 40 16，启动烧写会话，返回 `FLASH READY`。
- `\flashhex :...`：接收一条 Intel HEX 记录，最多 48 字节数据；校验 checksum，按需擦除 4 KB 扇区，逐字节编程并回读校验，返回 `FLASH OK`。EOF 返回 `FLASH DONE`。
- `\flashabort`：退出烧写会话。
- `\flashread 1000 40`：读取 Flash 物理地址 0x1000 起的 0x40 字节，每行显示 16 字节。地址及长度为十六进制，可带 0x，单次最多 0x1000 字节。

## 电脑端选择 test.ihex

先使用更新后的 Makefile 或 Makefile_GCC 构建并运行 FW。

安装依赖：`python -m pip install pyserial`。
关闭其他占用串口的终端，再运行：

```sh
python tools/flash_upload.py --port COM3
# Linux 示例
python3 tools/flash_upload.py --port /dev/ttyUSB0 --file output/test.ihex
```

默认 115200，可用 `--baud` 修改。省略 `--file` 会弹出文件选择框（需要 Python tkinter）。工具选择并完整校验文件后，自动发送烧写命令；每条记录收到应答才发送下一条，避免 UART 接收溢出。固件单独无法弹出电脑文件选择框，因此选择文件由此工具完成。需要手动操作时，也可先在终端输入 `\flashbegin`；工具连接后会重新初始化会话。

支持 HEX 类型 00/01/02/03/04/05；03/05 为入口元数据，只校验不烧写。工具将数据记录整理为最多 32 字节后传送。

## 地址布局及擦除范围

Flash 容量为 4 MiB，当前布局如下（地址为闭区间）：

| Flash 地址 | 大小 | 内容 |
| --- | --- | --- |
| 0x000000 .. 0x000FFF | 4 KiB | 未分配，禁止烧录 |
| 0x001000 .. 0x020FFF | 128 KiB | IMEM 镜像 |
| 0x021000 .. 0x024FFF | 16 KiB | DMEM 初始值镜像 |
| 0x025000 .. 0x025FFF | 4 KiB | 签名证书（原始 LMS 签名，剩余填 FF） |
| 0x026000 .. 0x026FFF | 4 KiB | 公钥独立扇区，48 字节原始 LMS 公钥，其余保留 |
| 0x027000 .. 0x3FFFFF | 3940 KiB | unused，禁止烧录 |

`output/test_signed.ihex` 直接使用物理地址。也支持原始 `test.ihex`
的 CPU 地址，采用固定映射：

| HEX 地址 | Flash 物理地址 |
| --- | --- |
| 0x00001000 .. 0x00020FFF | 同 HEX 地址 |
| 0x7FF80000 .. 0x7FF83FFF | 0x00021000 .. 0x00024FFF |
| 0x00021000 .. 0x00025FFF | 同 HEX 地址（DMEM 和签名证书） |
| 0x00026000 .. 0x0002602F | 同 HEX 地址（原始 LMS 公钥） |

其他数据地址拒绝写入。读取数据段例如 `\flashread 21000 40`，
读取签名例如 `\flashread 25000 40`。
读取公钥使用 `\flashread 26000 30`（长度 0x30，即 48 字节）。

单独生成、烧写公钥（先编译并运行支持此地址的新板端烧录固件）：

```sh
python tool/public_key_ihex.py output/test_signed.pub.bin
python tools/flash_upload.py --port COM3 --file output/test_signed.pub.ihex
```

公钥文件仅含 `0x026000..0x02602F` 的 48 字节，不含固件或签名。
烧写只擦除 `0x026000..0x026FFF` 扇区，剩余字节变为 FF，不能在此扇区
存放其他需保留的数据。重新签名后应重新转换并烧写与新签名配套的公钥。

每个涉及的扇区在本次会话中首次写入时擦除一次，扇区内未提供的字节变为 FF，范围外扇区保留。应确保这些区域未存放需要保留的 FPGA 配置或其他数据。烧写错误、中断或断电会留下不完整镜像，重新完整上传即可；不支持原子升级或断点续传。会话期间请勿交错执行其他 SPI 命令。

此功能将 HEX 中的有效数据烧入 Flash，不保存 HEX 文本，也不修改当前 RAM 中运行的程序。
复位后的 RTL 引导程序从 0x1000 加载 128 KiB IMEM，从 0x21000 加载
128 KiB DMEM（`spi_flash_boot.REGION_BYTES` 默认值两区共用）。其中仅前
16 KiB DMEM 是有效初始值，后续包含证书、公钥及未使用区域；启动代码
会清零 BSS，firmware 验签直接读取 Flash，不使用这些 RAM 副本。
CPU DMEM 总容量仍为 128 KiB；`.data`、`.sdata` 等初始值限于前 16 KiB，
BSS、堆、栈继续使用 RAM。签名生成和公钥文件说明见 `tool/README.md`。
使用新文件前需更新板端烧录固件，并重新构建加载 FPGA 引导逻辑。

## 上电 LMS 验签

`main()` 在 SPI 初始化后校验 Flash `0x001000..0x024fff` 共 144 KiB，
证书从 `0x025000` 读取，公钥从 `0x026000` 读取。
证书为原始 LMS 签名，无 X.509/HSS 封装；其长度由公钥中的类型码确定，
不得超过 4 KiB。UART 输出 PASS 或 FAIL（含原因），随后继续执行到
`Init done` 和原命令循环。SPI 轮询超时也返回，不进入死循环。
更新 firmware 后需重新签名并烧写配套公钥；板上仍需验证实际 SPI 和串口时序。
