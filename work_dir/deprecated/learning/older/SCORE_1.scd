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


//add better envelope to gate
//add filter after gate
//control filter with envelope
(
SynthDef(\gransyn1, { arg out = 0, gate = 1, attack = 0.01, release = 0.5, bufNum = 0, posLo = 0.0, posHi = 1.0,
    posRateE = 0, posRateM = 1, posDev = 0.01, trigRate = 100, trigRateDev = 0,
    trigRateOsc = 1, granDur = 0.1, granDurDev = 0, rate = 1.0, rateDev = 0,
    panMax = 1, amp = 0.1, interp = 4;

    var trig, env, pan, pos, bufDur, bufDurSection, posDif, posRate;
	//envelope addition to gate sound per pattern
	env = Linen.kr(gate, attack, 1, release, 2) * amp;
    posDif = posHi - posLo;
    bufDur = BufDur.kr(bufNum);
    bufDurSection = bufDur * posDif;
    trig = Impulse.kr(LFDNoise3.kr(trigRateOsc, trigRate * trigRateDev, trigRate));
	//trig = Blip.kr(trigRate, 1.0, 1.0);
    posRate = 10 ** posRateE * posRateM;
    pos = posLo * bufDur +
        (Phasor.ar(0, BufRateScale.kr(bufNum) * posRate / SampleRate.ir, posLo * bufDur, posHi * bufDur) +
        (TRand.kr(-0.5, 0.5, trig) * posDev * bufDur)).mod(bufDurSection);
    pan = Demand.kr(trig, 0, Dseq([panMax, panMax.neg],inf) * 0.999);
    Out.ar(out, TGrains.ar(2, trig, bufNum, rate * (TRand.kr(-1, 1.0, trig) * rateDev + 1), pos,
		granDur * (TRand.kr(-1, 1.0, trig) * granDurDev + 1), pan, 1, interp) * (env * amp));
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
)


// start from GUI
// use color grouping for better overview

\gransyn1.sVarGui([\bufNum, b.bufnum]).gui(synthColorGroups: (0..14).clumps([1,5,3,2,2,1,1]) )

///// test score
Routine({
	x = PatternProxy.new;
	y = PatternProxy.new;
	z = PatternProxy.new;

	1.postln;
	y = Pbind(\instrument, \gransyn1, \attack, 0, \release, 0, \posLo, 0, \posHi, 0.50, \posRateE, 0, \posRateM, 0.1, \posDev, 0, \trigRate, 9, \trigRateDev, 0, \trigRateOsc, 0, \granDur, 0.05, \granDurDev, 0, \rate, -1, \rateDev, 0.1, \panmax, 0, \amp, 0.5).play;

	5.wait;
	2.postln;
	y.stream = Pbind(\instrument, \gransyn1, \attack, 5, \release, 0, \posLo, 0, \posHi, 0.70, \posRateE, 0, \posRateM, 0.1, \posDev, 0, \trigRate, Pseq([2, 5, 1, 0.5]), \trigRateDev, 0, \trigRateOsc, 1, \granDur, 0.2, \granDurDev, 0, \rate, Pseq([1, -2, 1.5, 0.5]), \rateDev, 0.1, \panmax, 1, \amp, 0.5).asStream;

	7.wait;
	3.postln;
	y.stream = Pbind(\instrument, \gransyn1, \trigRate, Rest(1)).asStream;

	3.wait;
	y = Pbind(\instrument, \gransyn1, \attack, 0, \release, 0, \posLo, 0, \posHi, 0.50, \posRateE, 0, \posRateM, 0.1, \posDev, 0, \trigRate, 2, \trigRateDev, 0, \trigRateOsc, 0, \granDur, 0.2, \granDurDev, 0, \rate, 1, \rateDev, 2, \panmax, 1, \amp, 1).play;

	2.wait;
	x = Pbind(\instrument, \gransyn1, \attack, 0, \release, 0, \posLo, 0, \posHi, 0.5, \posRateE, 0, \posRateM, 0.5, \posDev, 0, \trigRate, 100, \trigRateDev, 0, \trigRateOsc, 1, \granDur, 0.001, \granDurDev, 1, \rate, -2, \rateDev, 0, \panmax, 0, \amp, 1).play;



	1.wait;
	x.stream = Pbind(\instrument, \gransyn1, \trigRate, Rest(1)).asStream;
	y.stream = Pbind(\instrument, \gransyn1, \trigRate, Rest(1)).asStream;

}).play

SystemClock.beats;


(\instrument: \gransyn1, dur: 5, attack: 0, release: 5, posLo: 0, posHi: 0.5, posRateE: 0.1, posRateM: 0.1, posDev: 0, trigRate: 25, trigRateDev: 0, trigRateOsc: 0, granDur: 0.1, granDurDev: 0, rate: 1, rateDev: 1, panmax: 0, amp: 1).play;

(\instrument: \gransyn1, posLo: 0.4).play;

(\instrument: \gransyn1, trigRate: 1).astream;

Pbind(\instrument, \gransyn1, \trigRate, 1).asStream;


Pbind(\instrument, \gransyn1, \attack, 0, \release, 0, \posLo, 0, \posHi, 0.50, \posRateE, 0, \posRateM, 0.1, \posDev, 0, \trigRate, 2, \trigRateDev, 0, \trigRateOsc, 0, \granDur, 0.2, \granDurDev, 0, \rate, 1, \rateDev, 2, \panmax, 1, \amp, 1).play;

PSinOsc


y = Pbind(\instrument, \gransyn1, \dur, 1, \attack, 0, \release, 0, \posLo, 0, \posHi, 0.50, \posRateE, 0, \posRateM, 0.1, \posDev, 0, \trigRate, 90, \trigRateDev, 0, \trigRateOsc, 0, \granDur, 0.001, \granDurDev, 0, \rate, -1, \rateDev, 2, \panmax, 0, \amp, 1).play;

y.set(\trigRate, 1);

	y.stream = Pbind(\instrument, \gransyn1, \dur, 1, \attack, 0, \release, 0, \posLo, 0, \posHi, 0.70, \posRateE, 0, \posRateM, 0.1, \posDev, 0, \trigRate, Pseq([2, 5, 1, 0.5]), \trigRateDev, 0, \trigRateOsc, 1, \granDur, 0.2, \granDurDev, 0, \rate, Pseq([1, -2, 1.5, 0.5]), \rateDev, 0.1, \panmax, 1, \amp, 0.5).asStream;

y.stream = Pbind(\instrument, \gransyn1, \trigRate, 100).asStream;


y.next(Event.new);

TempoClock.default.tempo = 10



x = Pset(\instrument, \gransyn1, \attack, 0, \release, 0, \posLo, 0, \posHi, 0.5, \posRateE, 0, \posRateM, 0.5, \posDev, 0, \trigRate, 100, \trigRateDev, 0, \trigRateOsc, 1, \granDur, 0.001, \granDurDev, 1, \rate, -2, \rateDev, 0, \panmax, 0, \amp, 1);

z = x.asStream;
z.play;
	