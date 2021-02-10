#include <WS2812Serial.h>
#define USE_WS2812SERIAL
#include <FastLED.h>

#define NUM_LEDS 233

#define DATA_PIN 1

// Define the array of leds
CRGB leds[NUM_LEDS];

int pixel = 0;            // pixel number that you're changing
int red = 0;              // red value 
int green = 0;           // green value
int blue = 0;            // blue value

void setup() {
	Serial.begin(115200);
  //Serial.setTimeout(10);  // set serial timeout
	LEDS.addLeds<WS2812SERIAL,DATA_PIN,BRG>(leds,NUM_LEDS);
	//LEDS.setBrightness(84);
}

void loop() {
  
 // listen for serial:
  if (Serial.available() > 0) {
    if (Serial.read() == 'C') {    // string should start with C
      pixel = Serial.parseInt(); 
      red = Serial.parseInt(); 
      green = Serial.parseInt();
      blue = Serial.parseInt(); 
    }
  }
  leds[pixel].setRGB(red, green, blue);
  FastLED.show();
}
