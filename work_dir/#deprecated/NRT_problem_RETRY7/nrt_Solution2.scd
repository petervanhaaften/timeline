(
var options;
~sndbuf = Buffer.alloc(s, 100 * s.sampleRate);
~sndbuf = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff");
// call external score
Require("score.scd");

//call synthdef
Require("gransyn.scd");
~pattern.play;
)

(
var options;
// create new score
~score = Score.new;

// call external score
Require("score.scd");

// create a Buffer object for adding to the Score
~sndbuf = Buffer.new;

//call synthdef
Require("gransyn.scd");

//~pattern.play;
// for NRT rendering, the buffer messages must be added to the Score
~score.add([0, ~sndbuf.allocReadMsg(Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff")]);

~pattern = ~pattern.asScore(60);

// ~score.add(~pattern);
~pattern.score.do{|e| ~score.add(e)}; // I found myself using it this way

// the ServerOptions for rendering the soundfile
options = ServerOptions.new.numOutputBusChannels_(2);

(
// Destination path and file name
~outFile = "~/test.wav";
// Render the score as wav file
~score.recordNRT(outputFilePath: ~outFile.asAbsolutePath, headerFormat: "WAV", options: options);
);
)