s.options.sampleRate = 44100;
s.boot;
(
// # flag for timeline src directory
// # flag for timeline voice buffer audio directory
// # flag for timeline operator speech audio directory
(
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
e = Buffer.read(s, Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/audio/sayyourname.wav");
);

(
Pdef(\part, Pdef(\operator_intro,
	Ppar([
		Pmono(
			\bufferplay,
			\bufnum, e.bufnum,
			\dur, 1,
		);
	])
));
);



///////////////////////
//    SINE TONE BEEP
///////////////////////
(
SynthDef(\sinbeep, {|freq = 440, out, gate = 1, attack = 0, release = 1, amp = 1|
	var env = Linen.kr(gate, attack, release) * amp;
	Out.ar(out, SinOsc.ar(freq, 0,0.2) * env)
    }
);
);

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
));
);
);
)

///////////////////////
// MASTER CTL
///////////////////////
(
e = Condition.new(false);
r = Routine {
	//the synthesizer for this score
	Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/pvh.gransyn1.scd");
	//voice rec synthdef
	Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/simplerec.scd");
	//voice rec logic, interacts with synthdef
	Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/simplelogic.scd");
	"test1".postln;
	~recordvoice.play;
	5.wait;
	"doneo".postln;
};
)

r.play

///////////////////////
// MASTER SCORE PLAYER
///////////////////////
(
Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/timescoreA1.scd");
//
//
//
//read score elements
//Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/timescoreA1.scd");
//play master score
Pdef(\part, Pdef(\main,
	Pseq([
		//start score
		"part1".postln;
		Pfindur(10, Pdef(\part1)),
		"part2".postln;
		Pfindur(16, Pdef(\part2)),
		"part3".postln;
		Pfindur(16, Pdef(\part3)),
		"part4".postln;
		Pfindur(16, Pdef(\part4)),
		"part5".postln;
		Pfindur(16, Pdef(\part5)),
		"part6".postln;
		Pfindur(16, Pdef(\part6)),
		"part7".postln;
		Pfindur(16, Pdef(\part7)),
	],1),
)).play; //.trace.play;
)

b.play
