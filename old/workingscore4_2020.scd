s.options.sampleRate = 44100;
s.boot;

//voice rec synthdef
Require("/Users/pvh/src/Projects/timeline/experiment1/simplerec.scd");
//voice rec logic, interacts with synthdef
~recordvoice = Require("/Users/pvh/src/Projects/timeline/experiment1/simplelogic.scd");
~recordvoice.play
~recordvoice.stop
~recordvoice.resume
~recordvoice.reset
b.play;

b.numFrames = 50;
b.numFrames.postln;
//need to receive position from logic...convert to time, use that for controlling position in gran synth

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
//    GRANULAR INST1
///////////////////////

(
// the multichannel size and equivalently:
// the maximum number of overlapping grains that might get
// different fx parameters have to be fixed.
// For convenience of later L/R-spatialization we take an
// even number ~n = 2 * ~m

~m = 5;
~n = 2 * ~m;

SynthDef(\gran_1e, { |out = 0, soundBuf, gate = 1, attack = 0.01, release = 0.5, posLo = 0.1, posHi = 0.9, posRateE = 0, posRateM= 1, posRateMLag = 0, posRateMCurve = 0, rate= 1, rateLag = 0, rateCurve = 0, panMax = 0.8, bpRQ = 0.1, bpRQLag = 0, bpRQCurve = 0, bpLo = 50, bpLoLag = 0, bpLoCurve = 0, bpHi = 5000, bpHiLag = 0, bpHiCurve = 0, amp = 1, overlap = 2, overlapLag = 0, overlapCurve = 0, trigRate = 1, trigRateLag = 0, trigRateCurve = 0, interp = 2|

    var sig, sigL, sigR, env, bpFreq, chan, bpFreqSeqs, dUgen, trig, trigs, bufDur, pos, posRate;

	trig = Impulse.ar(VarLag.kr(trigRate, trigRateLag, trigRateCurve));

    // we need a multichannel trigger that steps through all consecutive channels
    trigs = { |i| PulseDivider.ar(trig, ~n, ~n-1-i) } ! ~n;

    chan = Demand.ar(trig, 0, Dseq((0..~n-1), inf));

	env = Linen.kr(gate, attack, 1, release, 2) * amp;

    posRate = 10 ** posRateE * VarLag.kr(posRateM, posRateMLag, posRateMCurve);
    bufDur = BufDur.kr(soundBuf);
    pos = Phasor.ar(0, BufRateScale.kr(soundBuf) * posRate * SampleDur.ir / bufDur, posLo, posHi);


    sig = TGrains.ar(~n, trig, soundBuf, VarLag.kr(rate, rateLag, rateCurve), pos * bufDur, VarLag.kr(overlap, overlapLag, overlapCurve)/VarLag.kr(trigRate, trigRateLag, trigRateCurve),
    // Panning convention is that from PanAz,
    // speakers should be from 0 to 2, but (orientation)
    // 1/n has to be substracted for n speakers.
    // If this isn't done correctly grains are spread onto more than one channel
    // and per-grain application of fxs fails.
	chan.linlin(0, ~n-1, -1/~n, (2*~n - 3)/~n), 1, interp);

    dUgen = Dwhite(0.0, 1);
    sig = sig.collect { |ch, i|
    // this is the place to define fxs per channel/grain
    // multichannel trigger is polling from a single demand ugen

	bpFreq = Demand.ar(trigs[i], 0, dUgen).linlin(0, 1, VarLag.kr(bpLo, bpLoLag, bpLoCurve), VarLag.kr(bpHi, bpHiLag, bpHiCurve));

    // amplitude compensation for lower rq of bandpass filter
    BPF.ar(ch, bpFreq, VarLag.kr(bpRQ, bpRQLag, bpRQCurve), (VarLag.kr(bpRQ, bpRQLag, bpRQCurve) ** -1) * (400 / bpFreq ** 0.5));
    };

    // routing to two channels ...
    sigL = Mix(((0..(~m-1)) * 2).collect(sig[_]));
    sigR = Mix(((0..(~m-1)) * 2 + 1).collect(sig[_]));

    // ... in order to have L/R-spreading with panMax as in other examples
	Out.ar(0, Pan2.ar(sigL, panMax.neg) + Pan2.ar(sigR, panMax) * env)
}
).add;

//b = Buffer.read(s, "/Users/pvh/src/Projects/timeline/exampleinput.wav");
)

//b = Buffer.read(s, "/Users/pvh/src/Projects/timeline/exampleinput2.wav");
b.play;
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

///////////////////////
//    SCORE PLAYER
///////////////////////

b = Buffer.alloc(s, 1 * s.sampleRate);

//voice rec synthdef
Require("/Users/pvh/src/Projects/timeline/experiment1/simplerec.scd");
//voice rec logic, interacts with synthdef
~recordvoice = Require("/Users/pvh/src/Projects/timeline/experiment1/simplelogic.scd");
~recordvoice.play;
~recordvoice.stop;
~recordvoice.resume;
~recordvoice.stop.reset;

b.play;
b.writeMsg(path: "/Users/pvh/src/Projects/timeline/experiment1/audio/craprecord.wav", headerFormat: "wav", sampleFormat: "int24", numFrames: 44100, startFrame: 0, leaveOpen: false, completionMessage: "finished".postln;);

thisProcess.platform.recordingsDir;

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
//    SCORE PLAYER2
///////////////////////
(
//~recordvoice.play;
Pdef(\part, Pdef(\main,
	Pseq([
		Pfindur(2, Pdef(\first)),
		Rest(0.5),
		Pfindur(2, Pdef(\second)),
		Rest(0.5),
		//record audio input
		Rest(2),
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
