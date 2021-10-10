/*---------------------------------------------*
 *  Title       : Nexys Video GPIO Driver      *
 *  File        : nexysVideo_gpio.h            *
 *  Author      : Yigit Suoglu                 *
 *  License     : EUPL-1.2                     *
 *  Last Edit   : 10/10/2021                   *
 *---------------------------------------------*
 *  Description : SW driver for                *
 *                nexysVideo_gpio IP           *
 *---------------------------------------------*/
#ifndef NEXYSVIDEO_GPIO_H
#define NEXYSVIDEO_GPIO_H

#include "xparameters.h"


class nexysVideo_gpio
{
private:
  unsigned long* config = reinterpret_cast<unsigned long*>(XPAR_NEXYSVIDEO_GPIO_0_S_AXI_BASEADDR + XPAR_NEXYSVIDEO_GPIO_0_OFFSET_CONFIG);
  unsigned long* led = reinterpret_cast<unsigned long*>(XPAR_NEXYSVIDEO_GPIO_0_S_AXI_BASEADDR + XPAR_NEXYSVIDEO_GPIO_0_OFFSET_LED);
  volatile unsigned long* sw = reinterpret_cast<unsigned long*>(XPAR_NEXYSVIDEO_GPIO_0_S_AXI_BASEADDR + XPAR_NEXYSVIDEO_GPIO_0_OFFSET_SW);
  volatile unsigned long* btnC = reinterpret_cast<unsigned long*>(XPAR_NEXYSVIDEO_GPIO_0_S_AXI_BASEADDR + XPAR_NEXYSVIDEO_GPIO_0_OFFSET_BTNC);
  volatile unsigned long* btnD = reinterpret_cast<unsigned long*>(XPAR_NEXYSVIDEO_GPIO_0_S_AXI_BASEADDR + XPAR_NEXYSVIDEO_GPIO_0_OFFSET_BTND);
  volatile unsigned long* btnL = reinterpret_cast<unsigned long*>(XPAR_NEXYSVIDEO_GPIO_0_S_AXI_BASEADDR + XPAR_NEXYSVIDEO_GPIO_0_OFFSET_BTNL);
  volatile unsigned long* btnU = reinterpret_cast<unsigned long*>(XPAR_NEXYSVIDEO_GPIO_0_S_AXI_BASEADDR + XPAR_NEXYSVIDEO_GPIO_0_OFFSET_BTNU);
  volatile unsigned long* btnR = reinterpret_cast<unsigned long*>(XPAR_NEXYSVIDEO_GPIO_0_S_AXI_BASEADDR + XPAR_NEXYSVIDEO_GPIO_0_OFFSET_BTNR);
public:
  enum BUTTON {
    LEFT,
    RIGHT,
    DOWN,
    UP,
    CENTER
  };
  nexysVideo_gpio();
  void keepButton(bool keep = true);
  const unsigned char getSwitches();
  const unsigned char getLeds();
  void setLeds(const unsigned char led_val);
  const unsigned long getButton(BUTTON btn);
};

#endif // NEXYSVIDEO_GPIO_H
