#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os
import re

def analyze_map():
    # Use a breakpoint in the code line below to debug your script.
    # Press Ctrl+F8 to toggle the breakpoint.
    show_detail = False
    if (show_detail == True):
        if os.name =="posix":
            print("Linux")
        elif os.name =="nt":
            print("Windows")
        else:
            print(os.name)
    mapf = open("output"+os.sep+"test.map", 'r')
    line = mapf.readline()
    dram_addr = 0
    while line:
        # Match memory-region rows, never references in ASSERT/ORIGIN or symbols.
        # Both Codasip and GNU ld emit: name origin length [attributes].
        region = re.match(
            r"^\s*(imem|dmem|initmem)\s+(0[xX][0-9a-fA-F]+)\s+"
            r"(0[xX][0-9a-fA-F]+)(?:\s|$)", line)
        if region:
            name, origin, length = region.groups()
            if name == "imem":
                imem_size = int(length, 16)
            elif name == "dmem":
                dmem_size = int(length, 16)
            else:
                dram_addr = int(origin, 16)
        if (line.find("_ftext") != -1):
            tmp = line.split()
            starti_addr = tmp[0]
        if (line.find("_etext") != -1):
            tmp = line.split()
            endi_addr = tmp[0]
            text_size = int(endi_addr,16) - int(starti_addr,16)
        if (line.find("_frodata") != -1):
            tmp = line.split()
            startrodata_addr = tmp[0]
        if (line.find("_erodata") != -1):
            tmp = line.split()
            rodata_size = int(tmp[0],16) - int(startrodata_addr,16)
            '''
            if (int(startd_addr,16) < 0x19000):
                endi_addr = tmp[0]
                init_data_size = 0
            else:
                init_data_size = -rodata_size
            '''
        if (line.find("ADDR (.sdata_location)") != -1):
            tmp = line.split()
            startsd_addr = tmp[0]
        if (line.find("_fdata = .") != -1):
            tmp = line.split()
            startd_addr = tmp[0]
        if ((line.find("_edata = .") != -1) or
                (line.find("_esdata = .") != -1)):
            tmp = line.split()
            endinitdata_addr = tmp[0]
        if (line.find(" _stack_end = .") != -1):
            tmp = line.split()
            starts_addr = tmp[0]
        if (line.find(" _stack = .") != -1):
            tmp = line.split()
            ends_addr = tmp[0]
        if (line.find(" _end = .") != -1):
            tmp = line.split()
            endd_addr = tmp[0]
            init_data_size = int(endinitdata_addr,16) - int(startd_addr,16)
        if (line.find("./output/test.xexe") != -1):
            str = "Code size: %s (%s~%s)" \
                  %(hex(int(endi_addr, 16)-int(starti_addr,16)),\
                    hex(int(starti_addr, 16)), hex(int(endi_addr, 16)))
            if (show_detail == True):
                print(str)
            str = "Variable size: %s (%s~%s)" \
                  %(hex(int(endd_addr, 16)-int(startd_addr,16)),\
                    hex(int(startd_addr, 16)), hex(int(endd_addr, 16)))
            if (show_detail == True):
                print(str)
            str = "Data size: %s (%s~%s)" \
                  %(hex(int(startsd_addr, 16)-int(startd_addr,16)),\
                    hex(int(startd_addr, 16)), hex(int(startsd_addr, 16)))
            if (show_detail == True):
                print(str)
            str = "Stack size: %s (%s~%s)" \
                  %(hex(int(ends_addr, 16)-int(starts_addr,16)),\
                    hex(int(starts_addr, 16)), hex(int(ends_addr, 16)))
            if (show_detail == True):
                print(str)
            code_size = int(endi_addr, 16)-int(starti_addr,16) + rodata_size
            #if dram init value use hardware memcpy, not include in code size
            if (dram_addr == 0):
            	code_size += init_data_size
            str = "ROM (imem) used size: %s (%.1fK/%dK, %.2f%%)" \
                  %(hex(code_size),\
                    float(code_size)/1024,(imem_size)/1024, \
                    float(code_size)/float(imem_size)*100)
            print(str)
            str = "RAM (dmem) used size: %s (%.1fK/%dK, %.2f%%)" \
                  %(hex(int(endd_addr, 16)-int(startd_addr,16)),\
                    float(int(endd_addr, 16)-int(startd_addr,16))/1024,dmem_size/1024, \
                    float(int(endd_addr, 16)-int(startd_addr,16))/float(dmem_size)*100)
            print(str)
        line = mapf.readline()
    mapf.close()

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    analyze_map()

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
