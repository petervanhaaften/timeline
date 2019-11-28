
(
SynthDef(\test, { |out, freqStart = 0, freqEnd = 0|
    Out.ar(out,
		SinOsc.ar(XLine.kr(freqStart,freqEnd,3), 0, 0.2) *
		Line.kr(1, 0, 1, doneAction: Done.freeSelf)
    )
}).add;
)


(
~lastFreq = 100;

Pbind(
	\instrument, \test,
	\dur, 1,
	\freqRamp, Pseq([100, 700, 200, 400]),
	\freqStart, Pfunc { ~lastFreq },
	\freqEnd, Pfunc { |ev|
		~lastFreq = ev[\freqRamp];
	}
).trace.play;
)





/// next

E.g. with Lag or VarLag

(
SynthDef(\test_1, { |out, freq = 200, rampDur = 1|
	Out.ar(out, SinOsc.ar(freq.lag(rampDur)), 0, 0.2)
}).add;
)

(
SynthDef(\test_2, { |out, freq = 200, rampDur = -4, curve = 2|
	Out.ar(out, SinOsc.ar(VarLag.kr(freq, rampDur, curve)), 0, 0.2)
}).add;
)

(
p = Pmono(\test_1,
	\freq, Pseq([500, 300, 700, 200], inf),
	\dur, 1,
	\rampDur, 1
).trace.play
)

(
p = Pmono(\test_2,
	\freq, Pseq([500, 300, 700, 200], inf),
	\dur, 2,
	\rampDur, 0.1
).trace.play
)