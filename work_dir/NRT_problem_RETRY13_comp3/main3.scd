(
var options;
~scoreFile = thisProcess.nowExecutingPath.dirname +/+ "newscore/score1.scd";
~bufferFile = thisProcess.nowExecutingPath.dirname +/+ "VM56HKF.wav";
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
~pattern = Pdef(\scene1, Pdef(\main,
	Pseq([
		//start score
		Pfindur(33, Pdef(\part1)),
		Pfindur(29, Pdef(\part2)),
		//Pfindur(3, Pdef(\part3)),
	],1),
));
~pattern = ~pattern.asScore(65);

// ~score.add(~pattern);
~pattern.score.do{|e| ~score.add(e)};

// the ServerOptions for rendering the soundfile
//options = ServerOptions.new.numOutputBusChannels_(2);
options = Server.default.options;

~score.recordNRT(
    outputFilePath: thisProcess.nowExecutingPath.dirname +/+ "test10.wav".standardizePath,
    headerFormat: "wav",
    sampleFormat: "int24",
    options: options,
    duration: 65,
    action: { "done".postln }
);

//~sndbuf = b;
~sndbuf = Buffer.read(s, ~bufferFile);
Require(~scoreFile);

~pattern = Pdef(\scene1, Pdef(\main,
	Pseq([
		//start score
		Pfindur(33, Pdef(\part1)),
		Pfindur(29, Pdef(\part2)),
		//Pfindur(3, Pdef(\part3)),
	],1),
));
~pattern.play;
)
//~pattern.play
//~peterClock = TempoClock.new(1, 0)