# vivado -mode batch -source project_fpga_riscv/sim/run_uart_firmware.tcl
set sim_dir [file dirname [file normalize [info script]]]
set project_dir [file dirname $sim_dir]
if {[current_project -quiet] eq ""} {
    open_project [file join $project_dir project_fpga_riscv.xpr]
}
set firmware [file normalize [file join $project_dir ../riscv_fw_base/output/test.ihex]]
if {[info exists ::env(FW_IHEX)]} {set firmware [file normalize $::env(FW_IHEX)]}
if {![file exists $firmware]} {error "Missing firmware: $firmware"}
set bench [file join $project_dir rtl testbench tb_uart_firmware.sv]
if {[llength [get_files -quiet $bench]] == 0} {add_files -fileset sim_1 -norecurse $bench}
set_property top tb_uart_firmware [get_filesets sim_1]
set_property xsim.simulate.runtime {all} [get_filesets sim_1]
set_property -name xsim.elaborate.xelab.more_options \
    -value {-timescale 1ns/1ps} -objects [get_filesets sim_1]
set_property -name xsim.simulate.xsim.more_options \
    -value [list -testplusarg "FW_IHEX=$firmware" -testplusarg "TIMEOUT_MS=40000"] \
    -objects [get_filesets sim_1]
generate_target simulation [get_ips]
update_compile_order -fileset sim_1
launch_simulation -mode behavioral
