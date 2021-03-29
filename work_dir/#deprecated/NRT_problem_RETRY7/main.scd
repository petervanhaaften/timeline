//EXAMPLE #1
//a working score playback
(
s.boot;
//currently my synthdef 'gransyn' in gransyn.scd receives a buffer name in 'soundBuf' variable
//which is received from the score in score.scd ("\soundBuf, b.bufnum,").
//in my next example, i need to understand how to move this buffer to the NRT server
b = Buffer.alloc(s, 100 * s.sampleRate);
b = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "voice.wav");
Require("gransyn.scd");
Require("score.scd");
~score.play;
)

//EXAMPLE #2
//not working: how to record score in non-realtime, and also print valid score file that can be used repeatedly with new audio buffers?
(
//i need to understand how to call my gransyn synthdef on the NRT server
Require("gransyn.scd");
Require("score.scd");
z = ~score.asScore(17.0);

// trying to load my buffer onto the NRT server
//i need to understand out how to call this buffer from my 'gransyn' synthdef in gransyn.scd
z = z.add([0.0, [\b_allocRead, 1, thisProcess.nowExecutingPath.dirname +/+ "voice.wav"]]);
z.score.postcs;

//trying to render the audio
z.recordNRT(
    outputFilePath: thisProcess.nowExecutingPath.dirname +/+ "score-recordnrt-test1.wav".standardizePath,
    headerFormat: "wav",
    sampleFormat: "int16",
    options: s.options,
    duration: 15,
    action: { "done".postln }
);

//trying to print out a valid score file
f = File(thisProcess.nowExecutingPath.dirname +/+ "score-print-test1","w");
f.write(z.asCompileString);
f.close;
)