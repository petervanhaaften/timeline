(
var options;

// create new score
~score = Score.new;

// create a Buffer object for adding to the Score
~sndbuf = Buffer.new;

// for NRT rendering, the buffer messages must be added to the Score
~score.add([0, ~sndbuf.allocReadMsg(thisProcess.nowExecutingPath.dirname +/+ "voice4.wav")]);

//call synthdef
Require("gransyn.scd");

// call external score
Require(thisProcess.nowExecutingPath.dirname +/+ "newscore/score9.scd");
~pattern2 = ~pattern;
~pattern = ~pattern.asScore(33);

// ~score.add(~pattern);
~pattern.score.do{|e| ~score.add(e)};

// the ServerOptions for rendering the soundfile
options = ServerOptions.new.numOutputBusChannels_(2);

~score.recordNRT(
    outputFilePath: thisProcess.nowExecutingPath.dirname +/+ "test6.wav".standardizePath,
    headerFormat: "wav",
    sampleFormat: "int24",
    options: options,
    duration: 33,
    action: { "done".postln }
);

//~sndbuf = b;
~sndbuf = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "voice4.wav");
Require(thisProcess.nowExecutingPath.dirname +/+ "newscore/score9.scd");
~pattern.play;
)