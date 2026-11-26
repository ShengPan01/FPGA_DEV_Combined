set_property PACKAGE_PIN AL8 [get_ports sys_diff_clk_p]
set_property PACKAGE_PIN AL7 [get_ports sys_diff_clk_n]

set_property PACKAGE_PIN AE14 [get_ports sys_reset]
set_property IOSTANDARD LVCMOS33 [get_ports sys_reset]


set_property PACKAGE_PIN D12 [get_ports uart_cts]
set_property PACKAGE_PIN E12 [get_ports uart_rts]
set_property PACKAGE_PIN E13 [get_ports uart_rx]
set_property PACKAGE_PIN F13 [get_ports uart_tx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rts]
set_property IOSTANDARD LVCMOS33 [get_ports uart_cts]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx]

set_property IOSTANDARD DIFF_SSTL12 [get_ports sys_diff_clk_p]


#spi
set_property IOSTANDARD LVCMOS33 [get_ports spi_ck]
set_property IOSTANDARD LVCMOS33 [get_ports spi_cs]
set_property IOSTANDARD LVCMOS33 [get_ports spi_miso]
set_property IOSTANDARD LVCMOS33 [get_ports spi_mosi]
set_property PACKAGE_PIN A21 [get_ports spi_cs]
# Keep NOR deselected while runtime GPIO drivers are still disabled.
set_property PULLUP true [get_ports spi_cs]
set_property PACKAGE_PIN A22 [get_ports spi_mosi]
set_property PACKAGE_PIN B20 [get_ports spi_ck]
set_property PACKAGE_PIN A20 [get_ports spi_miso]


#imu
set_property PACKAGE_PIN AF15 [get_ports rst_iic]
set_property IOSTANDARD LVCMOS33 [get_ports rst_iic]

set_property PACKAGE_PIN J11 [get_ports imu_sda]
set_property PACKAGE_PIN J10 [get_ports imu_scl]
set_property IOSTANDARD LVCMOS33 [get_ports imu_sda]
set_property IOSTANDARD LVCMOS33 [get_ports imu_scl]

#Mode_gpio status
set_property PACKAGE_PIN D20 [get_ports {mode_gpio[0]}]
set_property PACKAGE_PIN E20 [get_ports {mode_gpio[1]}]
set_property PACKAGE_PIN D22 [get_ports {mode_gpio[2]}]
set_property PACKAGE_PIN E22 [get_ports {mode_gpio[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {mode_gpio[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mode_gpio[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mode_gpio[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mode_gpio[3]}]


#LED status
set_property PACKAGE_PIN AG14 [get_ports {mio23_led[0]}]
set_property PACKAGE_PIN AF13 [get_ports {mio23_led[1]}]
set_property PACKAGE_PIN AE13 [get_ports {mio23_led[2]}]
set_property PACKAGE_PIN AJ14 [get_ports {mio23_led[3]}]
set_property PACKAGE_PIN AJ15 [get_ports {mio23_led[4]}]
set_property PACKAGE_PIN AH13 [get_ports {mio23_led[5]}]
set_property PACKAGE_PIN AH14 [get_ports {mio23_led[6]}]
set_property PACKAGE_PIN AL12 [get_ports {mio23_led[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {mio23_led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mio23_led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mio23_led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mio23_led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mio23_led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mio23_led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mio23_led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mio23_led[7]}]




# Instruction BRAM port signals (after the download/AXI muxes).



create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_wiz_inst/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {bk3imcpj_wrapper/dbg_load_count[0]} {bk3imcpj_wrapper/dbg_load_count[1]} {bk3imcpj_wrapper/dbg_load_count[2]} {bk3imcpj_wrapper/dbg_load_count[3]} {bk3imcpj_wrapper/dbg_load_count[4]} {bk3imcpj_wrapper/dbg_load_count[5]} {bk3imcpj_wrapper/dbg_load_count[6]} {bk3imcpj_wrapper/dbg_load_count[7]} {bk3imcpj_wrapper/dbg_load_count[8]} {bk3imcpj_wrapper/dbg_load_count[9]} {bk3imcpj_wrapper/dbg_load_count[10]} {bk3imcpj_wrapper/dbg_load_count[11]} {bk3imcpj_wrapper/dbg_load_count[12]} {bk3imcpj_wrapper/dbg_load_count[13]} {bk3imcpj_wrapper/dbg_load_count[14]} {bk3imcpj_wrapper/dbg_load_count[15]} {bk3imcpj_wrapper/dbg_load_count[16]} {bk3imcpj_wrapper/dbg_load_count[17]} {bk3imcpj_wrapper/dbg_load_count[18]} {bk3imcpj_wrapper/dbg_load_count[19]} {bk3imcpj_wrapper/dbg_load_count[20]} {bk3imcpj_wrapper/dbg_load_count[21]} {bk3imcpj_wrapper/dbg_load_count[22]} {bk3imcpj_wrapper/dbg_load_count[23]} {bk3imcpj_wrapper/dbg_load_count[24]} {bk3imcpj_wrapper/dbg_load_count[25]} {bk3imcpj_wrapper/dbg_load_count[26]} {bk3imcpj_wrapper/dbg_load_count[27]} {bk3imcpj_wrapper/dbg_load_count[28]} {bk3imcpj_wrapper/dbg_load_count[29]} {bk3imcpj_wrapper/dbg_load_count[30]} {bk3imcpj_wrapper/dbg_load_count[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 16 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {bk3imcpj_wrapper/dbg_data_status[0]} {bk3imcpj_wrapper/dbg_data_status[1]} {bk3imcpj_wrapper/dbg_data_status[2]} {bk3imcpj_wrapper/dbg_data_status[3]} {bk3imcpj_wrapper/dbg_data_status[4]} {bk3imcpj_wrapper/dbg_data_status[5]} {bk3imcpj_wrapper/dbg_data_status[6]} {bk3imcpj_wrapper/dbg_data_status[7]} {bk3imcpj_wrapper/dbg_data_status[8]} {bk3imcpj_wrapper/dbg_data_status[9]} {bk3imcpj_wrapper/dbg_data_status[10]} {bk3imcpj_wrapper/dbg_data_status[11]} {bk3imcpj_wrapper/dbg_data_status[12]} {bk3imcpj_wrapper/dbg_data_status[13]} {bk3imcpj_wrapper/dbg_data_status[14]} {bk3imcpj_wrapper/dbg_data_status[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 32 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {bk3imcpj_wrapper/dbg_imem_din[0]} {bk3imcpj_wrapper/dbg_imem_din[1]} {bk3imcpj_wrapper/dbg_imem_din[2]} {bk3imcpj_wrapper/dbg_imem_din[3]} {bk3imcpj_wrapper/dbg_imem_din[4]} {bk3imcpj_wrapper/dbg_imem_din[5]} {bk3imcpj_wrapper/dbg_imem_din[6]} {bk3imcpj_wrapper/dbg_imem_din[7]} {bk3imcpj_wrapper/dbg_imem_din[8]} {bk3imcpj_wrapper/dbg_imem_din[9]} {bk3imcpj_wrapper/dbg_imem_din[10]} {bk3imcpj_wrapper/dbg_imem_din[11]} {bk3imcpj_wrapper/dbg_imem_din[12]} {bk3imcpj_wrapper/dbg_imem_din[13]} {bk3imcpj_wrapper/dbg_imem_din[14]} {bk3imcpj_wrapper/dbg_imem_din[15]} {bk3imcpj_wrapper/dbg_imem_din[16]} {bk3imcpj_wrapper/dbg_imem_din[17]} {bk3imcpj_wrapper/dbg_imem_din[18]} {bk3imcpj_wrapper/dbg_imem_din[19]} {bk3imcpj_wrapper/dbg_imem_din[20]} {bk3imcpj_wrapper/dbg_imem_din[21]} {bk3imcpj_wrapper/dbg_imem_din[22]} {bk3imcpj_wrapper/dbg_imem_din[23]} {bk3imcpj_wrapper/dbg_imem_din[24]} {bk3imcpj_wrapper/dbg_imem_din[25]} {bk3imcpj_wrapper/dbg_imem_din[26]} {bk3imcpj_wrapper/dbg_imem_din[27]} {bk3imcpj_wrapper/dbg_imem_din[28]} {bk3imcpj_wrapper/dbg_imem_din[29]} {bk3imcpj_wrapper/dbg_imem_din[30]} {bk3imcpj_wrapper/dbg_imem_din[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {bk3imcpj_wrapper/dbg_data_waddr[0]} {bk3imcpj_wrapper/dbg_data_waddr[1]} {bk3imcpj_wrapper/dbg_data_waddr[2]} {bk3imcpj_wrapper/dbg_data_waddr[3]} {bk3imcpj_wrapper/dbg_data_waddr[4]} {bk3imcpj_wrapper/dbg_data_waddr[5]} {bk3imcpj_wrapper/dbg_data_waddr[6]} {bk3imcpj_wrapper/dbg_data_waddr[7]} {bk3imcpj_wrapper/dbg_data_waddr[8]} {bk3imcpj_wrapper/dbg_data_waddr[9]} {bk3imcpj_wrapper/dbg_data_waddr[10]} {bk3imcpj_wrapper/dbg_data_waddr[11]} {bk3imcpj_wrapper/dbg_data_waddr[12]} {bk3imcpj_wrapper/dbg_data_waddr[13]} {bk3imcpj_wrapper/dbg_data_waddr[14]} {bk3imcpj_wrapper/dbg_data_waddr[15]} {bk3imcpj_wrapper/dbg_data_waddr[16]} {bk3imcpj_wrapper/dbg_data_waddr[17]} {bk3imcpj_wrapper/dbg_data_waddr[18]} {bk3imcpj_wrapper/dbg_data_waddr[19]} {bk3imcpj_wrapper/dbg_data_waddr[20]} {bk3imcpj_wrapper/dbg_data_waddr[21]} {bk3imcpj_wrapper/dbg_data_waddr[22]} {bk3imcpj_wrapper/dbg_data_waddr[23]} {bk3imcpj_wrapper/dbg_data_waddr[24]} {bk3imcpj_wrapper/dbg_data_waddr[25]} {bk3imcpj_wrapper/dbg_data_waddr[26]} {bk3imcpj_wrapper/dbg_data_waddr[27]} {bk3imcpj_wrapper/dbg_data_waddr[28]} {bk3imcpj_wrapper/dbg_data_waddr[29]} {bk3imcpj_wrapper/dbg_data_waddr[30]} {bk3imcpj_wrapper/dbg_data_waddr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {bk3imcpj_wrapper/dbg_mcu_rdata[0]} {bk3imcpj_wrapper/dbg_mcu_rdata[1]} {bk3imcpj_wrapper/dbg_mcu_rdata[2]} {bk3imcpj_wrapper/dbg_mcu_rdata[3]} {bk3imcpj_wrapper/dbg_mcu_rdata[4]} {bk3imcpj_wrapper/dbg_mcu_rdata[5]} {bk3imcpj_wrapper/dbg_mcu_rdata[6]} {bk3imcpj_wrapper/dbg_mcu_rdata[7]} {bk3imcpj_wrapper/dbg_mcu_rdata[8]} {bk3imcpj_wrapper/dbg_mcu_rdata[9]} {bk3imcpj_wrapper/dbg_mcu_rdata[10]} {bk3imcpj_wrapper/dbg_mcu_rdata[11]} {bk3imcpj_wrapper/dbg_mcu_rdata[12]} {bk3imcpj_wrapper/dbg_mcu_rdata[13]} {bk3imcpj_wrapper/dbg_mcu_rdata[14]} {bk3imcpj_wrapper/dbg_mcu_rdata[15]} {bk3imcpj_wrapper/dbg_mcu_rdata[16]} {bk3imcpj_wrapper/dbg_mcu_rdata[17]} {bk3imcpj_wrapper/dbg_mcu_rdata[18]} {bk3imcpj_wrapper/dbg_mcu_rdata[19]} {bk3imcpj_wrapper/dbg_mcu_rdata[20]} {bk3imcpj_wrapper/dbg_mcu_rdata[21]} {bk3imcpj_wrapper/dbg_mcu_rdata[22]} {bk3imcpj_wrapper/dbg_mcu_rdata[23]} {bk3imcpj_wrapper/dbg_mcu_rdata[24]} {bk3imcpj_wrapper/dbg_mcu_rdata[25]} {bk3imcpj_wrapper/dbg_mcu_rdata[26]} {bk3imcpj_wrapper/dbg_mcu_rdata[27]} {bk3imcpj_wrapper/dbg_mcu_rdata[28]} {bk3imcpj_wrapper/dbg_mcu_rdata[29]} {bk3imcpj_wrapper/dbg_mcu_rdata[30]} {bk3imcpj_wrapper/dbg_mcu_rdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 2 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {bk3imcpj_wrapper/dbg_data_read_status[0]} {bk3imcpj_wrapper/dbg_data_read_status[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {bk3imcpj_wrapper/dbg_uart_tx_count[0]} {bk3imcpj_wrapper/dbg_uart_tx_count[1]} {bk3imcpj_wrapper/dbg_uart_tx_count[2]} {bk3imcpj_wrapper/dbg_uart_tx_count[3]} {bk3imcpj_wrapper/dbg_uart_tx_count[4]} {bk3imcpj_wrapper/dbg_uart_tx_count[5]} {bk3imcpj_wrapper/dbg_uart_tx_count[6]} {bk3imcpj_wrapper/dbg_uart_tx_count[7]} {bk3imcpj_wrapper/dbg_uart_tx_count[8]} {bk3imcpj_wrapper/dbg_uart_tx_count[9]} {bk3imcpj_wrapper/dbg_uart_tx_count[10]} {bk3imcpj_wrapper/dbg_uart_tx_count[11]} {bk3imcpj_wrapper/dbg_uart_tx_count[12]} {bk3imcpj_wrapper/dbg_uart_tx_count[13]} {bk3imcpj_wrapper/dbg_uart_tx_count[14]} {bk3imcpj_wrapper/dbg_uart_tx_count[15]} {bk3imcpj_wrapper/dbg_uart_tx_count[16]} {bk3imcpj_wrapper/dbg_uart_tx_count[17]} {bk3imcpj_wrapper/dbg_uart_tx_count[18]} {bk3imcpj_wrapper/dbg_uart_tx_count[19]} {bk3imcpj_wrapper/dbg_uart_tx_count[20]} {bk3imcpj_wrapper/dbg_uart_tx_count[21]} {bk3imcpj_wrapper/dbg_uart_tx_count[22]} {bk3imcpj_wrapper/dbg_uart_tx_count[23]} {bk3imcpj_wrapper/dbg_uart_tx_count[24]} {bk3imcpj_wrapper/dbg_uart_tx_count[25]} {bk3imcpj_wrapper/dbg_uart_tx_count[26]} {bk3imcpj_wrapper/dbg_uart_tx_count[27]} {bk3imcpj_wrapper/dbg_uart_tx_count[28]} {bk3imcpj_wrapper/dbg_uart_tx_count[29]} {bk3imcpj_wrapper/dbg_uart_tx_count[30]} {bk3imcpj_wrapper/dbg_uart_tx_count[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 5 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {bk3imcpj_wrapper/dbg_mcu_status[0]} {bk3imcpj_wrapper/dbg_mcu_status[1]} {bk3imcpj_wrapper/dbg_mcu_status[2]} {bk3imcpj_wrapper/dbg_mcu_status[3]} {bk3imcpj_wrapper/dbg_mcu_status[4]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 16 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {bk3imcpj_wrapper/dbg_mcu_addr[0]} {bk3imcpj_wrapper/dbg_mcu_addr[1]} {bk3imcpj_wrapper/dbg_mcu_addr[2]} {bk3imcpj_wrapper/dbg_mcu_addr[3]} {bk3imcpj_wrapper/dbg_mcu_addr[4]} {bk3imcpj_wrapper/dbg_mcu_addr[5]} {bk3imcpj_wrapper/dbg_mcu_addr[6]} {bk3imcpj_wrapper/dbg_mcu_addr[7]} {bk3imcpj_wrapper/dbg_mcu_addr[8]} {bk3imcpj_wrapper/dbg_mcu_addr[9]} {bk3imcpj_wrapper/dbg_mcu_addr[10]} {bk3imcpj_wrapper/dbg_mcu_addr[11]} {bk3imcpj_wrapper/dbg_mcu_addr[12]} {bk3imcpj_wrapper/dbg_mcu_addr[13]} {bk3imcpj_wrapper/dbg_mcu_addr[14]} {bk3imcpj_wrapper/dbg_mcu_addr[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 8 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {bk3imcpj_wrapper/dbg_boot_status[0]} {bk3imcpj_wrapper/dbg_boot_status[1]} {bk3imcpj_wrapper/dbg_boot_status[2]} {bk3imcpj_wrapper/dbg_boot_status[3]} {bk3imcpj_wrapper/dbg_boot_status[4]} {bk3imcpj_wrapper/dbg_boot_status[5]} {bk3imcpj_wrapper/dbg_boot_status[6]} {bk3imcpj_wrapper/dbg_boot_status[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 32 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {bk3imcpj_wrapper/dbg_last_if_addr[0]} {bk3imcpj_wrapper/dbg_last_if_addr[1]} {bk3imcpj_wrapper/dbg_last_if_addr[2]} {bk3imcpj_wrapper/dbg_last_if_addr[3]} {bk3imcpj_wrapper/dbg_last_if_addr[4]} {bk3imcpj_wrapper/dbg_last_if_addr[5]} {bk3imcpj_wrapper/dbg_last_if_addr[6]} {bk3imcpj_wrapper/dbg_last_if_addr[7]} {bk3imcpj_wrapper/dbg_last_if_addr[8]} {bk3imcpj_wrapper/dbg_last_if_addr[9]} {bk3imcpj_wrapper/dbg_last_if_addr[10]} {bk3imcpj_wrapper/dbg_last_if_addr[11]} {bk3imcpj_wrapper/dbg_last_if_addr[12]} {bk3imcpj_wrapper/dbg_last_if_addr[13]} {bk3imcpj_wrapper/dbg_last_if_addr[14]} {bk3imcpj_wrapper/dbg_last_if_addr[15]} {bk3imcpj_wrapper/dbg_last_if_addr[16]} {bk3imcpj_wrapper/dbg_last_if_addr[17]} {bk3imcpj_wrapper/dbg_last_if_addr[18]} {bk3imcpj_wrapper/dbg_last_if_addr[19]} {bk3imcpj_wrapper/dbg_last_if_addr[20]} {bk3imcpj_wrapper/dbg_last_if_addr[21]} {bk3imcpj_wrapper/dbg_last_if_addr[22]} {bk3imcpj_wrapper/dbg_last_if_addr[23]} {bk3imcpj_wrapper/dbg_last_if_addr[24]} {bk3imcpj_wrapper/dbg_last_if_addr[25]} {bk3imcpj_wrapper/dbg_last_if_addr[26]} {bk3imcpj_wrapper/dbg_last_if_addr[27]} {bk3imcpj_wrapper/dbg_last_if_addr[28]} {bk3imcpj_wrapper/dbg_last_if_addr[29]} {bk3imcpj_wrapper/dbg_last_if_addr[30]} {bk3imcpj_wrapper/dbg_last_if_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 9 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {bk3imcpj_wrapper/dbg_load_en[0]} {bk3imcpj_wrapper/dbg_load_en[1]} {bk3imcpj_wrapper/dbg_load_en[2]} {bk3imcpj_wrapper/dbg_load_en[3]} {bk3imcpj_wrapper/dbg_load_en[4]} {bk3imcpj_wrapper/dbg_load_en[5]} {bk3imcpj_wrapper/dbg_load_en[6]} {bk3imcpj_wrapper/dbg_load_en[7]} {bk3imcpj_wrapper/dbg_load_en[8]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 32 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {bk3imcpj_wrapper/dbg_fetch_count[0]} {bk3imcpj_wrapper/dbg_fetch_count[1]} {bk3imcpj_wrapper/dbg_fetch_count[2]} {bk3imcpj_wrapper/dbg_fetch_count[3]} {bk3imcpj_wrapper/dbg_fetch_count[4]} {bk3imcpj_wrapper/dbg_fetch_count[5]} {bk3imcpj_wrapper/dbg_fetch_count[6]} {bk3imcpj_wrapper/dbg_fetch_count[7]} {bk3imcpj_wrapper/dbg_fetch_count[8]} {bk3imcpj_wrapper/dbg_fetch_count[9]} {bk3imcpj_wrapper/dbg_fetch_count[10]} {bk3imcpj_wrapper/dbg_fetch_count[11]} {bk3imcpj_wrapper/dbg_fetch_count[12]} {bk3imcpj_wrapper/dbg_fetch_count[13]} {bk3imcpj_wrapper/dbg_fetch_count[14]} {bk3imcpj_wrapper/dbg_fetch_count[15]} {bk3imcpj_wrapper/dbg_fetch_count[16]} {bk3imcpj_wrapper/dbg_fetch_count[17]} {bk3imcpj_wrapper/dbg_fetch_count[18]} {bk3imcpj_wrapper/dbg_fetch_count[19]} {bk3imcpj_wrapper/dbg_fetch_count[20]} {bk3imcpj_wrapper/dbg_fetch_count[21]} {bk3imcpj_wrapper/dbg_fetch_count[22]} {bk3imcpj_wrapper/dbg_fetch_count[23]} {bk3imcpj_wrapper/dbg_fetch_count[24]} {bk3imcpj_wrapper/dbg_fetch_count[25]} {bk3imcpj_wrapper/dbg_fetch_count[26]} {bk3imcpj_wrapper/dbg_fetch_count[27]} {bk3imcpj_wrapper/dbg_fetch_count[28]} {bk3imcpj_wrapper/dbg_fetch_count[29]} {bk3imcpj_wrapper/dbg_fetch_count[30]} {bk3imcpj_wrapper/dbg_fetch_count[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 8 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {bk3imcpj_wrapper/dbg_load_data[0]} {bk3imcpj_wrapper/dbg_load_data[1]} {bk3imcpj_wrapper/dbg_load_data[2]} {bk3imcpj_wrapper/dbg_load_data[3]} {bk3imcpj_wrapper/dbg_load_data[4]} {bk3imcpj_wrapper/dbg_load_data[5]} {bk3imcpj_wrapper/dbg_load_data[6]} {bk3imcpj_wrapper/dbg_load_data[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 32 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {bk3imcpj_wrapper/dbg_uart_status[0]} {bk3imcpj_wrapper/dbg_uart_status[1]} {bk3imcpj_wrapper/dbg_uart_status[2]} {bk3imcpj_wrapper/dbg_uart_status[3]} {bk3imcpj_wrapper/dbg_uart_status[4]} {bk3imcpj_wrapper/dbg_uart_status[5]} {bk3imcpj_wrapper/dbg_uart_status[6]} {bk3imcpj_wrapper/dbg_uart_status[7]} {bk3imcpj_wrapper/dbg_uart_status[8]} {bk3imcpj_wrapper/dbg_uart_status[9]} {bk3imcpj_wrapper/dbg_uart_status[10]} {bk3imcpj_wrapper/dbg_uart_status[11]} {bk3imcpj_wrapper/dbg_uart_status[12]} {bk3imcpj_wrapper/dbg_uart_status[13]} {bk3imcpj_wrapper/dbg_uart_status[14]} {bk3imcpj_wrapper/dbg_uart_status[15]} {bk3imcpj_wrapper/dbg_uart_status[16]} {bk3imcpj_wrapper/dbg_uart_status[17]} {bk3imcpj_wrapper/dbg_uart_status[18]} {bk3imcpj_wrapper/dbg_uart_status[19]} {bk3imcpj_wrapper/dbg_uart_status[20]} {bk3imcpj_wrapper/dbg_uart_status[21]} {bk3imcpj_wrapper/dbg_uart_status[22]} {bk3imcpj_wrapper/dbg_uart_status[23]} {bk3imcpj_wrapper/dbg_uart_status[24]} {bk3imcpj_wrapper/dbg_uart_status[25]} {bk3imcpj_wrapper/dbg_uart_status[26]} {bk3imcpj_wrapper/dbg_uart_status[27]} {bk3imcpj_wrapper/dbg_uart_status[28]} {bk3imcpj_wrapper/dbg_uart_status[29]} {bk3imcpj_wrapper/dbg_uart_status[30]} {bk3imcpj_wrapper/dbg_uart_status[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 32 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {bk3imcpj_wrapper/dbg_load_addr[0]} {bk3imcpj_wrapper/dbg_load_addr[1]} {bk3imcpj_wrapper/dbg_load_addr[2]} {bk3imcpj_wrapper/dbg_load_addr[3]} {bk3imcpj_wrapper/dbg_load_addr[4]} {bk3imcpj_wrapper/dbg_load_addr[5]} {bk3imcpj_wrapper/dbg_load_addr[6]} {bk3imcpj_wrapper/dbg_load_addr[7]} {bk3imcpj_wrapper/dbg_load_addr[8]} {bk3imcpj_wrapper/dbg_load_addr[9]} {bk3imcpj_wrapper/dbg_load_addr[10]} {bk3imcpj_wrapper/dbg_load_addr[11]} {bk3imcpj_wrapper/dbg_load_addr[12]} {bk3imcpj_wrapper/dbg_load_addr[13]} {bk3imcpj_wrapper/dbg_load_addr[14]} {bk3imcpj_wrapper/dbg_load_addr[15]} {bk3imcpj_wrapper/dbg_load_addr[16]} {bk3imcpj_wrapper/dbg_load_addr[17]} {bk3imcpj_wrapper/dbg_load_addr[18]} {bk3imcpj_wrapper/dbg_load_addr[19]} {bk3imcpj_wrapper/dbg_load_addr[20]} {bk3imcpj_wrapper/dbg_load_addr[21]} {bk3imcpj_wrapper/dbg_load_addr[22]} {bk3imcpj_wrapper/dbg_load_addr[23]} {bk3imcpj_wrapper/dbg_load_addr[24]} {bk3imcpj_wrapper/dbg_load_addr[25]} {bk3imcpj_wrapper/dbg_load_addr[26]} {bk3imcpj_wrapper/dbg_load_addr[27]} {bk3imcpj_wrapper/dbg_load_addr[28]} {bk3imcpj_wrapper/dbg_load_addr[29]} {bk3imcpj_wrapper/dbg_load_addr[30]} {bk3imcpj_wrapper/dbg_load_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 32 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {bk3imcpj_wrapper/dbg_data_wdata[0]} {bk3imcpj_wrapper/dbg_data_wdata[1]} {bk3imcpj_wrapper/dbg_data_wdata[2]} {bk3imcpj_wrapper/dbg_data_wdata[3]} {bk3imcpj_wrapper/dbg_data_wdata[4]} {bk3imcpj_wrapper/dbg_data_wdata[5]} {bk3imcpj_wrapper/dbg_data_wdata[6]} {bk3imcpj_wrapper/dbg_data_wdata[7]} {bk3imcpj_wrapper/dbg_data_wdata[8]} {bk3imcpj_wrapper/dbg_data_wdata[9]} {bk3imcpj_wrapper/dbg_data_wdata[10]} {bk3imcpj_wrapper/dbg_data_wdata[11]} {bk3imcpj_wrapper/dbg_data_wdata[12]} {bk3imcpj_wrapper/dbg_data_wdata[13]} {bk3imcpj_wrapper/dbg_data_wdata[14]} {bk3imcpj_wrapper/dbg_data_wdata[15]} {bk3imcpj_wrapper/dbg_data_wdata[16]} {bk3imcpj_wrapper/dbg_data_wdata[17]} {bk3imcpj_wrapper/dbg_data_wdata[18]} {bk3imcpj_wrapper/dbg_data_wdata[19]} {bk3imcpj_wrapper/dbg_data_wdata[20]} {bk3imcpj_wrapper/dbg_data_wdata[21]} {bk3imcpj_wrapper/dbg_data_wdata[22]} {bk3imcpj_wrapper/dbg_data_wdata[23]} {bk3imcpj_wrapper/dbg_data_wdata[24]} {bk3imcpj_wrapper/dbg_data_wdata[25]} {bk3imcpj_wrapper/dbg_data_wdata[26]} {bk3imcpj_wrapper/dbg_data_wdata[27]} {bk3imcpj_wrapper/dbg_data_wdata[28]} {bk3imcpj_wrapper/dbg_data_wdata[29]} {bk3imcpj_wrapper/dbg_data_wdata[30]} {bk3imcpj_wrapper/dbg_data_wdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 6 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list {bk3imcpj_wrapper/dbg_if_status[0]} {bk3imcpj_wrapper/dbg_if_status[1]} {bk3imcpj_wrapper/dbg_if_status[2]} {bk3imcpj_wrapper/dbg_if_status[3]} {bk3imcpj_wrapper/dbg_if_status[4]} {bk3imcpj_wrapper/dbg_if_status[5]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 15 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list {bk3imcpj_wrapper/dbg_imem_addr[0]} {bk3imcpj_wrapper/dbg_imem_addr[1]} {bk3imcpj_wrapper/dbg_imem_addr[2]} {bk3imcpj_wrapper/dbg_imem_addr[3]} {bk3imcpj_wrapper/dbg_imem_addr[4]} {bk3imcpj_wrapper/dbg_imem_addr[5]} {bk3imcpj_wrapper/dbg_imem_addr[6]} {bk3imcpj_wrapper/dbg_imem_addr[7]} {bk3imcpj_wrapper/dbg_imem_addr[8]} {bk3imcpj_wrapper/dbg_imem_addr[9]} {bk3imcpj_wrapper/dbg_imem_addr[10]} {bk3imcpj_wrapper/dbg_imem_addr[11]} {bk3imcpj_wrapper/dbg_imem_addr[12]} {bk3imcpj_wrapper/dbg_imem_addr[13]} {bk3imcpj_wrapper/dbg_imem_addr[14]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 32 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list {bk3imcpj_wrapper/dbg_if_data[0]} {bk3imcpj_wrapper/dbg_if_data[1]} {bk3imcpj_wrapper/dbg_if_data[2]} {bk3imcpj_wrapper/dbg_if_data[3]} {bk3imcpj_wrapper/dbg_if_data[4]} {bk3imcpj_wrapper/dbg_if_data[5]} {bk3imcpj_wrapper/dbg_if_data[6]} {bk3imcpj_wrapper/dbg_if_data[7]} {bk3imcpj_wrapper/dbg_if_data[8]} {bk3imcpj_wrapper/dbg_if_data[9]} {bk3imcpj_wrapper/dbg_if_data[10]} {bk3imcpj_wrapper/dbg_if_data[11]} {bk3imcpj_wrapper/dbg_if_data[12]} {bk3imcpj_wrapper/dbg_if_data[13]} {bk3imcpj_wrapper/dbg_if_data[14]} {bk3imcpj_wrapper/dbg_if_data[15]} {bk3imcpj_wrapper/dbg_if_data[16]} {bk3imcpj_wrapper/dbg_if_data[17]} {bk3imcpj_wrapper/dbg_if_data[18]} {bk3imcpj_wrapper/dbg_if_data[19]} {bk3imcpj_wrapper/dbg_if_data[20]} {bk3imcpj_wrapper/dbg_if_data[21]} {bk3imcpj_wrapper/dbg_if_data[22]} {bk3imcpj_wrapper/dbg_if_data[23]} {bk3imcpj_wrapper/dbg_if_data[24]} {bk3imcpj_wrapper/dbg_if_data[25]} {bk3imcpj_wrapper/dbg_if_data[26]} {bk3imcpj_wrapper/dbg_if_data[27]} {bk3imcpj_wrapper/dbg_if_data[28]} {bk3imcpj_wrapper/dbg_if_data[29]} {bk3imcpj_wrapper/dbg_if_data[30]} {bk3imcpj_wrapper/dbg_if_data[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 6 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list {bk3imcpj_wrapper/dbg_imem_ctrl[0]} {bk3imcpj_wrapper/dbg_imem_ctrl[1]} {bk3imcpj_wrapper/dbg_imem_ctrl[2]} {bk3imcpj_wrapper/dbg_imem_ctrl[3]} {bk3imcpj_wrapper/dbg_imem_ctrl[4]} {bk3imcpj_wrapper/dbg_imem_ctrl[5]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 8 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list {bk3imcpj_wrapper/dbg_seen[0]} {bk3imcpj_wrapper/dbg_seen[1]} {bk3imcpj_wrapper/dbg_seen[2]} {bk3imcpj_wrapper/dbg_seen[3]} {bk3imcpj_wrapper/dbg_seen[4]} {bk3imcpj_wrapper/dbg_seen[5]} {bk3imcpj_wrapper/dbg_seen[6]} {bk3imcpj_wrapper/dbg_seen[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 8 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list {bk3imcpj_wrapper/dbg_mcu_wdata[0]} {bk3imcpj_wrapper/dbg_mcu_wdata[1]} {bk3imcpj_wrapper/dbg_mcu_wdata[2]} {bk3imcpj_wrapper/dbg_mcu_wdata[3]} {bk3imcpj_wrapper/dbg_mcu_wdata[4]} {bk3imcpj_wrapper/dbg_mcu_wdata[5]} {bk3imcpj_wrapper/dbg_mcu_wdata[6]} {bk3imcpj_wrapper/dbg_mcu_wdata[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 32 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list {bk3imcpj_wrapper/dbg_data_rdata[0]} {bk3imcpj_wrapper/dbg_data_rdata[1]} {bk3imcpj_wrapper/dbg_data_rdata[2]} {bk3imcpj_wrapper/dbg_data_rdata[3]} {bk3imcpj_wrapper/dbg_data_rdata[4]} {bk3imcpj_wrapper/dbg_data_rdata[5]} {bk3imcpj_wrapper/dbg_data_rdata[6]} {bk3imcpj_wrapper/dbg_data_rdata[7]} {bk3imcpj_wrapper/dbg_data_rdata[8]} {bk3imcpj_wrapper/dbg_data_rdata[9]} {bk3imcpj_wrapper/dbg_data_rdata[10]} {bk3imcpj_wrapper/dbg_data_rdata[11]} {bk3imcpj_wrapper/dbg_data_rdata[12]} {bk3imcpj_wrapper/dbg_data_rdata[13]} {bk3imcpj_wrapper/dbg_data_rdata[14]} {bk3imcpj_wrapper/dbg_data_rdata[15]} {bk3imcpj_wrapper/dbg_data_rdata[16]} {bk3imcpj_wrapper/dbg_data_rdata[17]} {bk3imcpj_wrapper/dbg_data_rdata[18]} {bk3imcpj_wrapper/dbg_data_rdata[19]} {bk3imcpj_wrapper/dbg_data_rdata[20]} {bk3imcpj_wrapper/dbg_data_rdata[21]} {bk3imcpj_wrapper/dbg_data_rdata[22]} {bk3imcpj_wrapper/dbg_data_rdata[23]} {bk3imcpj_wrapper/dbg_data_rdata[24]} {bk3imcpj_wrapper/dbg_data_rdata[25]} {bk3imcpj_wrapper/dbg_data_rdata[26]} {bk3imcpj_wrapper/dbg_data_rdata[27]} {bk3imcpj_wrapper/dbg_data_rdata[28]} {bk3imcpj_wrapper/dbg_data_rdata[29]} {bk3imcpj_wrapper/dbg_data_rdata[30]} {bk3imcpj_wrapper/dbg_data_rdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 32 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list {bk3imcpj_wrapper/dbg_if_addr[0]} {bk3imcpj_wrapper/dbg_if_addr[1]} {bk3imcpj_wrapper/dbg_if_addr[2]} {bk3imcpj_wrapper/dbg_if_addr[3]} {bk3imcpj_wrapper/dbg_if_addr[4]} {bk3imcpj_wrapper/dbg_if_addr[5]} {bk3imcpj_wrapper/dbg_if_addr[6]} {bk3imcpj_wrapper/dbg_if_addr[7]} {bk3imcpj_wrapper/dbg_if_addr[8]} {bk3imcpj_wrapper/dbg_if_addr[9]} {bk3imcpj_wrapper/dbg_if_addr[10]} {bk3imcpj_wrapper/dbg_if_addr[11]} {bk3imcpj_wrapper/dbg_if_addr[12]} {bk3imcpj_wrapper/dbg_if_addr[13]} {bk3imcpj_wrapper/dbg_if_addr[14]} {bk3imcpj_wrapper/dbg_if_addr[15]} {bk3imcpj_wrapper/dbg_if_addr[16]} {bk3imcpj_wrapper/dbg_if_addr[17]} {bk3imcpj_wrapper/dbg_if_addr[18]} {bk3imcpj_wrapper/dbg_if_addr[19]} {bk3imcpj_wrapper/dbg_if_addr[20]} {bk3imcpj_wrapper/dbg_if_addr[21]} {bk3imcpj_wrapper/dbg_if_addr[22]} {bk3imcpj_wrapper/dbg_if_addr[23]} {bk3imcpj_wrapper/dbg_if_addr[24]} {bk3imcpj_wrapper/dbg_if_addr[25]} {bk3imcpj_wrapper/dbg_if_addr[26]} {bk3imcpj_wrapper/dbg_if_addr[27]} {bk3imcpj_wrapper/dbg_if_addr[28]} {bk3imcpj_wrapper/dbg_if_addr[29]} {bk3imcpj_wrapper/dbg_if_addr[30]} {bk3imcpj_wrapper/dbg_if_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 32 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list {bk3imcpj_wrapper/dbg_imem_dout[0]} {bk3imcpj_wrapper/dbg_imem_dout[1]} {bk3imcpj_wrapper/dbg_imem_dout[2]} {bk3imcpj_wrapper/dbg_imem_dout[3]} {bk3imcpj_wrapper/dbg_imem_dout[4]} {bk3imcpj_wrapper/dbg_imem_dout[5]} {bk3imcpj_wrapper/dbg_imem_dout[6]} {bk3imcpj_wrapper/dbg_imem_dout[7]} {bk3imcpj_wrapper/dbg_imem_dout[8]} {bk3imcpj_wrapper/dbg_imem_dout[9]} {bk3imcpj_wrapper/dbg_imem_dout[10]} {bk3imcpj_wrapper/dbg_imem_dout[11]} {bk3imcpj_wrapper/dbg_imem_dout[12]} {bk3imcpj_wrapper/dbg_imem_dout[13]} {bk3imcpj_wrapper/dbg_imem_dout[14]} {bk3imcpj_wrapper/dbg_imem_dout[15]} {bk3imcpj_wrapper/dbg_imem_dout[16]} {bk3imcpj_wrapper/dbg_imem_dout[17]} {bk3imcpj_wrapper/dbg_imem_dout[18]} {bk3imcpj_wrapper/dbg_imem_dout[19]} {bk3imcpj_wrapper/dbg_imem_dout[20]} {bk3imcpj_wrapper/dbg_imem_dout[21]} {bk3imcpj_wrapper/dbg_imem_dout[22]} {bk3imcpj_wrapper/dbg_imem_dout[23]} {bk3imcpj_wrapper/dbg_imem_dout[24]} {bk3imcpj_wrapper/dbg_imem_dout[25]} {bk3imcpj_wrapper/dbg_imem_dout[26]} {bk3imcpj_wrapper/dbg_imem_dout[27]} {bk3imcpj_wrapper/dbg_imem_dout[28]} {bk3imcpj_wrapper/dbg_imem_dout[29]} {bk3imcpj_wrapper/dbg_imem_dout[30]} {bk3imcpj_wrapper/dbg_imem_dout[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 32 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list {bk3imcpj_wrapper/dbg_data_raddr[0]} {bk3imcpj_wrapper/dbg_data_raddr[1]} {bk3imcpj_wrapper/dbg_data_raddr[2]} {bk3imcpj_wrapper/dbg_data_raddr[3]} {bk3imcpj_wrapper/dbg_data_raddr[4]} {bk3imcpj_wrapper/dbg_data_raddr[5]} {bk3imcpj_wrapper/dbg_data_raddr[6]} {bk3imcpj_wrapper/dbg_data_raddr[7]} {bk3imcpj_wrapper/dbg_data_raddr[8]} {bk3imcpj_wrapper/dbg_data_raddr[9]} {bk3imcpj_wrapper/dbg_data_raddr[10]} {bk3imcpj_wrapper/dbg_data_raddr[11]} {bk3imcpj_wrapper/dbg_data_raddr[12]} {bk3imcpj_wrapper/dbg_data_raddr[13]} {bk3imcpj_wrapper/dbg_data_raddr[14]} {bk3imcpj_wrapper/dbg_data_raddr[15]} {bk3imcpj_wrapper/dbg_data_raddr[16]} {bk3imcpj_wrapper/dbg_data_raddr[17]} {bk3imcpj_wrapper/dbg_data_raddr[18]} {bk3imcpj_wrapper/dbg_data_raddr[19]} {bk3imcpj_wrapper/dbg_data_raddr[20]} {bk3imcpj_wrapper/dbg_data_raddr[21]} {bk3imcpj_wrapper/dbg_data_raddr[22]} {bk3imcpj_wrapper/dbg_data_raddr[23]} {bk3imcpj_wrapper/dbg_data_raddr[24]} {bk3imcpj_wrapper/dbg_data_raddr[25]} {bk3imcpj_wrapper/dbg_data_raddr[26]} {bk3imcpj_wrapper/dbg_data_raddr[27]} {bk3imcpj_wrapper/dbg_data_raddr[28]} {bk3imcpj_wrapper/dbg_data_raddr[29]} {bk3imcpj_wrapper/dbg_data_raddr[30]} {bk3imcpj_wrapper/dbg_data_raddr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 1 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list data_rdy_o]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets osc_clk]
