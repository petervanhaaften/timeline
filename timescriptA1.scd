//
//first working voice2music composition for 'the timeline' project
//peter van haaften, january 2020
//

(
s.options.sampleRate = 48000;
s.boot;

//CONFIGURATION
// # flag for timeline src directory
~srcdir = Platform.userHomeDir +/+ "src/Projects/timeline/";
// # flag for timeline operator speech audio directory
~operatorwav = ~srcdir +/+ "audio/stateyourname.wav";
// # flag for simplelogic location
~simplelogic = ~srcdir +/+ "simplelogic.scd";
// # flag for simplerec location
~simplerec = ~srcdir +/+ "simplerec.scd";
// # flag for gransyn1 location
~gransyn1 = ~srcdir +/+ "pvh.gransyn1.scd";
// # flag for timescore location
~timescore = ~srcdir +/+ "timescoreA1.scd";
// # flag for min recording length
~minrecordtime = 0; //not functioning
// # flag for max recording length
~maxrecordtime = 4;
// # flags for recording input lvl
// # flags for attack/decay of amp when recording

(
///////////////////////
// VOICE INTRO SYNTHDEF
///////////////////////

(
SynthDef("bufferplay",{ arg out = 0, bufnum;
			Out.ar( out,
				PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
			)
}
).add;
e = Buffer.read(s, ~operatorwav);
);



///////////////////////
//    SINE TONE BEEP
///////////////////////
(
SynthDef(\sinbeep, {|freq = 440, out, gate = 1, attack = 0, sustain = 1, release = 1, amp = 1|
	var env = Linen.kr(gate, attack, sustain, release) * amp;
	Out.ar(out, SinOsc.ar(freq, 0,0.2) * env)
    }
).add;
);
);

///////////////////////
// MASTER SCORE PLAYER
///////////////////////
(
r = Routine {
	//the synthesizer for this score
	Require(~gransyn1);
	//voice rec synthdef
	Require(~simplerec);
	//voice rec logic, interacts with synthdef
	Require(~simplelogic);
	"operator speaks".postln;
	a = Pmono(\bufferplay, \bufnum, e.bufnum, \dur, 1).play;
	//wait until audio file is finished (saymyname, 2.2sec)
	//should programatically determine the audio file length
	4.968.wait;
	//beep!
	f = Pmono(\sinbeep, \dur, 1, \amp, 2, \attack, 0, \sustain, 1, \release, 0, \freq, 440).play;
	//wait until beep is finished
	2.wait;
	f.stop;
	0.3.wait;
	~recordvoice.play;
	//OSCdef
	(
	OSCdef(\receivewhatever, {|msg, time, addr, recvPort|
	(msg[1] == \recdone).if({
		Routine {
		"beep2".postln;
		f = Pmono(\sinbeep, \dur, 1, \amp, 2, \attack, 0, \sustain, 1, \release, 0, \freq, 440).play;
		//wait until beep is finished
		2.wait;
		f.stop;
		Require(~timescore);
		//start global score
		1.wait;
		u.play;
		}.play;
	});
	}, '/timenet', n);
	);

	///////////////////////
	// THE GLOBAL SCORE
	///////////////////////
	u = Routine {
		Require(~timescore);
		//play master score
		p = Pdef(\part, Pdef(\main,
			Pseq([
				//start score
				Pfindur(10, Pdef(\part1)),
				Pfindur(16, Pdef(\part2)),
				Pfindur(16, Pdef(\part3)),
				Pfindur(16, Pdef(\part4)),
				Pfindur(16, Pdef(\part5)),
				Pfindur(16, Pdef(\part6)),
				Pfindur(16, Pdef(\part7)),
			],1),
	)).play;
	};
};
).play;
)
//r.play;
b.play
//b.plot;






