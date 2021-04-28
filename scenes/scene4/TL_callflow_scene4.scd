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
	Pdef(\scene4, Pdef(\main,
	Pseq([
		//start score
		Pfindur(19, Pdef(\part1)),
	],1),
)).play;

	// run non-realtime offline score bounce
	Require(~tlplayback);
	"SCORE FINISHED".postln;
}