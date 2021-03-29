s.boot;
b.play
(
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff");

SynthDef(\buf_grain_test, { |out, gate = 1, amp = 1, pan = 0, sndbuf, envbuf|
    var  env, freqdev;
    env = EnvGen.kr(
        Env([0, 1, 0], [1, 1], \sin, 1),
        gate,
        levelScale: amp,
        doneAction: Done.freeSelf);
    Out.ar(out,
        GrainBuf.ar(2, Impulse.kr(20), 0.1, sndbuf, LFNoise1.kr.range(0.5, 2),
            LFNoise2.kr(0.1).range(0, 1), 2, pan, envbuf) * env)
}).add;
)


(
var pattern = (
	Pdef(\scene0, Pdef(\part1,
	Ppar([
			Pmono(
				\buf_grain_test,
				\sndbuf, b,
				\envbuf, Pseq([-1, 0, -0.5, 0.5], 1),
				\dur, Pseq([2, 2, 2, 2], 1),
				\pan, Pseq([-1, 1, -1, 1], 1),
			),
	])
)).play;
);
)

// use built-in env
x = Synth(\buf_grain_test, [\sndbuf, b, \envbuf, -1])
