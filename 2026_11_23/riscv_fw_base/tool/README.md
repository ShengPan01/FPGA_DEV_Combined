# 固件 LMS 签名

在程序目录执行（仅需 Python 3 标准库）：

```sh
python3 tool/sign_ihex.py
# 或指定原始 ihex；输出始终与输入同目录
python3 tool/sign_ihex.py output/test.ihex --height 5 --w 4
```

输入使用链接器的 CPU 地址：IMEM `0x1000..0x20fff`、DRAM
`0x7ff80000..0x7ff83fff`。空洞和尾部全部以 `0xff` 填充；超出区域、
冲突重叠、校验和错误及缺失 EOF 均报错。输入应为原始 `test.ihex`，
不能把签名后的 Flash 地址文件再次作为输入。

输出 `test_signed.ihex` 使用物理 Flash 地址，32 字节数据记录：

| 内容 | Flash 起址 | 长度 |
| --- | --- | --- |
| IMEM（含填充） | `0x1000` | `0x20000` / 128 KiB |
| DRAM（含填充） | `0x21000` | `0x4000` / 16 KiB |
| 签名证书区 | `0x25000` | `0x1000` / 4 KiB |

证书区起始存放原始 LMS 签名（默认 1380 字节），余下填充 `0xff`。
Flash `0x000000..0x000fff` 未分配，`0x027000..0x3fffff` 为 unused
（3940 KiB），工具和板端烧录命令均拒绝向这两段写入。
`0x026000..0x026fff` 单独保留给公钥，仅前 48 字节允许写入。
CPU DMEM 仍为 `0x7ff80000..0x7ff9ffff`（128 KiB）；只有前 16 KiB
初始值占用 Flash，BSS、堆和栈可继续使用后续 RAM。

签名消息为完整的 `IMEM || DRAM` 147456 字节，直接签原始内容，不是签
SHA256 摘要。签名没有 HSS 层数头、额外封装或公钥。默认参数为
`LMS_SHA256_M24_H5`（type 10）和 `LMOTS_SHA256_N24_W4`（type 7），
匹配 `source/lms/lms.c` 的 24 字节截断 SHA256 实现。
参数依据 RFC 8554 和 RFC 9858：
https://www.rfc-editor.org/rfc/rfc8554.html
https://www.rfc-editor.org/rfc/rfc9858.html

同时输出：

- `test_signed.lms.json`：参数、地址、实际输入字节数、公钥十六进制、消息与输入 SHA256。
- `test_signed.pub.bin`：48 字节原始 LMS 公钥，可直接传入 `lms_verify()`。
- `test_signed.pub.h`：相同公钥的 C 数组。
- `test_signed.sig.bin`：原始 LMS 签名，与 Flash `0x25000` 起的内容一致。

支持 H5/H10 和 W2/W4/W8；W1 签名超过 4 KiB，生成文件前拒绝。
高树参数会增加生成时间。
每次运行创建新随机 SEED、I 和 C，只使用 q=0，运行结束不保存私钥。
因此每次重新签名公钥都会变化，需通过可信方式更新验签端公钥。
本工具不提供固定生产公钥及持久化签名状态管理。

## 单独烧写公钥

```sh
# 默认读取 output/test_signed.pub.bin，输出 output/test_signed.pub.ihex
python tool/public_key_ihex.py
# 指定输入和输出（输出必须与输入不同）
python tool/public_key_ihex.py output/test_signed.pub.bin -o output/public_key.ihex
python tools/flash_upload.py --port COM3 --file output/test_signed.pub.ihex
```

输入为 `sign_ihex.py` 输出的 48 字节 `.pub.bin`，工具检查长度和
LMS/LMOTS 类型码。输出使用 Flash 物理地址 `0x026000..0x02602f`，
仅含 48 字节原始公钥，不生成新密钥，不改变原签名文件。
默认输出与输入同目录，扩展名由 `.bin` 改为 `.ihex`。

板端必须先更新包含新地址支持的 `source/flash_cmd.c`。
单独烧写公钥仅擦除公钥所在的 4 KiB 扇区，不擦除固件及签名扇区；
公钥扇区的其他字节擦除后为 FF。FPGA 引导逻辑不认证此公钥；firmware 启动时会从 Flash 读取它用于自动验签。每次重新签名后需同步转换并更新配套公钥。

运行转换和地址隔离测试：`python tool/test_public_key_ihex.py`。

## 串口烧录

本次同步修改了 `tools/flash_upload.py` 和 `source/flash_cmd.c`，允许
Flash `0x1000..0x25fff` 及公钥 `0x26000..0x2602f` 的物理地址，并把旧格式 CPU DRAM 地址映射到
RTL 当前使用的 `0x21000`。**必须先通过原有调试/加载方式更新板端
烧录固件**；旧版板端只接受旧布局，不能直接烧录此文件。

```sh
python3 tools/flash_upload.py --port /dev/ttyUSB0 --file output/test_signed.ihex
```

当前 RTL 默认对 IMEM 和 DMEM 各读取 128 KiB；DMEM 的有效初始值仅为前 16 KiB。
后续读取范围包含证书、公钥和未使用区，不能将这些 RAM 副本作为验签输入。
链接脚本检查 DMEM 初始值不能超过 16 KiB。
firmware 上电自动验签，直接从 Flash 读取 FW、证书及公钥；成功和失败均打印串口信息，
随后继续初始化和命令循环，不阻止程序执行。

## 主机验证

在程序目录执行：

```sh
gcc -shared -fPIC -O2 -Iinc/lms source/lms/lms.c source/lms/sha256.c source/lms/endian.c -o /tmp/fw_lms_verify.so
python3 tool/check_signed_ihex.py /tmp/fw_lms_verify.so
```

检查原 C 验签、篡改拒绝、四种 W 参数、串口 HEX 校验、连续 Flash
地址及整个输出与填充后原始数据和签名逐字节一致。

## 上电验签

重新构建 firmware 后，必须重新运行签名工具，并同步烧写新的
`test_signed.ihex` 和配套的 `test_signed.pub.ihex`，再复位检查串口。
签名范围固定为完整的 128 KiB IMEM + 16 KiB DRAM（包含 FF 填充）。
公钥参数决定签名长度，类型不支持、长度超出 4 KiB 证书区、证书格式错误、
签名不匹配或 SPI 超时均输出 FAIL；正常匹配输出 PASS。两种结果均继续执行。

这是运行后诊断校验：公钥和 FW 均可从同一 Flash 更新，没有不可变信任根，
不能阻止同时替换 FW、签名和公钥，也不是执行前的安全启动。

分块读取回归测试：`python3 tool/test_lms_stream.py /tmp/fw_lms_verify.so`。

启动集成回归：`python3 tool/test_flash_verify_boot.py`（需要主机 GCC）。
使用真实启动验签代码和模拟 SPI 寄存器，检查 Flash 读取范围、成功/失败返回、
FW/证书/公钥篡改、空白公钥、过大证书、SPI 超时及配置恢复。
