//////////////////////////////////////////
// Example 1:
// a working example with default server
// playback. A sample buffer is loaded, a
// granular synthdef is loaded, and
// a pattern performs the synthdef.
//////////////////////////////////////////

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

//////////////////////////////////////////////////////////
// EXAMPLE 2
// a non-working example of converting this to NRT.
// Basically, it produces an empty audio file.
// I am guessing this is because my synthdef and/or
// audio buffer is not correctly called in the NRT server
/////////////////////////////////////////////////////////

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

score = Score.new;

// create a Buffer object for adding to the Score
sndbuf = Buffer.new;

// for NRT rendering, the buffer messages must be added to the Score
score.add([0, sndbuf.allocReadMsg(Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff")]);

~pattern = Pdef(\scene0, Pdef(\part1,
	Ppar([
			Pmono(
				\buf_grain_test,
				\sndbuf, b,
				\envbuf, Pseq([-1, 0, -0.5, 0.5], 1),
				\dur, Pseq([2, 2, 2, 2], 1),
				\pan, Pseq([-1, 1, -1, 1], 1),
			),
	])
));

~pattern = ~pattern.asScore(60);

score.add(~pattern);

// the ServerOptions for rendering the soundfile
options = ServerOptions.new.numOutputBusChannels_(2);

(
// Destination path and file name
~outFile = "~/test.wav";
// Render the score as wav file
~pattern.recordNRT(outputFilePath: ~outFile.asAbsolutePath, headerFormat: "WAV", options: options);
);
)
/* End Figure 18.5 */