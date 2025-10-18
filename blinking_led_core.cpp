
#include "blinking_led_core.h"

BlinkingLedCore::BlinkingLedCore(uint32_t core_base_addr) {
   base_addr = core_base_addr;
}

BlinkingLedCore::~BlinkingLedCore() {}

void BlinkingLedCore::set_interval(uint16_t interval, int channel){
    if ((channel<0) || (channel>3)) return;
    io_write(base_addr, static_cast<uint32_t>(IV0_REG+channel), static_cast<uint32_t>(interval));
}

void BlinkingLedCore::set_all(uint16_t iv0, uint16_t iv1, uint16_t iv2, uint16_t iv3){
    io_write(base_addr, IV0_REG, iv0);
    io_write(base_addr, IV1_REG, iv1);
    io_write(base_addr, IV2_REG, iv2);
    io_write(base_addr, IV3_REG, iv3);
}