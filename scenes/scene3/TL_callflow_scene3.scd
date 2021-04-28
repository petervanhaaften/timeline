/*
Scene score playback
*/

// here you should set scene variable
//~currentScene = 0;
Require(~timescore);

///////////////////////
//    SCORE PLAYER
///////////////////////

~playscore = Routine {
	Pdef(\scene3, Pdef(\main,
	Pseq([
		//start score
		Pfindur(19, Pdef(\part1)),
		Pfindur(22, Pdef(\part2)),
		Pfindur(22, Pdef(\part3)),
		Pfindur(16, Pdef(\part3)),
	],1),
)).play;

	// run non-realtime offline score bounce
	Require(~tlplayback);
	"SCORE FINISHED".postln;
}