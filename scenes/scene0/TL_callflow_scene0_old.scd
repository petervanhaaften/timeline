/*
Scene score playback
*/

// here you should set scene variable
~currentScene = 9;

~playscore = Routine {
	//		Require(~tlcallflowglobal);
	Require(~tlplayback);
	Require(~timescore);
	//play master score
	p = Pdef(\scene0, Pdef(\main,
		Pseq([
			//start score
			//Pfindur(30, Pdef(\part1)),
			//Pfindur(24, Pdef(\part2)),

			Pfindur(17, Pdef(\part1)),
			Pfindur(20, Pdef(\part2)),
			Pfindur(22, Pdef(\part3)),

			//PLAY GOODBYE
			//Pfindur(2,Pmono(\bufferplay, \bufnum, g.bufnum, \dur, 1)),
			//Pfunc({~net.sendMsg("/timeline/scene", 9999)}).collect;
			Pfunc({~net.sendMsg('/timeline/scene',9999, ~telephoneNum, ~asteriskChannel, ~wavPin)}).collect;
		],1),
	)).play;
	"SCORE FINISHED".postln;
};
