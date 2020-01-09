
(
b = Buffer.alloc(s, 100 * s.sampleRate);

(
SynthDef(\trigger, {
	var in, ctl;
	in = SoundIn.ar(0);
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
)
)