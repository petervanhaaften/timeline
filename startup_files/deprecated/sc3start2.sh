#/bin/sh

cd /usr/local/bin

#export SC_JACK_DEFAULT_INPUTS="alsa_pcm:capture_1,alsa_pcm:capture_2"
#export SC_JACK_DEFAULT_OUTPUTS="alsa_pcm:playback_1,alsa_pcm:playback_2"

scsynth -u 57112 $@
