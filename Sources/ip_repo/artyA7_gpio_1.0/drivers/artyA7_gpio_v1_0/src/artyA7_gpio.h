/*---------------------------------------------*
 *  Title       : Arty A7 GPIO Driver          *
 *  File        : artyA7_gpio.h                *
 *  Author      : Yigit Suoglu                 *
 *  License     : EUPL-1.2                     *
 *  Last Edit   : 10/10/2021                   *
 *---------------------------------------------*
 *  Description : SW driver for artyA7_gpio IP *
 *---------------------------------------------*/

#ifndef ARTYA7_GPIO_H
#define ARTYA7_GPIO_H

#include "xparameters.h"

class artyA7_gpio
{
private:
  unsigned long* config = reinterpret_cast<unsigned long*>(XPAR_ARTYA7_GPIO_0_S_AXI_BASEADDR + XPAR_ARTYA7_GPIO_0_OFFSET_CONFIG);
  unsigned long* led_pwm = reinterpret_cast<unsigned long*>(XPAR_ARTYA7_GPIO_0_S_AXI_BASEADDR + XPAR_ARTYA7_GPIO_0_OFFSET_LED_PWM);
  unsigned long* led_tgl = reinterpret_cast<unsigned long*>(XPAR_ARTYA7_GPIO_0_S_AXI_BASEADDR + XPAR_ARTYA7_GPIO_0_OFFSET_LED);
  volatile unsigned long* sw = reinterpret_cast<unsigned long*>(XPAR_ARTYA7_GPIO_0_S_AXI_BASEADDR + XPAR_ARTYA7_GPIO_0_OFFSET_SW);
  unsigned long* rgb[4] = {reinterpret_cast<unsigned long*>(XPAR_ARTYA7_GPIO_0_S_AXI_BASEADDR + XPAR_ARTYA7_GPIO_0_OFFSET_RGB0),reinterpret_cast<unsigned long*>(XPAR_ARTYA7_GPIO_0_S_AXI_BASEADDR + XPAR_ARTYA7_GPIO_0_OFFSET_RGB1), reinterpret_cast<unsigned long*>(XPAR_ARTYA7_GPIO_0_S_AXI_BASEADDR + XPAR_ARTYA7_GPIO_0_OFFSET_RGB2), reinterpret_cast<unsigned long*>(XPAR_ARTYA7_GPIO_0_S_AXI_BASEADDR + XPAR_ARTYA7_GPIO_0_OFFSET_RGB3)};
  volatile unsigned long* btn[4] = {reinterpret_cast<unsigned long*>(XPAR_ARTYA7_GPIO_0_S_AXI_BASEADDR + XPAR_ARTYA7_GPIO_0_OFFSET_BTN0),reinterpret_cast<unsigned long*>(XPAR_ARTYA7_GPIO_0_S_AXI_BASEADDR + XPAR_ARTYA7_GPIO_0_OFFSET_BTN1), reinterpret_cast<unsigned long*>(XPAR_ARTYA7_GPIO_0_S_AXI_BASEADDR + XPAR_ARTYA7_GPIO_0_OFFSET_BTN2), reinterpret_cast<unsigned long*>(XPAR_ARTYA7_GPIO_0_S_AXI_BASEADDR + XPAR_ARTYA7_GPIO_0_OFFSET_BTN3)};
public:
  artyA7_gpio();
  void keepButtonVal(bool keep = true);
  unsigned long getButton(unsigned char btn_num);
  void ledModeCh(bool pwm);
  bool getledMode(); //True if pwm'ed
  void setToggleBrightness(unsigned char brightness, bool enable = true);
  unsigned char getToggleBrightness();
  void toggleLed(unsigned char led_num);
  void toggleLed(unsigned char led_num, bool lit);
  void toggleLeds();
  void toggleLeds(unsigned char leds);
  void toggleLeds(bool led0, bool led1, bool led2, bool led3);
  unsigned char getToggleLeds();
  unsigned char getSwithes();
  unsigned long getPWMleds();
  unsigned char getPWMled(unsigned char led);
  void setPWMleds(unsigned long leds);
  void setPWMleds(unsigned char led0, unsigned char led1, unsigned char led2, unsigned char led3);
  void setPWMled(unsigned char led, unsigned char val);
  unsigned long getRGB(unsigned char led);
  void setRGB(unsigned char led, unsigned long rgb_val);
  void setRGB(unsigned char led, unsigned char red,  unsigned char green, unsigned char blue);
};

#endif // ARTYA7_GPIO_H
