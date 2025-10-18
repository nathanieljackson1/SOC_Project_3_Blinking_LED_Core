/*****************************************************************//**
 * @file main_vanilla_test.cpp
 *
 * @brief Basic test of 4 basic i/o cores
 *
 * @author p chu
 * @version v1.0: initial release
 *********************************************************************/

//#define _DEBUG
#include "chu_init.h"
#include "gpio_cores.h"
#include "blinking_led_core.h"

BlinkingLedCore blink(get_slot_addr(BRIDGE_BASE, S4_USER));

void prog_pattern(uint16_t a, uint16_t b, uint16_t c, uint16_t d){
blink.set_all(a, b, c, d);
} 

int main() {
   //prog_pattern(200, 400, 800, 1000);
   while (1) {
      sleep_ms(5100);
      prog_pattern(1000, 1000, 1000, 1000);

      sleep_ms(5100);
      prog_pattern(2000, 1000, 500, 250);

      sleep_ms(5100);
      prog_pattern(250, 250, 250, 250);

      sleep_ms(5100);
      prog_pattern(250, 500, 1000, 2000);

      sleep_ms(5100);
      prog_pattern(0, 0, 0, 0);
   } //while
} //main

