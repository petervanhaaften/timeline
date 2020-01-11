(
s.options.sampleRate = 44100;
s.boot;

//CONFIGURATION
// # flag for timeline src directory
~srcdir = Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/";
// # flag for timeline operator speech audio directory
~operatorwav = ~srcdir +/+ "audio/sayyourname.wav";
// # flag for simplelogic location
~simplelogic = ~srcdir +/+ "simplelogic.scd";
// # flag for simplerec location
~simplerec = ~srcdir +/+ "simplerec.scd";
// # flag for gransyn1 location
~gransyn1 = ~srcdir +/+ "pvh.gransyn1.scd";
// # flag for timescore location
~timescore = ~srcdir +/+ "timescoreA1.scd";
// # flag for min recording length
// # flag for max recording length
// # flags for recording input lvl

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
	2.3.wait;
	//beep!
	f = Pmono(\sinbeep, \dur, 1, \amp, 2, \attack, 0, \sustain, 1, \release, 0, \freq, 440).play;
	//wait until beep is finished
	2.wait;
	f.stop;
	0.3.wait;
	~recordvoice.play;
	//SystemClock.sched(0.05, {Synth.new(name, s);}); //create synth after 0.05 sec

	//play next beep
	//musik
};
);
)
r.play;



(
OSCdef(\test, {|msg, time, addr, recvPort|
		(msg[1] == \blah).if({
		msg.postln;
		"win2".postln;
	});
}, '/recdone', n); // def style
)

m = NetAddr("127.0.0.1", 57120);
m.sendMsg("/recdone", \blah)



(
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
)).trace.play;
)

r.play
Require(~timescore);
p.play

b.play







