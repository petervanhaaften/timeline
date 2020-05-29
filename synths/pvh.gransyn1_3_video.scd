///////////////////////
//    GRANULAR INST1
///////////////////////

//need to rebuild for mono
//needs amplitude per grain.....
//needs env control per grain

(
// the multichannel size and equivalently:
// the maximum number of overlapping grains that might get
// different fx parameters have to be fixed.
// For convenience of later L/R-spatialization we take an
// even number ~n = 2 * ~m

~m = 5;
~n = 2 * ~m;

SynthDef(\gran_1e, { |out = 0, soundBuf, gate = 1, attack = 0.01, release = 0.5, posLo = 0.1, posHi = 0.9, posRateE = 0, posRateM= 1, posRateMLag = 0, posRateMCurve = 0, rate= 1, rateLag = 0, rateCurve = 0, panMax = 0.8, bpRQ = 0.1, bpRQLag = 0, bpRQCurve = 0, bpLo = 50, bpLoLag = 0, bpLoCurve = 0, bpHi = 5000, bpHiLag = 0, bpHiCurve = 0, amp = 1, overlap = 2, overlapLag = 0, overlapCurve = 0, trigRate = 1, trigRateLag = 0, trigRateCurve = 0, interp = 2|

    var sig, sigL, sigR, sigOut, env, bpFreq, chan, bpFreqSeqs, dUgen, trig, trigs, bufDur, pos, posRate;

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

	//sigOut = Mix(((0..(~m-1))).collect(sig[_]));
	sigOut = (sigL + sigR)/2;

    // ... in order to have L/R-spreading with panMax as in other examples
	Out.ar(0, Pan2.ar(sigL, panMax.neg) + Pan2.ar(sigR, panMax) * env)
	//Out.ar(out, sigOut * env).round(2**(-2))
}
).add;

b = Buffer.read(s, "/Users/pvh/src/timeline/goodpvoice1.wav");
)
