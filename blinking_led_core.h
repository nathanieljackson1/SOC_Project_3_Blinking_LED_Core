
#ifndef _BLINKING_LED_CORE_H_INCLUDED
#define _BLINKING_LED_CORE_H_INCLUDED

#include "chu_init.h"

/**********************************************************************
 * blinking LED core driver
 **********************************************************************/

class BlinkingLedCore {
public:
    enum {
        IV0_REG = 0,
        IV1_REG = 1,
        IV2_REG = 2,
        IV3_REG = 3
    };

    BlinkingLedCore(uint32_t core_base_addr);
    ~BlinkingLedCore(); // not used

    void set_interval(uint16_t interval, int channel);

    void set_all(uint16_t iv0, uint16_t iv1, uint16_t iv2, uint16_t iv3);

private:
    uint32_t base_addr;
 };

 #endif // _BLINKING_LED_CORE_H_INCLUDED 