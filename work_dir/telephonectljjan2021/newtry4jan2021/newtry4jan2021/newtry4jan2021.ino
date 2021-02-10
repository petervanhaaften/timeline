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

int pixel = 0;            // pixel number that you're changing
int red = 0;              // red value 
int green = 0;           // green value
int blue = 0;            // blue value
int stair = 0;          // default stair value

void setup() {
	Serial.begin(115200);
  //Serial.begin(57600);
  Serial.setTimeout(10);  // set serial timeout
	LEDS.addLeds<WS2812SERIAL,DATA_PIN,BRG>(leds,NUM_LEDS);
	//LEDS.setBrightness(84);
}

void loop() {
  
 // listen for serial:
  if (Serial.available() > 0) {
    if (Serial.read() == 'C') {    // string should start with C
      stair = Serial.parseInt(); 
      red = Serial.parseInt(); 
      green = Serial.parseInt();
      blue = Serial.parseInt(); 
    }
  }
  if (stair == 1) {
    for (int i = 167; i <= 191; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = red; 
        leds[i].g = green;
        leds[i].b = blue;
    }
  }
  if (stair == 2) {
    for (int i = 139; i <= 166; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = red; 
        leds[i].g = green;
        leds[i].b = blue;
    }
  }
    if (stair == 3) {
    for (int i = 108; i <= 138; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = red; 
        leds[i].g = green;
        leds[i].b = blue;
    }
  }
    if (stair == 4) {
    for (int i = 75; i <= 107; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = red; 
        leds[i].g = green;
        leds[i].b = blue;
    }
  }
    if (stair == 5) {
    for (int i = 39; i <= 74; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = red; 
        leds[i].g = green;
        leds[i].b = blue;
    }
  }
    if (stair == 6) {
    for (int i = 0; i <= 38; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = red; 
        leds[i].g = green;
        leds[i].b = blue;
    }
  }
    if (stair == 7) {
    for (int i = 192; i <= 232; i++) { 
        //leds[i] = CRGB(255, 255, 0);
        //leds[i] = CRGB(red, green, blue);
        leds[i].r = red; 
        leds[i].g = green;
        leds[i].b = blue;
    }
  }
  //leds[pixel].setRGB(red, green, blue);
  FastLED.show();
}
