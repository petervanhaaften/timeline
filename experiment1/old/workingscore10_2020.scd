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
// MASTER SCORE PLAYER
///////////////////////
(
//the synthesizer for this score
Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/pvh.gransyn1.scd");
//voice rec synthdef
Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/simplerec.scd");
//voice rec logic, interacts with synthdef
Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/simplelogic.scd");
//
//
//
//read score elements
//Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/timescoreA1.scd");
//play master score
Pdef(\part, Pdef(\main,
	Pseq([
		//"say your name, after the tone"
		Pfindur(2, Pdef(\operator_intro)),
		Rest(0.5),
		//beep
		Pfindur(1, Pdef(\second)),
		Rest(3),
		//record audio input
		~recordvoice;,
		Rest(2);
		//beep
		//Pfindur(1, Pdef(\second)),
		//Rest(0.5),
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

Require(Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/timescoreA1.scd");
b.play



///////////////////////
//    SCORE BLOCK 1
///////////////////////

(
Pdef(\part, Pdef(\part1,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, 4,
				\attack, 0,
				\release, 3,
				\posLo, 0.1,
				\posHi, 1,
				\posRateE, 0,
				\posRateM, 1,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([2, 0.5, 2, 0.5], 1),
				\overlapLag, 3,
				\overlapCurve, 5,
				\trigRate, Pseq([20, 9, 5, 50], 1),
				\trigRateLag, 1,
				\trigRateCurve, 1,
				\rate, Pseq([1, 1, 2, 1], 1),
				\rateLag, 4,
				\rateCurve, -1,
				\bpRQ, 0.25,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 50,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 2000,
				\bpHiLag, 2000,
				\bpHiCurve, 1,
				\panmax, 0,
				\amp, 1,
			),
		    Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, 2,
				\attack, 0,
				\release, 4,
				\posLo, 0.1,
				\posHi, 0.70,
				\posRateE, 0,
				\posRateM, 0.001,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([0.01, 0.5, 2, 3], 1),
				\overlapLag, 3,
				\overlapCurve, 5,
				\trigRate, Pseq([10, 9, 2, 100], 1),
				\trigRateLag, 3,
				\trigRateCurve, 1,
				\rate, Pseq([4, 2, 4, 5], 1),
				\rateLag, 2,
				\rateCurve, -1,
				\bpRQ, 0.25,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 50,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 2000,
				\bpHiLag, 2000,
				\bpHiCurve, 1,
				\panmax, 0,
				\amp, Pseq([1, 1, 1, 1], 1),
			),
	])
)).play;
)


///////////////////////
//    SCORE BLOCK 2
///////////////////////

(
Pdef(\part, Pdef(\part2,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([2, 6, 1, 4, 2], 1),
				\attack, 3,
				\release, 7,
				\posLo, 0,
				\posHi, 0.1,
				\posRateE, 0,
				\posRateM, 0.001,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([0.1, 1, 0.1, 1, 2], 1),
				\overlapLag, 1,
				\overlapCurve, 1,
				\trigRate, Pseq([10000, 9, 50, 9, 7], 1),
				\trigRateLag, 2,
				\trigRateCurve, 0.5,
				\rate, Pseq([-1, 1, 2, 0.5, 1.5, 1], 1),
				\rateLag, 2,
				\rateCurve, -1,
				\bpRQ, 0.25,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 50,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 2000,
				\bpHiLag, 2000,
				\bpHiCurve, 1,
				\panmax, 0,
			    \amp, Pseq([0.7, 0.5, 1, 1, 1], 1),
			),
	])
)).play;
)

///////////////////////
//    SCORE BLOCK 3
///////////////////////

(
Pdef(\part, Pdef(\part3,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([4, 4, 8], 1),
				\attack, 3,
				\release, 7,
				\posLo, 0.2,
				\posHi, 0.70,
				\posRateE, 0,
				\posRateM, 0.002,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([3, 5, 8], 1),
				\overlapLag, 1,
				\overlapCurve, 1,
				\trigRate, Pseq([9, 11, 9], 1),
				\trigRateLag, 2,
				\trigRateCurve, 0.5,
				\rate, Pseq([0.5, 0.5, 0.5], 1),
				\rateLag, 2,
				\rateCurve, -1,
				\bpRQ, 0.25,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 50,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 2000,
				\bpHiLag, 2000,
				\bpHiCurve, 1,
				\panmax, 0,
			    \amp, Pseq([0.3, 0.5, 0.5], 1),
			),
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([4, 4, 12], 1),
				\attack, 3,
				\release, 7,
				\posLo, 0.2,
				\posHi, 0.70,
				\posRateE, 0,
				\posRateM, 0.001,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([3, 5, 1], 1),
				\overlapLag, 1,
				\overlapCurve, 1,
				\trigRate, Pseq([15, 50, 9], 1),
				\trigRateLag, 1,
				\trigRateCurve, 0.5,
				\rate, Pseq([2, 2, 3], 1),
				\rateLag, 1,
				\rateCurve, -1,
				\bpRQ, 0.25,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 50,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 2000,
				\bpHiLag, 2000,
				\bpHiCurve, 1,
				\panmax, 0,
			    \amp, Pseq([0, 0.5, 0.2], 1),
			),
	])
)).play;
)

///////////////////////
//    SCORE BLOCK 4
///////////////////////

(
Pdef(\part, Pdef(\part3,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([4, 4, 8], 1),
				\attack, 1,
				\release, 7,
				\posLo, 0.2,
				\posHi, 0.70,
				\posRateE, 0,
				\posRateM, 0.002,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([3, 5, 8], 1),
				\overlapLag, 1,
				\overlapCurve, 1,
				\trigRate, Pseq([9, 11, 9], 1),
				\trigRateLag, 2,
				\trigRateCurve, 0.5,
				\rate, Pseq([0.5, 0.5, 0.5], 1),
				\rateLag, 2,
				\rateCurve, -1,
				\bpRQ, 0.25,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 50,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 2000,
				\bpHiLag, 2000,
				\bpHiCurve, 1,
				\panmax, 0,
			    \amp, Pseq([0.3, 0.5, 0.5], 1),
			),
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([2, 6, 1, 4, 2], 1),
				\attack, 0,
				\release, 12,
				\posLo, 0.6,
				\posHi, 0.90,
				\posRateE, 0,
				\posRateM, 0.001,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([2, 1, 1, 1, 2], 1),
				\overlapLag, 1,
				\overlapCurve, 1,
				\trigRate, Pseq([9, 9, 50, 9, 7], 1),
				\trigRateLag, 2,
				\trigRateCurve, 0.5,
				\rate, Pseq([-1, 1, 1, 0.5, 1, 1], 1),
				\rateLag, 2,
				\rateCurve, -1,
				\bpRQ, 0.25,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 500,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 15000,
				\bpHiLag, 2,
				\bpHiCurve, 1,
				\panmax, 0,
			    \amp, Pseq([1, 1, 1, 1, 1], 1),
			),
	])
)).play;
)

///////////////////////
//    SCORE BLOCK 5
///////////////////////

(
Pdef(\part, Pdef(\part5,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, 4,
				\attack, 0,
				\release, 3,
				\posLo, 0.1,
				\posHi, 0.30,
				\posRateE, 0,
				\posRateM, 1,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([2, 0.5, 2, 0.5], 1),
				\overlapLag, 3,
				\overlapCurve, 5,
				\trigRate, Pseq([20, 9, 5, 50], 1),
				\trigRateLag, 1,
				\trigRateCurve, 1,
				\rate, Pseq([1, 1, 2, 1], 1),
				\rateLag, 4,
				\rateCurve, -1,
				\bpRQ, 0.25,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 50,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 2000,
				\bpHiLag, 2000,
				\bpHiCurve, 1,
				\panmax, 0,
				\amp, 1,
			),
		    Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([2, 6, 1, 4, 2], 1),
				\attack, 3,
				\release, 7,
				\posLo, 0.6,
				\posHi, 0.90,
				\posRateE, 0,
				\posRateM, 0.001,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([0.1, 1, 0.1, 1, 2], 1),
				\overlapLag, Pseq([1, 1, 0, 0, 0], 1),
				\overlapCurve, 1,
				\trigRate, Pseq([10000, 9, 70, 9, 7], 1),
				\trigRateLag, Pseq([2, 2, 0, 2, 0], 1),
				\trigRateCurve, 0.5,
				\rate, Pseq([-1, 1, 2, 0.5, 1.5, 1], 1),
				\rateLag, 0,
				\rateCurve, -1,
				\bpRQ, 0.25,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 50,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 2000,
				\bpHiLag, 2000,
				\bpHiCurve, 1,
				\panmax, 0,
			    \amp, Pseq([1, 1, 1, 1, 1], 1),
			),
	])
)).play;
)


///////////////////////
//    SCORE BLOCK 6
///////////////////////

(
Pdef(\part, Pdef(\part6,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([4, 4, 8], 1),
				\attack, 0,
				\release, 12,
				\posLo, 0.5,
				\posHi, 0.90,
				\posRateE, 0,
				\posRateM, 0.001,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([2, 2, 1.5], 1),
				\overlapLag, 1,
				\overlapCurve, 1,
				\trigRate, Pseq([18, 22, 18], 1),
				\trigRateLag, 2,
				\trigRateCurve, 0.5,
				\rate, Pseq([0.5, 1, 0.5], 1),
				\rateLag, 0,
				\rateCurve, -1,
				\bpRQ, 0.5,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 50,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 10000,
				\bpHiLag, 0,
				\bpHiCurve, 1,
				\panmax, 0,
			    \amp, Pseq([1, 1, 1], 1),
			),
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([2, 6, 1, 4, 2], 1),
				\attack, 0,
				\release, 12,
				\posLo, 0.6,
				\posHi, 0.90,
				\posRateE, 0,
				\posRateM, 0.001,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([2, 2, 2], 1),
				\overlapLag, 1,
				\overlapCurve, 1,
				\trigRate, Pseq([1, 0.5, 1], 1),
				\trigRateLag, 2,
				\trigRateCurve, 0.5,
				\rate, Pseq([-1, 1, 1], 1),
				\rateLag, 2,
				\rateCurve, -1,
				\bpRQ, 0.25,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 500,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 15000,
				\bpHiLag, 2,
				\bpHiCurve, 1,
				\panmax, 0,
			    \amp, Pseq([1, 1, 1], 1),
			),
	])
)).play;
)

///////////////////////
//    SCORE BLOCK 7
///////////////////////

(
Pdef(\part, Pdef(\part7,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([4, 4, 8], 1),
				\attack, 0,
				\release, 12,
				\posLo, 0.5,
				\posHi, 0.90,
				\posRateE, 0,
				\posRateM, 0.001,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([2, 2, 1.5], 1),
				\overlapLag, 1,
				\overlapCurve, 1,
				\trigRate, Pseq([18, 22, 18], 1),
				\trigRateLag, 2,
				\trigRateCurve, 0.5,
				\rate, Pseq([0.5, 1, 0.5], 1),
				\rateLag, 0,
				\rateCurve, -1,
				\bpRQ, 0.5,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 50,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 10000,
				\bpHiLag, 0,
				\bpHiCurve, 1,
				\panmax, 0,
			    \amp, Pseq([1, 1, 1], 1),
			),
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([2, 6, 1, 4, 2], 1),
				\attack, 0,
				\release, 12,
				\posLo, 0.6,
				\posHi, 0.90,
				\posRateE, 0,
				\posRateM, 0.001,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([2, 2, 2], 1),
				\overlapLag, 1,
				\overlapCurve, 1,
				\trigRate, Pseq([1, 0.5, 1], 1),
				\trigRateLag, 2,
				\trigRateCurve, 0.5,
				\rate, Pseq([-1, 1, 1], 1),
				\rateLag, 2,
				\rateCurve, -1,
				\bpRQ, 0.25,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 500,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 15000,
				\bpHiLag, 2,
				\bpHiCurve, 1,
				\panmax, 0,
			    \amp, Pseq([1, 1, 1], 1),
			),
				Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([4, 4, 8], 1),
				\attack, 1,
				\release, 12,
				\posLo, 0.3,
				\posHi, 0.70,
				\posRateE, 0,
				\posRateM, 0.002,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([10, 10, 8], 1),
				\overlapLag, 1,
				\overlapCurve, 1,
				\trigRate, Pseq([9, 11, 9], 1),
				\trigRateLag, 2,
				\trigRateCurve, 0.5,
				\rate, Pseq([0.5, 0.5, 1], 1),
				\rateLag, 5,
				\rateCurve, -1,
				\bpRQ, 0.75,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 2000,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 5000,
				\bpHiLag, 2000,
				\bpHiCurve, 1,
				\panmax, 0,
			    \amp, Pseq([1, 1, 1], 1),
			),
	])
)).play;
)
