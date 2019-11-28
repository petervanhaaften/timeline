
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
SynthDef("test1",{
   var mic = SoundIn.ar(0,1,0),
   amplitude = Amplitude.kr(mic),
   trig = amplitude > 0.1,
   timer = Timer.kr(trig),  // how long since the last trigger?
   filteredTrig = (timer > 0.25) * trig;

	SendTrig.kr(filteredTrig, 0, amplitude);
}).add;

o = OSCFunc({ arg msg, time;
    [time, msg].postln;
},'/tr', s.addr);
)

Synth("test1");
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

RecNodeProxy

// start something to record
x = Synth("voiceinput");

// allocate a disk i/o buffer
b= Buffer.alloc(s, 65536, 2);

// create an output file for this buffer, leave it open
b.write("~/diskouttest4.aiff".standardizePath, "aiff", "int16", 0, 0, true);
// create the diskout node; making sure it comes after the source
d = Synth.tail(nil, "diskout", ["bufnum", b]);
// stop recording
d.free;
// stop the bubbles
x.free;
// close the buffer and the soundfile
b.close;
// free the buffer
b.free;

// play it back
(
x = Synth.basicNew("help-Diskin-2chan");
m = { |buf| x.addToHeadMsg(nil, [\bufnum,buf])};

b = Buffer.cueSoundFile(s,"~/diskouttest.aiff".standardizePath, 0, 2, completionMessage: m);
)
x.free; b.close; b.free; // cleanup