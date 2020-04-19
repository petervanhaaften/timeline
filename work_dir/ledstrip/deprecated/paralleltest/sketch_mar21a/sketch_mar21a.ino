#include "FastLED.h"

#define NUM_LEDS_PER_STRIP 22
#define NUM_STRIPS 1

CRGB leds[NUM_LEDS_PER_STRIP * NUM_STRIPS];

void setup() {
    FastLED.addLeds<NUM_STRIPS, WS2812B, 19, GRB>(leds, NUM_LEDS_PER_STRIP);
}
