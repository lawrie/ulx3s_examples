#include "flash.h"
#include "delay.h"

void flash_begin() {
  reg_flash_cs = 0;
}

void flash_end() {
  reg_flash_cs = 1;
}

uint8_t flash_xfer(uint8_t d) {
  reg_flash_xfer = d;
  return reg_flash_xfer;
}

void flash_write_enable() {
        flash_begin();
        flash_xfer(0x06);
        flash_end();
}

void flash_bulk_erase() {
        flash_begin();
        flash_xfer(0xc7);
        flash_end();
}

void flash_erase_64kB(uint32_t addr) {
        flash_begin();
        flash_xfer(0xd8);
        flash_xfer(addr >> 16);
        flash_xfer(addr >> 8);
        flash_xfer(addr);
        flash_end();
}

void flash_erase_32kB(uint32_t addr) {
        flash_begin();
        flash_xfer(0x52);
        flash_xfer(addr >> 16);
        flash_xfer(addr >> 8);
        flash_xfer(addr);
        flash_end();
}

void flash_write(uint32_t addr, uint8_t *data, int n) {
        flash_begin();
        flash_xfer(0x02);
        flash_xfer(addr >> 16);
        flash_xfer(addr >> 8);
        flash_xfer(addr);
        while (n--)
                flash_xfer(*(data++));
        flash_end();
}

void flash_read(uint32_t addr, uint8_t *data, int n) {
        flash_begin();
        flash_xfer(0x03);
        flash_xfer(addr >> 16);
        flash_xfer(addr >> 8);
        flash_xfer(addr);
        while (n--)
                *(data++) = flash_xfer(0);
        flash_end();
}

void flash_wait() {
        while (1)
        {
                flash_begin();
                flash_xfer(0x05);
                int status = flash_xfer(0);
                flash_end();

                if ((status & 0x01) == 0)
                        break;

                delay(1);
        }
}

