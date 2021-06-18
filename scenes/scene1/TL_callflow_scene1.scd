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

	// run non-realtime offline score bounce
	Require(~tlplayback);
	//~myscore.play;
	"SCORE FINISHED".postln;
};
~playscore.reset;