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
	Pdef(\scene5, Pdef(\main,
	Pseq([
		//start score
		Pfindur(25, Pdef(\part1)),
		Pfindur(35, Pdef(\part2)),
	],1),
)).play;

	// run non-realtime offline score bounce
	Require(~tlplayback);
	"SCORE FINISHED".postln;
}