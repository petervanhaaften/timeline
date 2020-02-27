s.options.sampleRate = 44100;

// In example 1a only a deviation from the grain center position was implemented.
// With additional deviation controls a greater plasticity of sound can be achieved,
// here deviations are added for trigRate (LFO with oscillation freq and deviation max),
// grain duration and rate (TRand, equally weighted random deviation with given max).
// Deviations intervals could be defined alternatively,
// e.g. (1/(1+maxDev), 1+maxDev) with 0 < maxDev
// instead of (1-maxDev, 1+mexDev) with 0 < maxDev < 1

// posRate control range is widened by inventing two controls for
// mantissa and exponent, so posRate = 1 for init param pair
// posRateE = 0 and posRateM = 1

(
SynthDef(\gransyn1, { arg out = 0, bufNum = 0, posLo = 0.0, posHi = 1.0,
    posRateE = 0, posRateM = 1, posDev = 0.01, trigRate = 100, trigRateDev = 0,
    trigRateOsc = 1, granDur = 0.1, granDurDev = 0, rate = 1.0, rateDev = 0,
    panMax = 1, amp = 0.1, interp = 4;

    var trig, pan, pos, bufDur, bufDurSection, posDif, posRate;

    posDif = posHi - posLo;
    bufDur = BufDur.kr(bufNum);
    bufDurSection = bufDur * posDif;
    trig = Impulse.kr(LFDNoise3.kr(trigRateOsc, trigRate * trigRateDev, trigRate));
    posRate = 10 ** posRateE * posRateM;
    pos = posLo * bufDur +
        (Phasor.ar(0, BufRateScale.kr(bufNum) * posRate / SampleRate.ir, posLo * bufDur, posHi * bufDur) +
        (TRand.kr(-0.5, 0.5, trig) * posDev * bufDur)).mod(bufDurSection);
    pan = Demand.kr(trig, 0, Dseq([panMax, panMax.neg],inf) * 0.999);
    Out.ar(out, TGrains.ar(2, trig, bufNum, rate * (TRand.kr(-1, 1.0, trig) * rateDev + 1), pos,
        granDur * (TRand.kr(-1, 1.0, trig) * granDurDev + 1), pan, 1, interp) * amp);
    }, metadata: (
        specs: (
            posLo: [0.01, 0.99, \lin, 0.01, 0],
            posHi: [0.01, 0.99, \lin, 0.01, 1],
            posRateE: [-3, 4, \lin, 1, 0],
            posRateM: [0.1, 10, \exp, 0.01, 1],
            posDev: [0, 0.2, 5, 0, 0.05],
            trigRate: [0, 200, \lin, 0.01, 100],
            trigRateDev: [0.0, 1, \lin, 0.01, 0],
            trigRateOsc: [0, 2, \lin, 0.01, 3],
            granDur: [0.01, 2, \lin, 0.01, 0.1],
            granDurDev: [0.0, 0.95, \lin, 0.01, 0],

            rate: [0.1, 2, \lin, 0.01, 1],
            rateDev: [0.0, 0.99, \linear, 0.01, 0.05],
            panMax: [0.0, 1, \lin, 0.005, 0.8],
            amp: [0.0, 0.5, \lin, 0.005, 0.25]
        )
    )
).add;

b = Buffer.read(s, "/Users/pvh/src/Projects/timeline/test2.wav");
// This searches the most likely extension places for the miSCellaneous folder.
// In case of an extraordinary install situation or a removed sound file, pass the concerned path.
)


// start from GUI
// use color grouping for better overview

\gransyn1.sVarGui([\bufNum, b.bufnum]).gui(synthColorGroups: (0..14).clumps([1,5,3,2,2,1,1]) )

//event msgs

x = PatternProxy.new;

x.play;

x.source = Pbind(
	\instrument, \gransyn1,
	\posLo, 0.01,
	\posHi, 0.10,
	\posRateE, 0,
	\posRateM, 1,
	\posDev, 0.05,
	\trigRate, 5,
	\trigRateDev, 0,
	\trigRateOsc, 2,
	\granDur, 0.01,
	\granDurDev, 0,
	\rate, 1,
	\rateDev, 0.05,
	\panmax, 0.8,
	\amp, 0.25,
);

x.source = Pbind(
	\instrument, \gransyn1,
	\posLo, Pseq([0.1, 0.8, 0.3, 0.4, 0.9], 2),
	\posHi, 0.50,
	\posRateE, 0,
	\posRateM, 1,
	\posDev, 0.05,
	\trigRate, 0; ,
	\trigRateDev, 0,
	\trigRateOsc, 0,
	\granDur, 0.05,
	\granDurDev, 0,
	\rate, 1,
	\rateDev, 0.05,
	\panmax, 0.8,
	\amp, 0.25,
);

x.source = Pbind(
	\instrument, \gransyn1,
	\posLo, Pseq([0.1, 0.8, 0.3, 0.4, 0.9], 1),
	\posHi, 0.50,
	\posRateE, 0,
	\posRateM, 1,
	\posDev, 0.05,
	\trigRate, 3,
	\trigRateDev, 0,
	\trigRateOsc, 1,
	\granDur, Pseq([0.01, 0.02, 0.03, 0.14, 0.1], 1),
	\granDurDev, 0,
	\rate, 1,
	\rateDev, 0.05,
	\panmax, 0.8,
	\amp, 0.25,
).play;



x.stop;