/*---------------------------------------------*
 *  Title       : Nexys Video GPIO Driver      *
 *  File        : nexysVideo_gpio.cpp          *
 *  Author      : Yigit Suoglu                 *
 *  License     : EUPL-1.2                     *
 *  Last Edit   : 10/10/2021                   *
 *---------------------------------------------*
 *  Description : SW driver for                *
 *                nexysVideo_gpio IP           *
 *---------------------------------------------*/

#include "nexysVideo_gpio.h"

nexysVideo_gpio::nexysVideo_gpio(){

}

void nexysVideo_gpio::keepButton(bool keep){
  if(keep){
    *config |= 0x1; 
  }else{
    *config &= 0xFFFFFFFE; 
  }
}

const unsigned char nexysVideo_gpio::getSwitches(){
  return static_cast<unsigned char>(*sw);
}

const unsigned char nexysVideo_gpio::getLeds(){
  return static_cast<unsigned char>(*led);
}

void nexysVideo_gpio::setLeds(const unsigned char led_val){
  *led = static_cast<unsigned long>(led_val);
}

const unsigned long nexysVideo_gpio::getButton(BUTTON btn){
  switch (btn){
  case CENTER:
    return *btnC;
  case LEFT:
    return *btnL;
  case RIGHT:
    return *btnR;
  case DOWN:
    return *btnD;
  case UP:
    return *btnU;
  }
}
