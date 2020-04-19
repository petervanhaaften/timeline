/*#include <FastLED.h>

#define LED_PIN     2
#define COLOR_ORDER RGB
#define CHIPSET     WS2812B
#define NUM_LEDS    30
#define BRIGHTNESS  200

//CRGB leds[NUM_LEDS];
*/
#include <FastLED.h>
#define NUM_LEDS_PER_STRIP 22
#define NUM_STRIPS 1

CRGB leds[NUM_LEDS_PER_STRIP * NUM_STRIPS];

int pixel = 0;            // pixel number that you're changing
int red = 0;              // red value 
int green = 34;           // green value
int blue = 12;            // blue value


void setup() {
    //Serial.begin(57600);     // initialize serial communication
    //Serial.setTimeout(10);  // set serial timeout
    FastLED.addLeds<NUM_STRIPS, WS2812B, 19, GRB>(leds, NUM_LEDS_PER_STRIP);
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
      //leds[pixel].r = red; FastLED.show();
      //leds[pixel].g = green;FastLED.show();
      //leds[pixel].b = blue;FastLED.show();
      leds[pixel].setRGB(red, green, blue);
      FastLED.show();
}
