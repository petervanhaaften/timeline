//PVH-phone-stair-lighting
//send serial message "C [stairnum] red green blue"

#include <WS2812Serial.h>
#define USE_WS2812SERIAL
#include <FastLED.h>

#define NUM_LEDS 233

#define DATA_PIN 1

// Define the array of leds
CRGB leds[NUM_LEDS];
//#define BRIGHTNESS  20
int step1_red = 0;
int step1_green = 0;
int step1_blue = 0;
int step2_red = 0;
int step2_green = 0;
int step2_blue = 0;
int step3_red = 0;
int step3_green = 0;
int step3_blue = 0;
int step4_red = 0;
int step4_green = 0;
int step4_blue = 0;
int step5_red = 0;
int step5_green = 0;
int step5_blue = 0;
int step6_red = 0;
int step6_green = 0;
int step6_blue = 0;
int step7_red = 0;
int step7_green = 0;
int step7_blue = 0;
void setup() {
	//Serial.begin(115200);
  Serial.begin(57600);
  Serial.setTimeout(10);  // set serial timeout
	LEDS.addLeds<WS2812SERIAL,DATA_PIN,BRG>(leds,NUM_LEDS);
	//LEDS.setBrightness(84);
}

void loop() {
  
 // listen for serial:
  if (Serial.available() > 0) {
    if (Serial.read() == 'C') {    // string should start with C
      step1_red = Serial.parseInt(); 
      step1_green = Serial.parseInt();
      step1_blue = Serial.parseInt(); 
      step2_red = Serial.parseInt(); 
      step2_green = Serial.parseInt();
      step2_blue = Serial.parseInt(); 
      step3_red = Serial.parseInt(); 
      step3_green = Serial.parseInt();
      step3_blue = Serial.parseInt(); 
      step4_red = Serial.parseInt(); 
      step4_green = Serial.parseInt();
      step4_blue = Serial.parseInt(); 
      step5_red = Serial.parseInt(); 
      step5_green = Serial.parseInt();
      step5_blue = Serial.parseInt(); 
      step6_red = Serial.parseInt(); 
      step6_green = Serial.parseInt();
      step6_blue = Serial.parseInt(); 
      step7_red = Serial.parseInt(); 
      step7_green = Serial.parseInt();
      step7_blue = Serial.parseInt(); 
    }
  }
  for (int i = 167; i <= 191; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = step1_red; 
        leds[i].g = step1_green;
        leds[i].b = step1_blue;
    }    
  for (int i = 139; i <= 166; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = step2_red; 
        leds[i].g = step2_green;
        leds[i].b = step2_blue;
    }
  for (int i = 108; i <= 138; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = step3_red; 
        leds[i].g = step3_green;
        leds[i].b = step3_blue;
    }
  for (int i = 75; i <= 107; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = step4_red; 
        leds[i].g = step4_green;
        leds[i].b = step4_blue;
    }
  for (int i = 39; i <= 74; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = step5_red; 
        leds[i].g = step5_green;
        leds[i].b = step5_blue;
    }
  for (int i = 0; i <= 38; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = step6_red; 
        leds[i].g = step6_green;
        leds[i].b = step6_blue;
    }    
  for (int i = 192; i <= 232; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = step7_red; 
        leds[i].g = step7_green;
        leds[i].b = step7_blue;
    }
  //leds[pixel].setRGB(red, green, blue);
  FastLED.show();
}
