# Match the clock wizard's 3.333 ns input period and PLL output dividers.
create_clock -name TS_CLKA -period 36.663 [get_ports clka]
create_clock -name TS_CLKB -period 16.665 [get_ports clkb]
