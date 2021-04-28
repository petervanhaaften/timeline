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
	Pdef(\scene7, Pdef(\main,
	Pseq([
		//start score
		Pfindur(37, Pdef(\part1)),
		Pfindur(39, Pdef(\part1)),
	],1),
)).play;

	// run non-realtime offline score bounce
	Require(~tlplayback);
	"SCORE FINISHED".postln;
}