#ifndef __TINYSOC_SDCARD__
#define __TINYSOC_SDCARD__

#include <stdint.h>

#define reg_sdcard_prescale (*(volatile uint32_t*)0x06000000)
#define reg_sdcard_cs (*(volatile uint32_t*)0x06000004)
#define reg_sdcard_xfer (*(volatile uint32_t*)0x06000008)
#define reg_sdcard_mode (*(volatile uint32_t*)0x0600000c)

void sdcard_read(uint8_t *data, uint32_t blockaddr);

void sdcard_init(void);

void sdcard_error(char *msg, uint32_t r);

void sdcard_error2(char *msg, uint32_t r1, uint32_t r2);

#endif
