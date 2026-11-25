#include "Vtb_sha256_cpu.h"

#include <fstream>
#include <iostream>
#include <string>

int main(int argc, char **argv)
{
    if (argc != 3) return 1;
    const std::string mode(argv[2]);
    std::ifstream image(argv[1]);
    if (!image) return 1;

    Vtb_sha256_cpu model;
    const auto tick = [&]() {
        model.clk = 0;
        model.eval();
        model.clk = 1;
        model.eval();
    };
    model.reset_n = 0;
    model.boot_busy = 1;
    model.boot_done = 0;
    model.boot_wr_en = 0;
    model.suppress_done = 0;
    tick();
    tick();
    model.reset_n = 1;
    unsigned address, data;
    while (image >> std::hex >> address >> data) {
        model.boot_wr_en = 1;
        model.boot_wr_addr = address;
        model.boot_wr_data = data;
        tick();
    }
    model.boot_wr_en = 0;
    model.boot_busy = 0;
    model.boot_done = 1;

    unsigned start_cycle = 0, blocks = 0, masked_polls = 0;
    for (unsigned cycle = 0; cycle < 50000000; ++cycle) {
        model.clk = 0;
        model.eval();
        const bool polling = model.sha_poll && model.suppress_done;
        const bool starting = model.sha_start;
        if (model.wr && model.addr == 0x2000) {
            if (model.wdata == 1) {
                start_cycle = cycle;
            } else if (model.wdata == 2 && start_cycle &&
                       (mode == "sw" ? blocks == 0 : blocks > 2) &&
                       (mode != "timeout" || masked_polls == 256)) {
                std::cout << "PASS " << mode << ": " << cycle - start_cycle
                          << " CPU cycles, " << blocks << " hardware starts\n";
                return 0;
            } else {
                std::cerr << "SHA-256/LMS verification or hardware path check failed\n";
                return 1;
            }
        }
        model.clk = 1;
        model.eval();
        if (starting && ++blocks == 1 && mode == "timeout") {
            model.suppress_done = 1;
        }
        if (polling && ++masked_polls == 256) {
            model.suppress_done = 0;
        }
    }
    std::cerr << "CPU simulation timed out\n";
    return 1;
}
