
(
a = RecNodeProxy.audio(s, 1);
a.source = { SoundIn.ar(0,1,0); };
a.open("/Users/pvh/src/Projects/timeline/micinput.wav");
a.record;
)


a.unpause;
a.pause


a.close;
a.free;



//send pause trig from server
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



(
var a = 1, z;
z = if (a < 5, { 100 },{ 200 });
z.postln;
)

//RETRYsend pause trig from server
(
SynthDef("test2",{
   var mic = SoundIn.ar(0,1,0),
   amplitude = Amplitude.kr(mic),
   trig = amplitude > 0.1,
   timer = Timer.kr(trig),  // how long since the last trigger?
   filteredTrig = (timer > 0.25) * trig;

   SendTrig.kr(filteredTrig, 0, 1);
	//send detect silence trig?
}).add;

o = OSCFunc({ arg msg;
	if (msg[3] == 1.0, { a.unpause },{ 200.postln });
},'/tr', s.addr);
)

Synth("test2");
o.free;



(
///INPUT

SynthDef("voiceinput", { |out|
	var microphone;
	microphone = SoundIn.ar(0,1,0);
	Out.ar(out, microphone);
}).add;

//RECORD TO DISK
SynthDef("diskout", { |bufnum|
    DiskOut.ar(bufnum, In.ar(0,2));
}).add;

//PLAYBACK
SynthDef("diskin", { |out, bufnum = 0|
    Out.ar(out, DiskIn.ar(2, bufnum))
}).add;
)
)
