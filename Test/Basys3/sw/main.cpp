#include "basys3_gpio.h"

int main(){
	
basys3_gpio gpio;

unsigned long state = 0x0;
unsigned char ssd_mode = 0x0;

gpio.keepButtonVal();
while(true){
	gpio.setLeds(gpio.getSwitches());
    gpio.setSSD(gpio.getButton(basys3_gpio::RIGHT));
    if(state != gpio.getButton(basys3_gpio::LEFT)){
    	state = gpio.getButton(basys3_gpio::LEFT);
      ssd_mode = (ssd_mode << 1) | 0x1;
      if(ssd_mode == 0x1f){
        ssd_mode = 0x0;
      }
      gpio.digits(ssd_mode);
    }
	}
	return 0;
}
