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

void setup() {
    FastLED.addLeds<NUM_STRIPS, WS2812B, 19, GRB>(leds, NUM_LEDS_PER_STRIP);
}

void loop() { 
  for( int i = 0; i < NUM_LEDS_PER_STRIP; i++) {
    /*
    leds[i] = CRGB::Red; FastLED.show();
    leds[i] = CRGB::Black; FastLED.show();
    */
    leds[i].r = 0; FastLED.show();
    leds[i].g = 0;FastLED.show();
    leds[i].b = 255;FastLED.show();
  }

}

/*
void setup() {
  delay(3000); // sanity delay
  FastLED.addLeds<CHIPSET, LED_PIN, COLOR_ORDER>(leds, NUM_LEDS).setCorrection( TypicalLEDStrip );
  FastLED.setBrightness( BRIGHTNESS );
}

void loop() {
  // Step 1.  Cool down every cell a little
    for( int i = 0; i < NUM_LEDS; i++) {
        Serial.readBytes( (char*)(&leds[i]), 3);
    }
}
*/
