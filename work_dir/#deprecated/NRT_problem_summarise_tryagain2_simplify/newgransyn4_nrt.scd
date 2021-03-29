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

~pattern = (
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

/////////////////
/////////////////
/////////////////


/* Figure 18.5 */
(
var score, sndbuf, options;

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
}).load(s);

SynthDef(\NRT_playback, {arg buffer, dur, startPos, amp;
	OffsetOut.ar(0, PlayBuf.ar(1, buffer, BufRateScale.kr(buffer),
			startPos: startPos * BufSampleRate.kr(buffer)) *
		EnvGen.ar(
			Env.sine(dur, amp),
			doneAction: 2))
	}).load(s);

score = Score.new;

// create a Buffer object for adding to the Score
sndbuf = Buffer.new;

// for NRT rendering, the buffer messages must be added to the Score
score.add([0, sndbuf.allocReadMsg(Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff")]);

~pattern = (
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
)).asScore;
);

//~pattern.asScore(duration: 20.0, timeOffset: 0.0);
score.add(~pattern.asScore);
// the dummy command. The soundfile will be 11 seconds long
s//core.add([11, 0]);

score.sort;

// the ServerOptions for rendering the soundfile
options = ServerOptions.new.numOutputBusChannels_(1);

// write the soundfile out to disk
score.recordNRT("/tmp/trashme", "~/test.aiff".standardizePath, options: options);
)
/* End Figure 18.5 */