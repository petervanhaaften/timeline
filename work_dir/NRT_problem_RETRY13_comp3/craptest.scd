(
~scoreFile = thisProcess.nowExecutingPath.dirname +/+ "newscore/score1.scd";
~bufferFile = thisProcess.nowExecutingPath.dirname +/+ "VM56HKF.wav";
//call synthdef
Require("gransyn.scd");
Require(~scoreFile);

~pattern = Pdef(\scene1, Pdef(\main,
	Pseq([
		//start score
		Pfindur(33, Pdef(\part1)),
		Pfindur(29, Pdef(\part2)),
		//Pfindur(3, Pdef(\part3)),
	],1),
));

//Require(~scoreFile);


~pattern.play;
)