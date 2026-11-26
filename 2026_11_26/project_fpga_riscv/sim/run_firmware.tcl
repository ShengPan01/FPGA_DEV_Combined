# Run from any directory: vivado -mode batch -source /path/to/sim/run_firmware.tcl
set project_dir [file normalize [get_property DIRECTORY [current_project]]]
set firmware [file join $project_dir sim firmware.mem]
if {![file exists $firmware]} {error "Missing $firmware; run ihex_to_mem.py first"}
#open_project [file join $project_dir project_fpga_riscv.xpr]
set_property top tb_firmware [get_filesets sim_1]
set_property xsim.simulate.runtime {110 ms} [get_filesets sim_1]
set_property -name xsim.elaborate.xelab.more_options \
    -value {-timescale 1ns/1ps} \
    -objects [get_filesets sim_1]
#set_property xsim.simulate.xsim.more_options [list -testplusarg "FW_MEM=$firmware"] [get_filesets sim_1]
set_property -name xsim.simulate.xsim.more_options \
    -value [list -testplusarg "FW_MEM=$firmware"] \
    -objects [get_filesets sim_1]
generate_target simulation [get_ips]
update_compile_order -fileset sim_1
launch_simulation -mode behavioral
#close_sim
#close_project
