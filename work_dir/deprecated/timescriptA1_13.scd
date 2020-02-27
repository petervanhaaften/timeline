//
//first working voice2music composition for 'the timeline' project
//peter van haaften, january 2020
//
(
Routine {
Server.default=s=Server.internal;
//Server.default.options.sampleRate = 44100;
s.boot;
3.wait;
"done!!!".postln;


//CONFIGURATION -- could be split to GLOBAL file and A1 local file
// # flag for timeline src directory
// - macbook location
~srcdir = Platform.userHomeDir +/+ "src/Projects/timeline/";
// - debian location
//~srcdir = Platform.userHomeDir +/+ "src/timeline/";
// # flag for timeline operator speech
~operatorwav = ~srcdir +/+ "audio/stateyourname.wav";
// # flag for timeline operator error msg
~operatorerrorwav = ~srcdir +/+ "audio/sorry.wav";
// # flag for simplelogic location
~simplelogic = ~srcdir +/+ "simplelogic11.scd";
// # flag for simplerec location
~simplerec = ~srcdir +/+ "simplerec4.scd";
// # flag for gransyn1 location
~gransyn1 = ~srcdir +/+ "pvh.gransyn1.scd";
// # flag for timescore location.
~timescore = ~srcdir +/+ "timescoreA1_3.scd";
// # flag for min recording length
~minrecordtime = 3;
// # flag for time (in seconds) before min recording breaks, function stops waiting for ~maxrecordtime to pass, and prints wav
~minrecordtimeBreak = 2;
// # flag for max recording length
~maxrecordtime = 8;
// # time to wait on pause (below ~minrecordtime) before triggering error message
~errortime = 2;
// # flags for recording input lvl
~telephoneAmp = 1;
// # flag for telephone mic gate [ non-positive value opens gate ]
~micGate = 1;
// # flags for attack/decay of amp when recording
// # flag for recorder time to wait before stop recording :
// [ release of Amplitude controls how long before stop recording, after audience speaks ]
~recorderAttackTime = 0.0001;
~recorderReleaseTime = 0.4;
// # flag for record sensitivity //trigger record, id 1000
~recorderRecordTrigLo = 0.07;
~recorderRecordTrigHi = 0.15;
// # flag for record pause sensitivity //trigger pause, id 1001
~recorderPauseTrigLo = 0.85;
~recorderPauseTrigHi = 0.93;

(
/////////////////////////
// VOICE INTRO SYNTHDEF
/////////////////////////

(
SynthDef("bufferplay",{ arg out = 0, bufnum;
			Out.ar( out,
				PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
			)
}
).add;
e = Buffer.read(s, ~operatorwav);
);

/////////////////////////
// VOICE ERROR SYNTHDEF
/////////////////////////

(
SynthDef("bufferplay",{ arg out = 0, bufnum;
			Out.ar( out,
				PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
			)
}
).add;
o = Buffer.read(s, ~operatorerrorwav);
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
// ERROR SCORE PLAYBACK
///////////////////////
(
~errorplayback = Routine.new( {

	//var k set to 1 to indicate currently going through sorry process
	k = 1;
	//clear buffer!!
	"kVALUEbegrec : ".post; k.postln;
	//b.free;
	//b = Buffer.alloc(s, 100 * s.sampleRate);
	o.play;
	6.22.wait;
	o.stop;
	"// beep_error".postln;
	f = Pmono(\sinbeep, \dur, 1, \amp, 2, \attack, 0, \sustain, 1, \release, 0, \freq, 440).play;
	//wait until beep is finished
	2.wait;
	f.stop;
	//Require(~timescore);
	//start global score
	1.wait;
	~trigger.set(\micGate, 1);
	~recordvoice.play;
	//u.play;
	k = 0;
	d = 0;
};);
);

///////////////////////
// VOICE SCORE PLAYBACK
///////////////////////
(
~voiceplayback_pt2 = Routine {
	//reset crap
	//b.free;
	//b = Buffer.alloc(s, 100 * s.sampleRate);
	"// beep2".postln;
	f = Pmono(\sinbeep, \dur, 1, \amp, 2, \attack, 0, \sustain, 1, \release, 0, \freq, 440).play;
	//wait until beep is finished
	2.wait;
	f.stop;
	//Require(~timescore);
	//start global score
	1.wait;
	//~recordvoice.play;
}
);

///////////////////////
// MASTER SCORE PLAYER
///////////////////////
(
z = Routine {
	//the synthesizer for this score
	Require(~gransyn1);
	//voice rec synthdef
	Require(~simplerec);
	//voice rec logic, interacts with synthdef
	Require(~simplelogic);


	//reset crap
	b.free;
	b = Buffer.alloc(s, 100 * s.sampleRate);
	//
	//DEAL ALLOWS AUDIO TO BOOT
	//
	5.wait;
	"// operator speaks".postln;
	a = Pmono(\bufferplay, \bufnum, e.bufnum, \dur, 1).play;
	//wait until audio file is finished (saymyname, 2.2sec)
	//should programatically determine the audio file length
	4.968.wait;
	"// beep1".postln;
	f = Pmono(\sinbeep, \dur, 1, \amp, 2, \attack, 0, \sustain, 1, \release, 0, \freq, 440).play;
	//wait until beep is finished
	2.wait;
	f.stop;
	0.5.wait;
	~recordvoice.play;
	//OSCdef
	(
	OSCdef(\receivewhatever, {|msg, time, addr, recvPort|
	(msg[1] == \recdone).if({
	~voiceplayback_pt2.play;
	});
	}, '/timenet', n);
	);
}.play;
);
);
)
//r.play;
//b.play
//b.plot;
//u.play;


//~recordvoice.reset
//~recordvoice.play