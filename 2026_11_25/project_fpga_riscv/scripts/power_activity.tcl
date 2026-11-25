# Vectorless power estimate for normal execution after Flash/UART boot.
# These activity assumptions do not constrain timing or change the hardware.
set_switching_activity -static_probability 0 -toggle_rate 0 [get_ports {sys_reset rst_iic}]
foreach name {osc_reset_n spi_clk_reset_sync/spi_reset_n bk3imcpj_wrapper/bk3_core_reset_n} {
    set net [get_nets $name]
    if {[llength $net] != 1} {
        error "Missing runtime reset net for power analysis: $name"
    }
    set_switching_activity -static_probability 1 -toggle_rate 0 $net
}
