s.options.sampleRate = 44100;
s.boot;

(
b = Buffer.alloc(s, 20 * s.sampleRate);

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
//TDEF waiter, is waiting for when ampliotude is zero
Tdef(\waiter, { 10.wait; ~position = 0; "done waiting".postln;});
~position = 0;
//voice recorder is always running
~rec = Synth(\voiceRecorder, [\bufnum, b.bufnum, \pos, 0, \t_trig, 1]);
//trigger is always running
~trigger = Synth(\trigger);
OSCdef(\trigger, {
	arg msg;
	//if we go above threshold, trigger record
	(msg[2] == 1000).if({
		~rec.set(\pos, ~position, \t_trig, 1);
		//cancel waiting
		Tdef(\waiter).stop;
		"recording from ".post;
		~position.postln;
	});
	//if we go back below threshold, ask synth to send position in buffer
	(msg[2] == 1001).if({
		~rec.set(\t_sendTime, 1);
		"Requesting position from server".postln;
	});
	(msg[2] == 9999).if({
		//receive position in buffer,
		~position = msg[3];
		//start waiting (10 sec)
		Tdef(\waiter).play;
		"paused, waiting".postln;
	});
}, '/tr', s.addr)
)

x.free;
b.play
