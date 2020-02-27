
(
(
b = Buffer.alloc(s, 100 * s.sampleRate);

(
SynthDef(\trigger, {
	var in, ctl;
	in = 2*SoundIn.ar(0);
	//release of Amplitude controls how long before stop recording, after audience speaks
	ctl = Amplitude.ar(in: in, attackTime: 0.0001, releaseTime: 0.4);
	//trigger record, id 1000
	SendTrig.ar(in: Schmidt.ar(in: ctl, lo: 0.07, hi: 0.15), id: 1000, value: ctl);
	//trigger pause, id 1001
	SendTrig.ar(in: Schmidt.ar(in: 1 - ctl, lo: 0.85, hi: 0.93), id: 1001, value: 1);
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
);

(
~maxtime = 5;
~position = 0;
~postime = 0;
//create voicerecorder
~rec = Synth(\voiceRecorder, [\bufnum, b.bufnum, \pos, 0, \t_trig, 0]);
//trigger is always running
~trigger = Synth(\trigger);

OSCdef(\trigger, {
	arg msg;
	//if signal > threshold (id1000), trigger record
	(msg[2] == 1000).if({
		//start recorder
		~rec.set(\pos, ~position, \t_trig, 1);
	});
	//if signal < threshold (id1001), ask synth to send position in buffer
	(msg[2] == 1001).if({
		//pause recorder, send time position
		~rec.set(\t_sendTime, 1);
		//"Requesting position from server".postln;
	});
	(msg[2] == 9999).if({
		//receive position from buffer
		~position = msg[3];
		"paused, waiting at ".post;
		~position.postln;

		//calculating amount of time recorded so far
		~postime = (~position / 48000);
		"position calculation = ".post;
		~postime.postln;

		//if amount of recorded time is more than maxtime,
		//stop recording
		(~postime > ~maxtime).if({
			"OVER MAX TIME".postln;
		})
	});
}, '/tr', s.addr)
)
)
//x.free;
//b.play