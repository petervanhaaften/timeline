(
var options;
// create new score


~score = Score.new;

// create a Buffer object for adding to the Score
~sndbuf = Buffer.new;

// for NRT rendering, the buffer messages must be added to the Score
~score.add([0, ~sndbuf.allocReadMsg(thisProcess.nowExecutingPath.dirname +/+ "voice.wav")]);

//call synthdef
Require("gransyn.scd");

// call external score
Require("score.scd");

~pattern = Pdef(\scene0, Pdef(\main,
	Pseq([
		//start score
		Pfindur(17, Pdef(\part1)),
		Pfindur(20, Pdef(\part2)),
		Pfindur(22, Pdef(\part3)),
	],1),
));

~pattern = ~pattern.asScore(59);

// ~score.add(~pattern);
~pattern.score.do{|e| ~score.add(e)};

// the ServerOptions for rendering the soundfile
options = ServerOptions.new.numOutputBusChannels_(2);

~score.recordNRT(
    outputFilePath: "~/test.wav".standardizePath,
    headerFormat: "wav",
    sampleFormat: "int24",
    options: options,
    duration: 59,
    action: { "done".postln }
);

)