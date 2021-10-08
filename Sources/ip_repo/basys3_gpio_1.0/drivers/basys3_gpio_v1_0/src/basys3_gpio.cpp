/*---------------------------------------------*
 *  Title       : Basys 3 GPIO Driver          *
 *  File        : basys3_gpio.cpp              *
 *  Author      : Yigit Suoglu                 *
 *  License     : EUPL-1.2                     *
 *  Last Edit   : 09/10/2021                   *
 *---------------------------------------------*
 *  Description : SW driver for basys3_gpio IP *
 *---------------------------------------------*/

#include "basys3_gpio.h"

basys3_gpio::basys3_gpio(){
  *config = 0x2E; //Handle ssds from config, autoclear button counter
}

void basys3_gpio::keepButtonVal(bool keep){
  if(keep){
    *config |= 0x1; 
  }else{
    *config &= 0xFFFFFFFE; 
  }
}

void basys3_gpio::digits(bool digit3enabled, bool digit2enabled, bool digit1enabled, bool digit0enabled){
  unsigned char mask = 0;
  if(digit3enabled){
    mask += 0x8;
  }
  if(digit2enabled){
    mask += 0x4;
  }
  if(digit1enabled){
    mask += 0x2;
  }
  if(digit0enabled){
    mask += 0x1;
  }
  digits(mask);
}

void basys3_gpio::digits(unsigned char mask){
  unsigned long  or_mask =  static_cast<unsigned long>(mask) << 2;
  unsigned long and_mask = (static_cast<unsigned long>(mask) << 2) | 0xFFFFFFC3;
  *config |= or_mask;
  *config &= and_mask;
}

const unsigned short basys3_gpio::getLeds(){
  return static_cast<unsigned short>(*leds);
}

void basys3_gpio::setLeds(unsigned short led){
  *leds =  static_cast<unsigned long>(led);
}

const unsigned short basys3_gpio::getSwitches(){
  return static_cast<unsigned short>(*switches);
}

const unsigned short basys3_gpio::getSSD(){
  return static_cast<unsigned short>(*ssd);
}

void basys3_gpio::setSSD(unsigned short val){
  *ssd = val;
}

unsigned long basys3_gpio::getButton(BUTTON btn){
  switch (btn)
  {
  case LEFT:
    return *btn_left;
  case RIGHT:
    return *btn_right;
  case UP:
    return *btn_up;
  case DOWN:
    return *btn_down;
  default:
    return 0;
  }
}
