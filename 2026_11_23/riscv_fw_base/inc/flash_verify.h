#ifndef FLASH_VERIFY_H
#define FLASH_VERIFY_H
/* Reports PASS/FAIL over UART and always returns to the startup flow. */
void flash_verify_on_boot(void);
#endif
