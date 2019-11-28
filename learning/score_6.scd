// TGrains and other granular ugens allow per-grain processing
// for a limited number of parameters (pos, rate etc.)
// Nevertheless it is possible to apply arbitrary effects with
// per-grain parameter changes, even if grains overlap.
// This can be achieved by defining the granulation output
// as a multichannel signal and appropriate triggering of fx parameters.
// The example is adapted from a recommendation of Julian Rohrhuber.

// The method is elegant but also a bit tricky in terms of
// multichannel triggering and channel routing.
// See Ex.1f for achieving the same with DX ugens

(
// the multichannel size and equivalently:
// the maximum number of overlapping grains that might get
// different fx parameters have to be fixed.
// For convenience of later L/R-spatialization we take an
// even number ~n = 2 * ~m

~m = 5;
~n = 2 * ~m;

SynthDef(\gran_1e, { |out = 0, soundBuf, gate = 1, attack = 0.01, release = 0.5, posLo = 0.1, posHi = 0.9, posRateE = 0, posRateM = 1, posRateMLag = 0, posRateMNext = 0, rate = 1, rateLag = 0, rateNext = 0, panMax = 0.8, bpRQ = 0.1, bpRQLag = 0, bpRQNext = 0, bpLo = 50, bpLoLag = 0, bpLoNext = 0, bpHi = 5000, bpHiLag = 0, bpHiNext = 0, amp = 1, overlap = 2, overlapLag = 0, overlapNext = 0, trigRate = 1, trigRateLag = 0, trigRateNext = 0, interp = 2|

    var sig, sigL, sigR, env, bpFreq, chan, bpFreqSeqs, dUgen,
        trig, trigs, bufDur, pos, posRate;
	//add glide for overlap, rate, posRateM, bpLow, bpHi, bpRQ, *amp
	//dealing with gliss/lag
	var trigRateGliss = XLine.kr(trigRate, trigRateNext, trigRateLag);
	var overlapGliss = XLine.kr(overlap, overlapNext, overlapLag);
	var rateGliss = XLine.kr(rate, rateNext, rateLag);
	var posRateMGliss = XLine.kr(posRateM, posRateMNext, posRateMLag);
	var bpLoGliss = XLine.kr(bpLo, bpLoNext, bpLoLag);
	var bpHiGliss = XLine.kr(bpHi, bpHiNext, bpHiLag);
	var bpRQGliss = XLine.kr(bpRQ, bpRQNext, bpRQLag);

    trig = Impulse.ar(trigRateGliss);
    // we need a multichannel trigger that steps through all consecutive channels
    trigs = { |i| PulseDivider.ar(trig, ~n, ~n-1-i) } ! ~n;

    chan = Demand.ar(trig, 0, Dseq((0..~n-1), inf));

	env = Linen.kr(gate, attack, 1, release, 2) * amp;

    posRate = 10 ** posRateE * posRateMGliss;
    bufDur = BufDur.kr(soundBuf);
    pos = Phasor.ar(0, BufRateScale.kr(soundBuf) * posRate * SampleDur.ir / bufDur, posLo, posHi);

    sig = TGrains.ar(~n, trig, soundBuf, rateGliss, pos * bufDur, overlapGliss/trigRateGliss,
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
        bpFreq = Demand.ar(trigs[i], 0, dUgen).linlin(0, 1, bpLoGliss, bpHiGliss);

        // amplitude compensation for lower rq of bandpass filter
        BPF.ar(ch, bpFreq, bpRQGliss, (bpRQGliss ** -1) * (400 / bpFreq ** 0.5));
    };

    // routing to two channels ...
    sigL = Mix(((0..(~m-1)) * 2).collect(sig[_]));
    sigR = Mix(((0..(~m-1)) * 2 + 1).collect(sig[_]));

    // ... in order to have L/R-spreading with panMax as in other examples
	Out.ar(0, Pan2.ar(sigL, panMax.neg) + Pan2.ar(sigR, panMax) * env)
}, metadata: (
        specs: (
		soundBuf: b.bufnum,
		posLo: [0, 1, \lin, 0, 0.2],
		posHi: [0, 1, \lin, 0, 0.5],
		posRateE: [-3, 4, \lin, -1, -1],
		posRateM: [0.1, 10, \exp, 0.01, 0.8],
		overlap: [0.1, ~n, \lin, 0, 12],
		trigRate: [1, 100, \lin, 0, 45],
		rate: [0.1, 2, \lin, 0, 1],

		bpRQ: [0.05, 1, \lin, 0, 0.25],
		bpLo: [50.0, 5000, \exp, 0, 50],
		bpHi: [50.0, 5000, \exp, 0, 5000],
		panMax: [0, 1, \lin, 0, 0.85],
		amp: [0.0, 3, \lin, 0, 1]
        )
    )
).add;

b = Buffer.read(s, "/Users/pvh/src/Projects/timeline/test2.wav");
// This searches the most likely extension places for the miSCellaneous folder.
// In case of an extraordinary install situation or a removed sound file, pass the concerned path.
)

// start from GUI
// use color grouping for better overview

\gran_1e.sVarGui([\bufNum, b.bufnum]).gui

Pbind(\instrument, \gran_1e, \dur, 0.1, \attack, 0, \release, 0, \posLo, 0.6, \posHi, 0.70, \posRateE, 0, \posRateM, 3, \overlap, 4, \trigRate, 10, \rate, 1, \bpRQ, 0.25, \bpLo, 50, \bpHi, 2000, \panmax, 1, \amp, 0.5).play;

Pbind(\instrument, \gran_1e, \dur, 20, \attack, 1, \release, 0, \posLo, 0, \posHi, 0.70, \posRateE, 0, \posRateM, -5, \overlap, 4, \trigRate, 100, \rate, 1.5, \bpRQ, 0.25, \bpLo, 1000, \bpHi, 2000, \panmax, 1, \amp, 0.5).play;

///// test score
Routine({
	x = PatternProxy.new;
	y = PatternProxy.new;
	z = PatternProxy.new;

	1.postln;
	x = Pbind(\instrument, \gran_1e, \dur, 4, \attack, 0, \release, 5, \posLo, 0.6, \posHi, 0.70, \posRateE, 0, \posRateM, 3, \overlap, 4, \trigRate, Pseq([7,100,Rest(2)]), \rate, 1, \bpRQ, 0.25, \bpLo, 50, \bpHi, 2000, \panmax, 1, \amp, 0.5).play;

	1.wait;

	x.stream = Pbind(\instrument, \gran_1e, \dur, 1, \attack, 1, \release, 4, \posLo, 0, \posHi, 0.70, \posRateE, 0, \posRateM, -0.01, \overlap, 4, \trigRate, 100, \rate, 1, \bpRQ, 0.25, \bpLo, 1000, \bpHi, 15000, \panmax, 1, \amp, 0.5).asStream;

	8.wait;

	y = Pbind(\instrument, \gran_1e, \dur, 1, \attack, 1, \release, 4, \posLo, 0.5, \posHi, 0.70, \posRateE, 0, \posRateM, -0.01, \overlap, 4, \trigRate, 100, \rate, 0.5, \bpRQ, 0.25, \bpLo, 100, \bpHi, 1000, \panmax, 1, \amp, 0.2).play;

	3.wait;

	z = Pbind(\instrument, \gran_1e, \dur, 1, \attack, 1, \release, 4, \posLo, 0.5, \posHi, 0.70, \posRateE, 0, \posRateM, -0.01, \overlap, 4, \trigRate, 50, \rate, 2, \bpRQ, 0.25, \bpLo, 2000, \bpHi, 15000, \panmax, 1, \amp, 0.2).play;

	12.wait;
	x.stream = Pbind(\instrument, \gransyn1, \trigRate, Rest(1)).asStream;
	y.stream = Pbind(\instrument, \gransyn1, \trigRate, Rest(1)).asStream;

	z.stream = Pbind(\instrument, \gran_1e, \dur, 2, \attack, 2, \release, 2, \posLo, 0.1, \posHi, 0.40, \posRateE, 0, \posRateM, 4, \overlap, 9, \trigRate, Pseq([100,200,Rest(2)]), \rate, -1, \bpRQ, 0.25, \bpLo, 50, \bpHi, 2000, \panmax, 1, \amp, 0.5).asStream;

	1.wait;

	z.stream = Pbind(\instrument, \gransyn1, \trigRate, Rest(1)).asStream;

	x = Pbind(\instrument, \gran_1e, \dur, Pseq([8,10,12,9,4]), \attack, 0, \release, 1, \posLo, 0, \posHi, 0.70, \posRateE, 0, \posRateM, Pseq([-0.1,0.3,4,4,4]), \overlap, Pseq([0.1,0.3,3,1,1]), \trigRate, Pseq([300,500,9,5,2]), \rate, 1, \bpRQ, 0.25, \bpLo, 1000, \bpHi, 15000, \panmax, 1, \amp, Pseq([1,1,0.5,0.5,1])).play;

}).play


//add glide for overlap, rate, posRateM, bpLow, bpHi, bpRQ, *amp

(
var timeNow;
TempoClock.default.tempo = 2;    // 2 beats/sec, or 120 BPM
timeNow = TempoClock.default.beats;
"Time is now: ".post; timeNow.postln;
"Scheduling for: ".post; (timeNow + 5).postln;
TempoClock.default.schedAbs(timeNow + 5,
    { "Time is later: ".post; thisThread.clock.beats.postln; nil });
)



	var trigRateGliss = XLine.kr(trigRate, trigRateNext, trigRateLag);
	var overlapGliss = XLine.kr(overlap, overlapNext, overlapLag);
	var rateGliss = XLine.kr(rate, rateNext, rateLag);
	var posRateMGliss = XLine.kr(posRateM, posRateMNext, posRateMLag);
	var bpLoGliss = XLine.kr(bpLo, bpLoNext, bpLoLag);
	var bpHiGliss = XLine.kr(bpHi, bpHiNext, bpHiLag);
	var bpRQGliss = XLine.kr(bpRQ, bpRQNext, bpRQLag);


//maybe pseq, 1st param is rate, 2nd param is rateNext ???


x = Pbind(\instrument, \gran_1e, \dur, 10, \attack, 0, \release, 5, \posLo, 0.6, \posHi, 0.70, \posRateE, 0, \posRateM, 3, \posRateMNext, 3, \posRateMLag, 0, \overlap, 0.5, \overlapNext, 5, \overlapLag, 5, \trigRate, 9, \trigRateNext, 9, \trigRateLag, 3, \rate, 0.1, \rateNext, 2, \rateLag, 5, \bpRQ, 0.25, \bpRQNext, 0.25, \bpRQLag, 0, \bpLo, 50, \bpLoNext, 50, \bpLoLag, 0, \bpHi, 2000, \bpHiNext, 2000, \bpHiLag, 0, \panmax, 1, \amp, 0.5).play;