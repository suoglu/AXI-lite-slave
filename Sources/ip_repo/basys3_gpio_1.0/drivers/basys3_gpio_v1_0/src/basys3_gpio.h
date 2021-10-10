/*---------------------------------------------*
 *  Title       : Basys 3 GPIO Driver          *
 *  File        : basys3_gpio.cpp              *
 *  Author      : Yigit Suoglu                 *
 *  License     : EUPL-1.2                     *
 *  Last Edit   : 09/10/2021                   *
 *---------------------------------------------*
 *  Description : SW driver for basys3_gpio IP *
 *---------------------------------------------*/

#ifndef BASYS3_GPIO_H
#define BASYS3_GPIO_H

#include "xparameters.h"


class basys3_gpio
{private:
  unsigned long* config = reinterpret_cast<unsigned long*>(XPAR_BASYS3_GPIO_0_S_AXI_BASEADDR + XPAR_BASYS3_GPIO_0_OFFSET_CONFIG);
  unsigned long* leds = reinterpret_cast<unsigned long*>(XPAR_BASYS3_GPIO_0_S_AXI_BASEADDR + XPAR_BASYS3_GPIO_0_OFFSET_LED);
  volatile unsigned long* switches = reinterpret_cast<unsigned long*>(XPAR_BASYS3_GPIO_0_S_AXI_BASEADDR + XPAR_BASYS3_GPIO_0_OFFSET_SW);
  unsigned long* ssd = reinterpret_cast<unsigned long*>(XPAR_BASYS3_GPIO_0_S_AXI_BASEADDR + XPAR_BASYS3_GPIO_0_OFFSET_SSD);
  volatile unsigned long* btn_left = reinterpret_cast<unsigned long*>(XPAR_BASYS3_GPIO_0_S_AXI_BASEADDR + XPAR_BASYS3_GPIO_0_OFFSET_BTNL);
  volatile unsigned long* btn_right = reinterpret_cast<unsigned long*>(XPAR_BASYS3_GPIO_0_S_AXI_BASEADDR + XPAR_BASYS3_GPIO_0_OFFSET_BTNR);
  volatile unsigned long* btn_up = reinterpret_cast<unsigned long*>(XPAR_BASYS3_GPIO_0_S_AXI_BASEADDR + XPAR_BASYS3_GPIO_0_OFFSET_BTNU);
  volatile unsigned long* btn_down = reinterpret_cast<unsigned long*>(XPAR_BASYS3_GPIO_0_S_AXI_BASEADDR + XPAR_BASYS3_GPIO_0_OFFSET_BTND);
public:
  basys3_gpio();
  enum BUTTON {
    LEFT,
    RIGHT,
    DOWN,
    UP
  };
  void keepButtonVal(bool keep = true);
  void digits(bool digit3enabled = true, bool digit2enabled = true, bool digit1enabled = true, bool digit0enabled = true);
  void digits(unsigned char mask = 0xF);
  const unsigned short getLeds();
  void setLeds(unsigned short led);
  const unsigned short getSwitches();
  const unsigned short getSSD();
  void setSSD(unsigned short val);
  unsigned long getButton(BUTTON btn);
};

#endif // BASYS3_GPIO_H
