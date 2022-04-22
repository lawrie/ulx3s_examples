#ifndef __TINYSOC_FLASH
#define __TINYSOC_FLASH

#include <stdint.h>

#define reg_flash_prescale (*(volatile uint32_t*)0x08000000)
#define reg_flash_cs (*(volatile uint32_t*)0x08000004)
#define reg_flash_xfer (*(volatile uint32_t*)0x08000008)
#define reg_flash_mode (*(volatile uint32_t*)0x0800000C)

void flash_begin(void);

void flash_end(void);

uint8_t flash_xfer(uint8_t d);

void flash_write_enable(void);

void flash_bulk_erase(void);

void flash_erase_64kB(uint32_t addr);

void flash_erase_32kB(uint32_t addr);

void flash_write(uint32_t addr, uint8_t *data, int n);

void flash_read(uint32_t addr, uint8_t *data, int n);

void flash_wait();

#endif



