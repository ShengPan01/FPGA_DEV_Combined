create_register "Address: 0x00" 0x00 UART_TX_BUF
set_register_item {7:0} {UART_TX_BUF} {R/W} {0x0} {}

create_register "Address: 0x00" 0x01 UART_TX_ST
set_register_item {7:1} {Reserved} {} {} {}
set_register_item {0} {UART_TX_BUSY} {R/O} {0x0} {}

create_register "Address: 0x00" 0x02 UART_RX_BUF
set_register_item {7:0} {UART_RX_BUF} {R/O} {0x0} {}

create_register "Address: 0x00" 0x03 UART_INT
set_register_item {7:2} {Reserved} {} {} {}
set_register_item {1} {UART_TI} {R/O W/C} {0x0} {}
set_register_item {0} {UART_RI} {R/O W/C} {0x0} {}

create_register "Address: 0x00" 0x04 UART_INT_EN
set_register_item {7:2} {Reserved} {} {} {}
set_register_item {1} {UART_TI_EN} {R/W} {0x0} {0x0: Disable
0x1: Enable}
set_register_item {0} {UART_RI_EN} {R/W} {0x0} {0x0: Disable
0x1: Enable}

