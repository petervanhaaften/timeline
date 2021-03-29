s.options.sampleRate = 44100;
s.boot;

(
b = Buffer.alloc(s, 100 * s.sampleRate);

(
SynthDef(\trigger, {
	var in, ctl;
	in = 2*SoundIn.ar(0);
	//release of Amplitude controls how long before stop recording, after audience speaks
	ctl = Amplitude.ar(in, 0.001, 1);
	//trigger record, id 1000
	SendTrig.ar(in: Schmidt.ar(ctl, 0.07, 0.15), id: 1000, value: ctl);
	//trigger pause, id 1001
	SendTrig.ar(in: Schmidt.ar(1 - ctl, 0.85, 0.93), id: 1001, value: 1);
}).add;
);

(
SynthDef(\voiceRecorder, {
	arg bufnum=0, pos=0, t_trig=1, t_sendTime=0;
	var in, phase, ctl;
	in = SoundIn.ar(0);
	//phasor drives BufWr, gated by t_trig
	phase = Phasor.ar(t_trig, BufRateScale.kr(bufnum), 0, BufFrames.kr(bufnum), pos);
	//send phasor position to client
	SendTrig.kr(t_sendTime, 9999, phase);
	BufWr.ar(in, bufnum, phase);
	0.0;
}).add;
);

(
SynthDef(\timer, {
	arg t_trig=1;
	var timer;
	//make timer
	timer = Timer.kr(trig: t_trig);
	SendTrig.kr(in: t_trig, id: 9998, value: timer);
	//SendTrig.ar(in: Impulse.ar(100, 0, 1, 0), id: 9998, value: timer);
}).add;
);
)

(
//TDEF waiter, is waiting for when signal is zero
//10.wait does not give desired logic
Tdef(\waiter, { 10.wait; ~position = 0; ~time = 0;  ~maxtime = 5; "done waiting".postln;});

//~position = 0;
//create voicerecorder
~rec = Synth(\voiceRecorder, [\bufnum, b.bufnum, \pos, 0, \t_trig, 0]);
//trigger is always running
~trigger = Synth(\trigger);
//adding timer to replace 10.wait
//timer will make sure audience voice only records for X amount of time
~timer = Synth(\timer, \t_trig, 0);
~timesum = 0;
OSCdef(\trigger, {
	arg msg;
	//if signal > threshold (id1000), trigger record
	(msg[2] == 1000).if({
		//trig timer
		~timer.set(\t_trig, 1);
		//start recorder
		~rec.set(\pos, ~position, \t_trig, 1);
		//cancel waiting
		Tdef(\waiter).stop;
		"recording from ".post;
		~position.postln;
	});
	//if signal < threshold (id1001), ask synth to send position in buffer
	(msg[2] == 1001).if({
		//pause recorder, send time position
		~rec.set(\t_sendTime, 1);
		"Requesting position from server".postln;
	});
	(msg[2] == 9999).if({
		//receive position from buffer
		~position = msg[3];
		//start waiting (10 sec)
		//THIS PART IS DEF WRONG!!!
		Tdef(\waiter).play;
		"paused, waiting".postln;
		//calculating amount of time recorded so far
		//trig timer
		~timer.set(\t_trig, 1);
		~timesum = (~time + ~timesum);
		"TIMESUM : ".post;
		~timesum.postln;
		//if amount of recorded time is more than maxtime,
		//stop recording
		(~timesum > ~maxtime).if({
			"OVER MAX TIME".postln;
		})
	});
	(msg[2] == 9998).if({
		//receive time
		~time = msg[3];
		"TIME : ".post;
		~time.postln;
		//~timesum = (~timesum + ~time);
		//"TIMESUM : ".post;
		//~timesum.postln;
	});
}, '/tr', s.addr)
)
Timer.kr(trig: 1).postln
x.free;
b.play

~timesum = 0;