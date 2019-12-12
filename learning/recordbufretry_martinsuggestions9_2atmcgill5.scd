s.options.sampleRate = 44100;
s.boot;

(
b = Buffer.alloc(s, 10 * s.sampleRate);

(
SynthDef(\trigger, {
	var in, ctl;
	in = SoundIn.ar(0);
	//release of Amplitude controls how long before stop recording, after audience speaks
	ctl = Amplitude.ar(in, 0.001, 1);
	//trigger record, id 1000
	SendTrig.ar(Schmidt.ar(ctl, 0.07, 0.15), 1000, ctl);
	//trigger pause, id 1001
	SendTrig.ar(Schmidt.ar(1 - ctl, 0.85, 0.93), 1001, 1);
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
)
)

(
//TDEF waiter, is waiting for when signal is zero
//10.wait does not give desired logic
Tdef(\waiter, { 10.wait; ~position = 0; "done waiting".postln;});
//~position = 0;
//create voicerecorder
~rec = Synth(\voiceRecorder, [\bufnum, b.bufnum, \pos, 0, \t_trig, 0]);
//trigger is always running
~trigger = Synth(\trigger);
//adding timer to replace 10.wait
~timer = Synth(\timer, \trig, 0);
OSCdef(\trigger, {
	arg msg;
	//if signal > threshold (id1000), trigger record
	(msg[2] == 1000).if({
		//start timer
		~timer.set(\trig, 1);
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
	});
}, '/tr', s.addr)
)
Timer.kr(trig: 1).postln
x.free;
b.play
