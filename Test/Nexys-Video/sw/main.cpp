#include "nexysVideo_gpio.h"

int main(){
  nexysVideo_gpio gpio;
  gpio.keepButton();

  while (true){
    switch (gpio.getSwitches()){
    case 1:
      gpio.setLeds(gpio.getButton(nexysVideo_gpio::CENTER));
      continue;
    case 2:
      gpio.setLeds(gpio.getButton(nexysVideo_gpio::LEFT));
      continue;
    case 4:
      gpio.setLeds(gpio.getButton(nexysVideo_gpio::RIGHT));
      continue;
    case 8:
      gpio.setLeds(gpio.getButton(nexysVideo_gpio::UP));
      continue;
    case 16:
      gpio.setLeds(gpio.getButton(nexysVideo_gpio::DOWN));
      continue;
    default:
      continue;
    }
  }
  
	return 0;
}
