(
~m = 5;
~n = 2 * ~m;

SynthDef(\gransyn, { |out = 0, soundBuf, gate = 1, attack = 0.01, release = 0.5, posLo = 0.1, posHi = 0.9, posRateE = 0, posRateM= 1, posRateMLag = 0, posRateMCurve = 0, rate= 1, rateLag = 0, rateCurve = 0, panMax = 0, bpRQ = 0.1, bpRQLag = 0, bpRQCurve = 0, bpLo = 50, bpLoLag = 0, bpLoCurve = 0, bpHi = 5000, bpHiLag = 0, bpHiCurve = 0, amp = 1, ampLag = 0, ampCurve = 0 overlap = 2, overlapLag = 0, overlapCurve = 0, trigRate = 1, trigRateLag = 0, trigRateCurve = 0, interp = 2, posRate = 0, lpFreq = 20000, lpLag = 3, lpCurve = 0, hpFreq = 20, hpLag = 0, hpCurve = 0, rateRandomness = 0, rateRandomnessLag = 0, rateRandomnessCurve = 0, overlapRandomness = 0, overlapRandomnessLag = 0, overlapRandomnessCurve = 0, verbMix = 0, verbMixLag = 0, verbMixCurve = 0, verbRoom = 0, verbDamp =0|

	var sig, sigL, sigR, sigOut, sigLimiter, sigCompressor, env, bpFreq, chan, dUgen, trig, trigs, bufDur, pos, lpfSig, rateNoiseSig, overlapNoiseSig, verbSig;

	//trigger for grains
	trig = Impulse.ar(trigRate);

	//randomness for rate
	rateNoiseSig = PinkNoise.kr(mul: VarLag.kr(rateRandomness, rateRandomnessLag, rateRandomnessCurve), add: 0);
	//rateNoiseSig = rateNoiseSig / 2
	//randomness for overlap
	overlapNoiseSig = PinkNoise.kr(mul: VarLag.kr(overlapRandomness, overlapRandomnessLag, overlapRandomnessCurve), add: 0);

	//define all of your VarLag controlled values here
	trigRate = Demand.ar(trig, 0, VarLag.ar(Demand.ar(trig, 0, trigRate, inf), trigRateLag, trigRateCurve), inf);
	lpFreq = VarLag.kr(lpFreq, lpLag, lpCurve);
	hpFreq = VarLag.kr(hpFreq, hpLag, hpCurve);
	rate = VarLag.ar(Demand.ar(trig, 0, rate + rateNoiseSig, inf), rateLag, rateCurve);
	overlap = VarLag.ar(Demand.ar(trig, 0, overlap + overlapNoiseSig, inf), overlapLag, overlapCurve);
	//trigRate = VarLag.kr(trigRate, trigRateLag, trigRateCurve);
	posRateM = VarLag.kr(posRateM, posRateMLag, posRateMCurve);
	amp = VarLag.kr(amp, ampLag, ampCurve);
	verbMix = VarLag.ar(Demand.ar(trig, 0, verbMix, inf), verbMixLag, verbMixCurve);


    // we need a multichannel trigger that steps through all consecutive channels
    trigs = { |i| PulseDivider.ar(trig, ~n, ~n-1-i) } ! ~n;

    chan = Demand.ar(trig, 0, Dseq((0..~n-1), inf));

	env = Linen.kr(gate, attack, 1, release, 2) * amp;

    posRate = 10 ** posRateE * posRateM;
    bufDur = BufDur.kr(soundBuf);
    pos = Phasor.ar(0, BufRateScale.kr(soundBuf) * posRate * SampleDur.ir / bufDur, posLo, posHi);


	sig = TGrains.ar(~n, trig, soundBuf, Demand.ar(trig, 0, rate, inf), pos * bufDur, Demand.ar(trig, 0, overlap, inf) / Demand.ar(trig, 0, trigRate, inf),
    // Panning convention is that from PanAz,
    // speakers should be from 0 to 2, but (orientation)
    // 1/n has to be substracted for n speakers.
    // If this isn't done correctly grains are spread onto more than one channel
    // and per-grain application of fxs fails.
	chan.linlin(0, ~n-1, -1/~n, (2*~n - 3)/~n), 1, interp);

    dUgen = Dwhite(0.0, 1);

	sig = sig.collect { |ch, i|
		// this is the place to define fxs per channel/grain
		lpfSig = LPF.ar(in: ch, freq: lpFreq, mul: 1, add: 0);

		HPF.ar(in: lpfSig, freq: hpFreq, mul: 1, add: 0);
	};

    // routing to two channels ...
    sigL = Mix(((0..(~m-1)) * 2).collect(sig[_]));
    sigR = Mix(((0..(~m-1)) * 2 + 1).collect(sig[_]));

	//route stereo sig thru cheap verb
	verbSig = FreeVerb2.ar(sigL, sigR, mix: Demand.ar(trig, 0, verbMix, inf), room: verbRoom, damp: verbDamp);

	//output
	Out.ar(out, Pan2.ar(verbSig[0], panMax.neg) + Pan2.ar(verbSig[1], panMax) * env);

}).store;
)