//node proxy disk record
(
a = RecNodeProxy.audio(s, 1);
a.source = { SoundIn.ar(0,1,0); };
a.open("/Users/pvh/src/Projects/timeline/micinput.wav");
a.record;
)
//start recording / pause
a.unpause;
//pause
a.pause


a.close;
a.free;


//send pause trigger from server to client
(
SynthDef("amptrig",{
   var mic = SoundIn.ar(0,1,0),
   amplitude = Amplitude.kr(mic),
   trig = amplitude > 0.1,
   timer = Timer.kr(trig),  // how long since the last trigger?
   filteredTrig = (timer > 0.3) * trig;

	SendTrig.kr(filteredTrig, 0, amplitude);
}).add;

o = OSCFunc({ arg msg, time;
    [time, msg].postln;
},'/tr', s.addr);
)

Synth("amptrig");
o.free;
