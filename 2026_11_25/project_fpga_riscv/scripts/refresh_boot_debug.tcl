# Source in Hardware Manager after connecting/opening the intended HW target.
# Does not program the FPGA or change its bitstream. Assumes the build's USER1.
set boot_hw_target [current_hw_target]
if {$boot_hw_target eq ""} {error "Connect and open the intended hardware target first"}
set boot_hw_device [current_hw_device]
if {$boot_hw_device eq ""} {error "Select the intended xczu9 device first"}
puts "Target: $boot_hw_target; device: $boot_hw_device"
puts "PROGRAM.FILE: [get_property PROGRAM.FILE $boot_hw_device]"
puts "PROBES.FILE: [get_property PROBES.FILE $boot_hw_device]"
puts "Release sys_reset and ensure the differential board clock is active before discovery."
# Reopen the target so cable drivers apply the changed TCK reliably.
set boot_hw_device_name [get_property NAME $boot_hw_device]
close_hw_target $boot_hw_target
set_property PARAM.FREQUENCY 1000000 $boot_hw_target
open_hw_target $boot_hw_target
set boot_hw_device [get_hw_devices -quiet $boot_hw_device_name]
if {[llength $boot_hw_device] != 1} {error "Cannot reselect $boot_hw_device_name after reopening target"}
current_hw_device $boot_hw_device
# Current build explicitly selects C_USER_SCAN_CHAIN=1 -> USER1 mask 0001.
set_property BSCAN_SWITCH_USER_MASK 0001 $boot_hw_device
refresh_hw_device $boot_hw_device
set boot_hw_ilas [get_hw_ilas -quiet -of_objects $boot_hw_device]
puts "Detected ILAs: $boot_hw_ilas"
if {![llength $boot_hw_ilas]} {
    error "No ILA discovered. Verify paired bit/ltx from boot_debug, routed DCP hub report, board clock and MMCM reset."
}
puts "Debug discovery succeeded. Arm ILA before sending firmware."
