(
var sndbuf, options;

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

~score = Score.new;

// create a Buffer object for adding to the Score
sndbuf = Buffer.new;

// for NRT rendering, the buffer messages must be added to the Score
~score.add([0, sndbuf.allocReadMsg(Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff")]);

~pattern = Pdef(\scene0, Pdef(\part1,
	Ppar([
			Pmono(
				\buf_grain_test,
				\sndbuf, sndbuf,
				\envbuf, Pseq([-1, 0, -0.5, 0.5], 1),
				\dur, Pseq([2, 2, 2, 2], 1),
				\pan, Pseq([-1, 1, -1, 1], 1),
			),
	])
));

~pattern = ~pattern.asScore(60);
// ~score.add(~pattern);
~pattern.score.do{|e| ~score.add(e)};

//print out score
~score.score.do{|e| e.postln}; // Posts each OSC-msg as a line. Use this to see the difference.


// the ServerOptions for rendering the soundfile
options = ServerOptions.new.numOutputBusChannels_(2);

(
// Destination path and file name
~outFile = "~/test.wav";
// Render the score as wav file
~score.recordNRT(outputFilePath: ~outFile.asAbsolutePath, headerFormat: "WAV", options: options);
);
)