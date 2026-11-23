onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib s_32kx32_opt

do {wave.do}

view wave
view structure
view signals

do {s_32kx32.udo}

run -all

quit -force
