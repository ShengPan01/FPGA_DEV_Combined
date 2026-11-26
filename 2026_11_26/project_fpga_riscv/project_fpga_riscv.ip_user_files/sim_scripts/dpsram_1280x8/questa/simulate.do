onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib dpsram_1280x8_opt

do {wave.do}

view wave
view structure
view signals

do {dpsram_1280x8.udo}

run -all

quit -force
