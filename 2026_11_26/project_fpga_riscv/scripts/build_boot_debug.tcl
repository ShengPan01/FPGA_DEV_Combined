# vivado -mode batch -source scripts/build_boot_debug.tcl
# Optional first Tcl argument: output directory. Run with the board disconnected
# or connected: this script builds files only; it does not program hardware.
set boot_script_dir [file dirname [file normalize [info script]]]
set boot_project_dir [file dirname $boot_script_dir]
if {[llength $argv] > 1} {error "Usage: build_boot_debug.tcl ?output_directory?"}
set boot_output_dir [file join $boot_project_dir boot_debug]
if {[llength $argv] == 1} {set boot_output_dir [file normalize [lindex $argv 0]]}
file mkdir $boot_output_dir
open_project [file join $boot_project_dir project_fpga_riscv.xpr]
# A new synthesis is required: old checkpoints do not contain the RTL probes.
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1
if {![string match {*Complete*} [get_property STATUS [get_runs synth_1]]]} {
    error "Synthesis did not complete; inspect synth_1/runme.log"
}
open_run synth_1
source [file join $boot_script_dir insert_boot_ila.tcl]
# Implement the currently open design so the inserted ILA cannot be lost when
# a project run reopens the uninstrumented synthesis checkpoint. No XDC edits.
write_checkpoint -force [file join $boot_output_dir boot_debug_synth.dcp]
opt_design
place_design
phys_opt_design
route_design
# Record the actual routed design, not the separate project impl_1 run.
foreach boot_core_name {ila_boot dbg_hub} {
    if {[llength [get_debug_cores -quiet $boot_core_name]] != 1} {
        error "Routed design is missing $boot_core_name; refusing bitstream export"
    }
}
set boot_debug_report [open [file join $boot_output_dir boot_debug_cores.txt] w]
puts $boot_debug_report "Generated: [clock format [clock seconds]]"
puts $boot_debug_report "Output directory: $boot_output_dir"
puts $boot_debug_report "Debug cores: [get_debug_cores]"
puts $boot_debug_report "Hub clock configured before opt_design: osc_clk, 27000000 Hz"
puts $boot_debug_report "Hub frequency property: [get_property C_CLK_INPUT_FREQ_HZ [get_debug_cores dbg_hub]]"
puts $boot_debug_report "Hub USER chain: [get_property C_USER_SCAN_CHAIN [get_debug_cores dbg_hub]]"
puts $boot_debug_report "Initial Hardware Manager JTAG frequency: 1000000 Hz"
foreach boot_core_name {ila_boot dbg_hub} {
    set boot_core_cells [get_cells -hierarchical -quiet -filter "NAME == $boot_core_name || NAME =~ */$boot_core_name"]
    puts $boot_debug_report "$boot_core_name cells: $boot_core_cells"
    if {[llength $boot_core_cells]} {
        set boot_clock_pins [get_pins -quiet -of_objects $boot_core_cells -filter {REF_PIN_NAME == clk}]
        if {[llength $boot_clock_pins]} {
            puts $boot_debug_report "Clock nets: [get_nets -quiet -of_objects $boot_clock_pins]"
        }
    }
}
close $boot_debug_report
report_timing_summary -file [file join $boot_output_dir boot_debug_timing.rpt]
report_utilization -file [file join $boot_output_dir boot_debug_utilization.rpt]
write_checkpoint -force [file join $boot_output_dir boot_debug_routed.dcp]
# Reject negative setup/hold slack instead of presenting this as a usable build.
foreach boot_delay_type {max min} {
    set boot_worst_path [get_timing_paths -quiet -delay_type $boot_delay_type -max_paths 1]
    if {![llength $boot_worst_path]} {error "No $boot_delay_type timing path found; check clocks/constraints"}
    if {[get_property SLACK $boot_worst_path] < 0} {
        error "Negative $boot_delay_type slack; inspect boot_debug_timing.rpt before programming"
    }
}
write_debug_probes -force [file join $boot_output_dir boot_debug.ltx]
write_bitstream -force [file join $boot_output_dir boot_debug.bit]
puts "Build complete: $boot_output_dir/boot_debug.bit and boot_debug.ltx"
