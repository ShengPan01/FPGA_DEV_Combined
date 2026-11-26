# LMS Verification

Ported without algorithm changes from the adjacent Quincy_FreeRTOS project.
C sources are in `source/lms`; all public headers and test-vector headers are
in `inc/lms`. The original Cisco license is retained in `LICENSE-Cisco.txt`.
Both `Makefile` and `Makefile_GCC` include the module with `LMS_VERIFY_ONLY=1`;
key generation and signing are not enabled. No FreeRTOS dependency is required.

## Interfaces

- `lms_verify()` validates a raw 48-byte LMS public key and signature.
- `lms_verify_selftest()` runs the RFC 9858 Appendix A.4 H20/W4 vector plus
  modified-message, modified-public-root and truncated-signature rejection tests.
- `lms_verify_selftest_timed()` times only the valid signature verification.
- `lms_verify_benchmark()` measures all 20 combinations of H5/H10/H15/H20/H25
  and W1/W2/W4/W8, with three repetitions per combination by default.
  `LMS_BENCHMARK_REPETITIONS` in `inc/lms/lms_selftest.h` controls repetitions.

## Firmware Integration

After `InitMCU()`, the banner and `spi_init()`, `main()` calls
`flash_verify_on_boot()`. It reads the 48-byte public key at Flash `0x26000`,
derives the exact signature size from its LMS/LMOTS types (at most 4 KiB),
reads the raw signature at `0x25000`, and verifies all 147456 bytes at
`0x1000..0x24fff`, including FF padding. The message is streamed in 256-byte
chunks through `lms_verify_stream()`; the signature buffer uses 4 KiB BSS.
Neither the public key nor the certificate is compiled into the boot verifier.

UART reports `LMS Flash verify: PASS; continuing` or `FAIL` with the reason.
All result paths return to `Init done` and the command loop. SPI polling is
bounded and restores the previous SPI configuration on return. This adds
startup latency; it does not block execution on authentication failure.
The timed self-test and benchmark remain available through debug commands.

Host regression: build the shared library as shown in `tool/README.md`, then
run `python3 tool/test_lms_stream.py /tmp/fw_lms_verify.so` and
`python3 tool/test_flash_verify_boot.py` (mock SPI registers, real boot verifier).

Timing uses the existing `get_timer_tick()` 64-bit hardware counter at
0x48001000/0x48001004. Conversion uses `TIME_1ms` from `inc/timer.h`, currently
27000 ticks/ms (27 MHz), not the Quincy project's 24 MHz configuration.
Confirm the actual counter frequency on the FPGA. UART output is outside each
timed verification; any enabled interrupts can contribute to elapsed time.
A stalled counter is reported as unavailable and causes the benchmark to fail.

The module uses stack buffers, no heap allocation or files. Benchmark fixtures
are deterministic test data stored as const arrays in ROM, not production keys.
These checks test the algorithm, not authenticity of the running firmware.
Build success does not establish hardware correctness or measured performance;
confirm the UART PASS messages and timing on the target board.