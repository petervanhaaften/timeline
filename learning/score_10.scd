s.options.sampleRate = 44100;
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

SynthDef(\gran_1e, { |out = 0, soundBuf, gate = 1, attack = 0.01, release = 0.5, posLo = 0.1, posHi = 0.9, posRateE = 0, posRateM= 1, posRateMLag = 0, posRateMCurve = 0, rate= 1, rateLag = 0, rateCurve = 0, panMax = 0.8, bpRQ = 0.1, bpRQLag = 0, bpRQCurve = 0, bpLo = 50, bpLoLag = 0, bpLoCurve = 0, bpHi = 5000, bpHiLag = 0, bpHiCurve = 0, amp = 1, overlap = 2, overlapLag = 0, overlapCurve = 0, trigRate = 1, trigRateLag = 0, trigRateCurve = 0, interp = 2|

    var sig, sigL, sigR, env, bpFreq, chan, bpFreqSeqs, dUgen,
        trig, trigs, bufDur, pos, posRate;

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
)


b = Buffer.read(s, "/Users/pvh/src/Projects/timeline/test2.wav");

(
p = Pmono(
	\gran_1e,
	\dur, 4,
	\attack, 0,
	\release, 5,
	\posLo, 0.1,
	\posHi, 0.70,
	\posRateE, 0,
	\posRateM, 2,
	\posRateMLag, 3,
	\posRateMCurve, 1,
	\overlap, Pseq([0.01, 0.5, 2, 0.5], 1),
	\overlapLag, 3,
	\overlapCurve, 5,
	\trigRate, Pseq([300, 9, 5, 50], 1),
	\trigRateLag, 1,
	\trigRateCurve, 1,
	\rate, Pseq([-1, 1, 2, 1], 1),
	\rateLag, 4,
	\rateCurve, -1,
	\bpRQ, 0.25,
	\bpRQLag, 0.25,
	\bpRQCurvw, 1,
	\bpLo, 50,
	\bpLoLag, 50,
	\bpLoCurve, 0,
	\bpHi, 2000,
	\bpHiLag, 2000,
	\bpHiCurve, 1,
	\panmax, 0,
	\amp, 0.5
).trace.play;
)

SynthDef(\sinbeep, {|freq = 440, out, gate = 1, attack = 0, release = 0, amp = 1|
	var env = Linen.kr(gate, attack, release) * amp;
	Out.ar(out, SinOsc.ar(freq, 0,0.2) * env)
}
).add;


x = Pbind(
	\instrument, \sinbeep,
	\dur, 1,
	\attack, 0,
	\release, 1,
	\freq, 440,
).play;

x.stream = Pbind(\instrument, \sinbeep, \trigRate, Rest(1)).asStream;



(
Routine({
	c = Buffer.read(s, "/Users/pvh/src/Projects/timeline/sayyourname.wav");
	(
		n = SynthDef("bufferplay",{ arg out = 0, bufnum;
			Out.ar( out,
				PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
			)
		}).play(s,[\bufnum, c.bufnum ]);
	);
	2.5.wait;
	2.postln;

	SynthDef(\sinbeep, {|freq = 440, out, gate = 1, attack = 0, release = 0, amp = 1|
		var env = Linen.kr(gate, attack, release) * amp;
		Out.ar(out, SinOsc.ar(freq, 0,0.2) * env)
	}
	).add;

	x = Pmono(
		\sinbeep,
		\dur, 1,
		\attack, 0,
		\release, 1,
		\freq, 440,
	).play;

}).play;
)

x.free;
	SynthDef(\sinbeep, {|freq = 440, out, gate = 1, attack = 0, release = 0, amp = 1|
		var env = Linen.kr(gate, attack, release) * amp;
		Out.ar(out, SinOsc.ar(freq, 0,0.2) * env)
	}
	).add;

	x = Pbind(
		\instrument, \sinbeep,
		\dur, 1,
		\attack, 0,
		\release, 1,
		\freq, 440,
	).play;

	x.play;
