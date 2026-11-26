# Run AFTER open_run synth_1, BEFORE implementation. Save the resulting
# constraints with save_constraints; regenerate implementation/bitstream/LTX.
# No automatic hook: sourcing this script explicitly enables the ILA.
# Opening a project alone does not open its synthesized netlist.
if {[catch {current_design} boot_design] || $boot_design eq ""} {
    error "No open design. Open the project, run synthesis if needed, then execute open_run synth_1 before sourcing insert_boot_ila.tcl."
}

set boot_ila_name ila_boot
if {[llength [get_debug_cores -quiet $boot_ila_name]]} {
    error "$boot_ila_name already exists"
}
set boot_probe_names {
    dbg_uart_status dbg_boot_status dbg_load_addr dbg_load_data dbg_load_en
    dbg_if_addr dbg_if_data dbg_if_status
    dbg_data_raddr dbg_data_rdata dbg_data_waddr dbg_data_wdata
    dbg_data_status dbg_data_read_status
    dbg_mcu_addr dbg_mcu_wdata dbg_mcu_rdata dbg_mcu_status
    dbg_load_count dbg_fetch_count dbg_uart_tx_count dbg_last_if_addr dbg_seen
}
# Vivado hierarchical pattern matching is not Tcl regexp matching of full
# paths. Collect with a NAME filter, then match the returned full names in Tcl.
# Include marked aliases in the diagnostic output if synthesis renamed a net.
set boot_candidates [get_nets -hierarchical -quiet -filter {NAME =~ *dbg_*}]
set boot_probe_groups {}
set boot_missing {}
foreach probe $boot_probe_names {
    set pattern [format {(^|/)%s(\[[0-9]+\])?$} $probe]
    set names {}
    set objects [dict create]
    foreach net $boot_candidates {
        set name [get_property NAME $net]
        if {[regexp $pattern $name]} {
            lappend names $name
            dict set objects $name $net
        }
    }
    set names [lsort -unique -dictionary $names]
    set nets {}
    foreach name $names {
        # Reuse net objects: no second glob lookup of bracketed bus names.
        lappend nets [dict get $objects $name]
    }
    if {![llength $nets]} {lappend boot_missing $probe}
    lappend boot_probe_groups $nets
}
if {[llength $boot_missing]} {
    puts "Missing boot probes: $boot_missing"
    puts "Debug-name candidates in the OPEN design:"
    foreach net $boot_candidates {puts "  [get_property NAME $net]"}
    puts "MARK_DEBUG nets in the OPEN design (including synthesized aliases):"
    foreach net [get_nets -hierarchical -quiet -filter {MARK_DEBUG == 1}] {
        puts "  [get_property NAME $net]"
    }
    error "Boot probes unresolved; check the listed net names and that the current synthesized design contains the modified RTL. No ILA was created."
}
set boot_clk [get_nets -hierarchical -quiet -filter {NAME == osc_clk}]
if {[llength $boot_clk] != 1} {error "Expected one top-level osc_clk net, got: $boot_clk"}
create_debug_core $boot_ila_name ila
set_property C_DATA_DEPTH 2048 [get_debug_cores $boot_ila_name]
connect_debug_port $boot_ila_name/clk $boot_clk
set boot_index 0
foreach probe $boot_probe_names nets $boot_probe_groups {
    if {$boot_index > 0} {create_debug_port $boot_ila_name probe}
    set port [get_debug_ports $boot_ila_name/probe$boot_index]
    set_property port_width [llength $nets] $port
    connect_debug_port $port $nets
    puts "probe$boot_index = $probe ([llength $nets] bits)"
    incr boot_index
}
# Do not let implementation choose an unrelated or stopped hub clock.
# osc_clk is 27 MHz for the current clock-wizard configuration. sys_reset
# resets that MMCM, so release the board reset before debug discovery.
set boot_hub [get_debug_cores -quiet dbg_hub]
if {[llength $boot_hub] != 1} {
    error "Expected the automatically created dbg_hub after ILA creation; inspect get_debug_cores. Do not build/program an unverified debug design."
}
set_property C_CLK_INPUT_FREQ_HZ 27000000 $boot_hub
set_property C_ENABLE_CLK_DIVIDER false $boot_hub
set_property C_USER_SCAN_CHAIN 1 $boot_hub
connect_debug_port dbg_hub/clk $boot_clk
puts "ILA and dbg_hub connected to osc_clk (27 MHz), USER chain 1. Use JTAG 1 MHz for initial discovery."
puts "Run save_constraints and implementation, or continue with build_boot_debug.tcl."
