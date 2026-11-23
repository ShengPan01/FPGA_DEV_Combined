#ifndef FLASH_CMD_H
#define FLASH_CMD_H
void flash_begin(char **argv);
void flash_hex(char **argv);
void flash_read(char **argv);
void flash_abort(char **argv);
#endif
