/*---------------------------------------------*
 *  Title       : Arty A7 GPIO Driver          *
 *  File        : artyA7_gpio.cpp              *
 *  Author      : Yigit Suoglu                 *
 *  License     : EUPL-1.2                     *
 *  Last Edit   : 10/10/2021                   *
 *---------------------------------------------*
 *  Description : SW driver for artyA7_gpio IP *
 *---------------------------------------------*/

#include "artyA7_gpio.h"

artyA7_gpio::artyA7_gpio(){
}

void artyA7_gpio::keepButtonVal(bool keep){
  if(keep){
    *config |= 0x1; 
  }else{
    *config &= 0xFFFFFFFE; 
  }
}

unsigned long artyA7_gpio::getButton(unsigned char btn_num){
  return *btn[btn_num];
}

void artyA7_gpio::ledModeCh(bool pwm){
  if(pwm){
    *config &= 0xFFFFFFFD;
  }else{
    *config |= 0x2; 
  }
}

//True if pwm'ed
bool artyA7_gpio::getledMode(){
  unsigned long buff = *config;
  return (buff & 0x2) == 0x0;
}

void artyA7_gpio::setToggleBrightness(unsigned char brightness, bool enable){
  unsigned long config_new = (brightness << 2) | (*config & 0x3);
  if (enable){
    config_new |= 0x2;
  }
  *config  = config_new;
}

unsigned char artyA7_gpio::getToggleBrightness(){
  return static_cast<unsigned char>(*config >> 2);
}

void artyA7_gpio::toggleLed(unsigned char led_num){
  unsigned char mask = 0x1 << led_num;
  *led_tgl ^= mask;
}

void artyA7_gpio::toggleLed(unsigned char led_num, bool lit){
  unsigned char mask = 0x1 << led_num;
  if(lit){
    *led_tgl |= mask;
  }else{
    *led_tgl &= ~mask;
  }
}

void artyA7_gpio::toggleLeds(){
  *led_tgl ^= 0xF;
}

void artyA7_gpio::toggleLeds(unsigned char leds){
  *led_tgl = static_cast<unsigned long>(leds);
}


void artyA7_gpio::toggleLeds(bool led0, bool led1, bool led2, bool led3){
  unsigned char leds = 0x0;
  if(led3){
    leds |= 0x1;
  }
  leds = leds << 1;
  if(led2){
    leds |= 0x1;
  }
  leds = leds << 1;
  if(led1){
    leds |= 0x1;
  }
  leds = leds << 1;
  if(led0){
    leds |= 0x1;
  }
  *led_tgl = static_cast<unsigned long>(leds);
}


unsigned char artyA7_gpio::getToggleLeds(){
  return static_cast<unsigned char>(*led_tgl);
}

unsigned char artyA7_gpio::getSwithes(){
  return static_cast<unsigned char>(*sw);
}

unsigned long artyA7_gpio::getPWMleds(){
  return *led_pwm;
}

unsigned char artyA7_gpio::getPWMled(unsigned char led){
  return static_cast<unsigned char>(*led_pwm >> (led * 8));
}

void artyA7_gpio::setPWMleds(unsigned long leds){
  *led_pwm = leds;
}

void artyA7_gpio::setPWMleds(unsigned char led0, unsigned char led1, unsigned char led2, unsigned char led3){
  *led_pwm = (static_cast<unsigned long>(led3) << 24) | (static_cast<unsigned long>(led2) << 16) | (static_cast<unsigned long>(led1) << 8) |
  static_cast<unsigned long>(led0);
 }

void artyA7_gpio::setPWMled(unsigned char led, unsigned char val){
  unsigned long mask = 0xFF << (led * 8);
  unsigned long led_long = static_cast<unsigned long>(val) << (led * 8);
  *led_pwm = (*led_pwm & ~mask) | led_long;
}

unsigned long artyA7_gpio::getRGB(unsigned char led){
  return *rgb[led];
}

void artyA7_gpio::setRGB(unsigned char led, unsigned long rgb_val){
  *rgb[led] = rgb_val;
}

void artyA7_gpio::setRGB(unsigned char led, unsigned char red,  unsigned char green, unsigned char blue){
  *rgb[led] = static_cast<unsigned long>(blue) | (static_cast<unsigned long>(green) << 8) | (static_cast<unsigned long>(red) << 16);
}
