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
	Pdef(\scene0, Pdef(\main,
	Pseq([
		//start score
		Pfindur(17, Pdef(\part1)),
		Pfindur(20, Pdef(\part2)),
		Pfindur(22, Pdef(\part3)),
		Pfunc({~net.sendMsg('/timeline/scene',9999, ~telephoneNum, ~asteriskChannel, ~wavPin)}).collect;
	],1),
)).play;

	// run non-realtime offline score bounce
	Require(~tlplayback);
	"SCORE FINISHED".postln;
}