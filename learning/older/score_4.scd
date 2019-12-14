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

SynthDef(\gran_1e, { |out = 0, soundBuf, posLo = 0.1, posHi = 0.9,
    posRateE = 0, posRateM = 1, rate = 1, panMax = 0.8, bpRQ = 0.1, bpLo = 50, bpHi = 5000,
    amp = 1, bpFund = 100, overlap = 2, trigRate = 1, interp = 2|
    var sig, sigL, sigR, bpFreq, chan, bpFreqSeqs, dUgen,
        trig, trigs, bufDur, pos, posRate;

    trig = Impulse.ar(trigRate);
    // we need a multichannel trigger that steps through all consecutive channels
    trigs = { |i| PulseDivider.ar(trig, ~n, ~n-1-i) } ! ~n;

    chan = Demand.ar(trig, 0, Dseq((0..~n-1), inf));

    posRate = 10 ** posRateE * posRateM;
    bufDur = BufDur.kr(soundBuf);
    pos = Phasor.ar(0, BufRateScale.kr(soundBuf) * posRate * SampleDur.ir / bufDur, posLo, posHi);

    sig = TGrains.ar(~n, trig, soundBuf, rate, pos * bufDur, overlap/trigRate,
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
        bpFreq = Demand.ar(trigs[i], 0, dUgen).linlin(0, 1, bpLo, bpHi);

        // amplitude compensation for lower rq of bandpass filter
        BPF.ar(ch, bpFreq, bpRQ, (bpRQ ** -1) * (400 / bpFreq ** 0.5));
    };

    // routing to two channels ...
    sigL = Mix(((0..(~m-1)) * 2).collect(sig[_]));
    sigR = Mix(((0..(~m-1)) * 2 + 1).collect(sig[_]));

    // ... in order to have L/R-spreading with panMax as in other examples
    Out.ar(0, Pan2.ar(sigL, panMax.neg) + Pan2.ar(sigR, panMax) * amp)
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

//gui
(
VarGui(synthCtr: [
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
],
    synth: \gran_1e
).gui(
    tryColumnNum: 1,
    synthColorGroups: (0..12).clumps([1,4,2,1,3,1,1])
);
)







Pbind(\instrument, \gran_1e, \dur, 20, \attack, 0, \release, 0, \posLo, 0, \posHi, 0.70, \posRateE, 0, \posRateM, 0.1, \overlap, 20, \trigRate, 5, \rate, 1, \bpRQ, 0.25, \bpLo, 50, \bpHi, 10000, \panmax, 1, \amp, 0.5).play;
