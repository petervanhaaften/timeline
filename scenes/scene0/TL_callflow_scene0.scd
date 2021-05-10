/*
Scene score playback
*/

// here you should set scene variable
//~currentScene = 0;
~newshit = Routine {
	Require(~timescore);


	//~playscore.play;

	// run non-realtime offline score bounce
	//Require(~tlplayback);
	"SCORE FINISHED".postln;
};

~newshit.play;