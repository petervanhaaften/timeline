(
SynthDef(\test, { |out, freq = 200|
    Out.ar(out,
        SinOsc.ar(freq, 0, 0.2) *
		Line.kr(1, 0, 1, doneAction: Done.freeSelf)
    )
}).add;
)


Pbind(\instrument, \test, \dur, 1, \freq, Pseq([100, 200, 500, 900])).play;




(
SynthDef(\test, { |out, freqStart = 20, freqEnd = 20|
    Out.ar(out,
		SinOsc.ar(XLine.kr(freqStart,freqEnd,1), 0, 0.2) *
		Line.kr(1, 0, 1, doneAction: Done.freeSelf)
    )
}).add;
)


Pbind(\instrument, \test, \dur, 1, \freqStart, Pseq([100, 200, 500]), \freqEnd, 5000).play;