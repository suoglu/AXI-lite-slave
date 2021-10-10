#include "artyA7_gpio.h"

int main(){
	
  artyA7_gpio gpio;

  gpio.keepButtonVal();

  unsigned char sw = 0;
  unsigned char btn0 = 0;
  unsigned char btn1 = 0;
  unsigned long buff;

  

  while(true){
    if(btn1 != gpio.getButton(1)){
      btn1 = gpio.getButton(1);
      gpio.ledModeCh(~gpio.getledMode());
    }
    if(btn0 == gpio.getButton(0)){
      continue;
    }else{
      btn0 = gpio.getButton(0);
    }
    sw = gpio.getSwithes();

    switch (sw){
    case 1:
      buff = gpio.getRGB(0) + 0x20;
      gpio.setRGB(0, buff);
      break;
    case 2:
      buff = gpio.getRGB(1) + 0x2000;
      gpio.setRGB(1, buff);
      break;
    case 3:
      buff = gpio.getRGB(2) + 0x200000;
      gpio.setRGB(2, buff);
      break;
    case 4:
      buff = gpio.getRGB(3) + 0x80;
      gpio.setRGB(3, buff);
      break;
    case 5:
      buff = gpio.getToggleLeds() + 0x1;
      gpio.toggleLeds(buff);
      break;
    case 6:
      gpio.toggleLeds();
      break;
    case 7:
      buff = gpio.getToggleBrightness() + 0x20;
      gpio.setToggleBrightness(buff);
      break;
    case 8:
      buff = gpio.getPWMled(0) + 0x40;
      gpio.setPWMled(0, buff);
      break;
    case 9:
      buff = gpio.getPWMled(1) + 0x40;
      gpio.setPWMled(1, buff);
      break;
    case 10:
      buff = gpio.getPWMled(2) + 0x40;
      gpio.setPWMled(2, buff);
      break;
    case 11:
      buff = gpio.getPWMled(3) + 0x40;
      gpio.setPWMled(3, buff);
      break;
    }
  }

	return 0;
}
