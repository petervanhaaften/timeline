
(
b.free;
b = Buffer.alloc(s, 100 * s.sampleRate);
// # flag for telephone mic gate [ non-positive value opens gate ]
~micGate = 1;
(
SynthDef(\trigger, {
	| micGate |
	var in, ctl;
	in = Gate.ar(~telephoneAmp * SoundIn.ar(0), micGate);
	//release of Amplitude controls how long before stop recording, after audience speaks
	ctl = Amplitude.ar(in: in, attackTime: ~recorderAttackTime, releaseTime: ~recorderReleaseTime);
	//trigger record, id 1000
	SendTrig.ar(in: Schmidt.ar(in: ctl, lo: ~recorderRecordTrigLo, hi: ~recorderRecordTrigHi), id: 1000, value: ctl);
	//trigger pause, id 1001
	SendTrig.ar(in: Schmidt.ar(in: 1 - ctl, lo: ~recorderPauseTrigLo, hi: ~recorderPauseTrigHi), id: 1001, value: 1);
}).add;
);

(
SynthDef(\voiceRecorder, {
	arg bufnum=0, pos=0, t_trig=1, t_sendTime=0;
	var in, phase, ctl;
	in = ~telephoneAmp * SoundIn.ar(0);
	//clock trig
	SendTrig.ar(Impulse.ar(1, 0, 1, 0), 9998, 1);
	//phasor drives BufWr, gated by t_trig
	phase = Phasor.ar(t_trig, BufRateScale.kr(bufnum), 0, BufFrames.kr(bufnum), pos);
	//send phasor position to client
	SendTrig.kr(t_sendTime, 9999, phase);
	BufWr.ar(in, bufnum, phase);
	0.0;
}).add;
)
)
