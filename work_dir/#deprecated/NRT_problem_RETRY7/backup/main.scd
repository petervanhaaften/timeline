(
var options;
// create new score
~score = Score.new;

// create a Buffer object for adding to the Score
~sndbuf = Buffer.new;

// for NRT rendering, the buffer messages must be added to the Score
~score.add([0, ~sndbuf.allocReadMsg(Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff")]);

//call synthdef
Require("gransyn.scd");

// call external score
Require("score.scd");

~pattern = ~pattern.asScore(50);

// ~score.add(~pattern);
~pattern.score.do{|e| ~score.add(e)};

// the ServerOptions for rendering the soundfile
options = ServerOptions.new.numOutputBusChannels_(2);

(
// Destination path and file name
~outFile = "~/test.wav";
// Render the score as wav file
~score.recordNRT(outputFilePath: ~outFile.asAbsolutePath, headerFormat: "WAV", options: options);
);
)