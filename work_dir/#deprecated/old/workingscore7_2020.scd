s.options.sampleRate = 44100;
s.boot;

///////////////////////
// VOICE-REC PDEF
///////////////////////
(
SynthDef(\rectest, {
	~recordvoice.play;
    }
).add;
)

~recordvoice.play
~recordvoice.stop
~recordvoice.free

~fuck = Synth(\rectest);
~fuck.play;

(
Pdef(\part, Pdef(\recording,
	Ppar([
		Pmono(
			\rectest,
			\dur, 5,
		);
	])
)).play;
)


///////////////////////
//  SINBEEP SYNTHDEF
///////////////////////
(
SynthDef(\sinbeep, {|freq = 440, out, gate = 1, attack = 0, release = 1, amp = 1|
	var env = Linen.kr(gate, attack, release) * amp;
	Out.ar(out, SinOsc.ar(freq, 0,0.2) * env)
    }
).play;
)


///////////////////////
// VOICE INTRO SYNTHDEF
///////////////////////

(
SynthDef("bufferplay",{ arg out = 0, bufnum;
			Out.ar( out,
				PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
			)
}
).add;
c = Buffer.read(s, "/Users/pvh/src/Projects/timeline/sayyourname.wav");
)

(
Pdef(\part, Pdef(\first,
	Ppar([
		Pmono(
			\bufferplay,
			\bufnum, c.bufnum,
			\dur, 1,
		);
	])
)).play;
)

///////////////////////
//    SINE TONE BEEP
///////////////////////

(
Pdef(\part, Pdef(\second,
	Ppar([
		Pmono(
			\sinbeep,
			\dur, 1,
			\amp, 2,
			\attack, 0,
			\release, 1,
			\freq, 440,
		);
	])
)).play;
)



///////////////////////
//    SCORE PLAYER
///////////////////////

(
//the timescore
//Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/timescoreA1.scd");
//the synthesizer
Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/pvh.gransyn1.scd");
//voice rec synthdef
Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/simplerec.scd");
//voice rec logic, interacts with synthdef
~recordvoice = Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/simplelogic.scd");
)
//~recordvoice.play;

////////////////
//clean up printed wave with command line utilities
(
~wavprocess = Routine {
	//normalise recorded wave w/sox
	a = "/usr/local/bin/sox" + Platform.userHomeDir +/+ "/src/Projects/timeline/experiment1/audio/bufferrec1.wav" + Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/audio/bufferrec1_normalised.wav" + "gain -n -3";
	a.unixCmd("done : normalise".postln, false);
	0.1.wait;
	//compress recorded file
	//compand 0.02,0.2 5:-60,-40,-20 -5 -80 0.1
	c = "/usr/local/bin/sox" + Platform.userHomeDir +/+ "/src/Projects/timeline/experiment1/audio/bufferrec1_normalised.wav" + Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/audio/bufferrec1_compressed.wav" + "compand 0.02,0.2 5:-60,-40,-20 -5 -80 0.1";
	c.unixCmd("done : compression".postln, false);
	0.1.wait;
	//switch buffer
	b = Buffer.read(s, Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/audio/bufferrec1_compressed.wav");
};
)

////////////////

b.play;
b.plot;

SynthDef(\sine, {arg out=0, amp=0.1, freq=440, envdur=1, pan=0.0;
	var signal;
	signal = Pan2.ar(SinOsc.ar(freq, 0, amp**amp).cubed, pan); // note the pan
	signal = signal * EnvGen.ar(Env.perc(0.01, envdur), doneAction:2);
	Out.ar(out, signal);
}).add;
(
Routine({
	1.postln;
	~recordvoice.play;
	Synth(\sine, [\freq, 220]);
	0.1.wait;
	2.postln;
	Synth(\sine, [\freq, 220*2]);
	0.8.wait;
	3.postln;
	Synth(\sine, [\freq, 220*3]);
	0.5.wait;
}).play
)

///////////////////////
// MASTER SCORE PLAYER
///////////////////////
(
//read score elements
Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/timescoreA1.scd");
//play master score
Pdef(\part, Pdef(\main,
	Pseq([
		//Pfindur(2, Pdef(\first)),
		//Rest(0.5),
		//Pfindur(2, Pdef(\second)),
		//Rest(0.5),
		//record audio input
		//Rest(2),
		Pfindur(10, Pdef(\part1)),
		Pfindur(16, Pdef(\part2)),
		Pfindur(16, Pdef(\part3)),
		Pfindur(16, Pdef(\part4)),
		Pfindur(16, Pdef(\part5)),
		Pfindur(16, Pdef(\part6)),
		Pfindur(16, Pdef(\part7)),
	],1),
)).play; //.trace.play;
)
