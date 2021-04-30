(
var options;
~scoreFile = thisProcess.nowExecutingPath.dirname +/+ "newscore/score8.scd";
~bufferFile = thisProcess.nowExecutingPath.dirname +/+ "5H84XBV.wav";
// create new score
~score = Score.new;

// create a Buffer object for adding to the Score
~sndbuf = Buffer.new;

// for NRT rendering, the buffer messages must be added to the Score
~score.add([0, ~sndbuf.allocReadMsg(~bufferFile)]);

//call synthdef
Require("gransyn.scd");

// call external score
Require(~scoreFile);
//~pattern2 = ~pattern;
~pattern = ~pattern.asScore(60);

// ~score.add(~pattern);
~pattern.score.do{|e| ~score.add(e)};

// the ServerOptions for rendering the soundfile
options = ServerOptions.new.numOutputBusChannels_(2);

~score.recordNRT(
    outputFilePath: thisProcess.nowExecutingPath.dirname +/+ "test9.wav".standardizePath,
    headerFormat: "wav",
    sampleFormat: "int24",
    options: options,
    duration: 60,
    action: { "done".postln }
);

//~sndbuf = b;
~sndbuf = Buffer.read(s, ~bufferFile);
Require(~scoreFile);
~pattern.play;
)
//~pattern.play