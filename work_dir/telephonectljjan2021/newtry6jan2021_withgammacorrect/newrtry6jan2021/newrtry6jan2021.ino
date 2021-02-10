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

    const uint8_t PROGMEM gamma8[] = {
        0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
        0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,
        1,  1,  1,  1,  1,  1,  1,  1,  1,  2,  2,  2,  2,  2,  2,  2,
        2,  3,  3,  3,  3,  3,  3,  3,  4,  4,  4,  4,  4,  5,  5,  5,
        5,  6,  6,  6,  6,  7,  7,  7,  7,  8,  8,  8,  9,  9,  9, 10,
       10, 10, 11, 11, 11, 12, 12, 13, 13, 13, 14, 14, 15, 15, 16, 16,
       17, 17, 18, 18, 19, 19, 20, 20, 21, 21, 22, 22, 23, 24, 24, 25,
       25, 26, 27, 27, 28, 29, 29, 30, 31, 32, 32, 33, 34, 35, 35, 36,
       37, 38, 39, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 50,
       51, 52, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 66, 67, 68,
       69, 70, 72, 73, 74, 75, 77, 78, 79, 81, 82, 83, 85, 86, 87, 89,
       90, 92, 93, 95, 96, 98, 99,101,102,104,105,107,109,110,112,114,
      115,117,119,120,122,124,126,127,129,131,133,135,137,138,140,142,
      144,146,148,150,152,154,156,158,160,162,164,167,169,171,173,175,
      177,180,182,184,186,189,191,193,196,198,200,203,205,208,210,213,
      215,218,220,223,225,228,231,233,236,239,241,244,247,249,252,255
      };
      
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

  for (uint16_t i = 0; i < NUM_LEDS; i++)
    {
      leds[i].r = dim8_video(leds[i].r);
      leds[i].g = dim8_video(leds[i].g);
      leds[i].b = dim8_video(leds[i].b);
    }
  //leds[pixel].setRGB(red, green, blue);
  FastLED.show();
}
