SynthDef(\bufGrainPan, { |start, time, bufnum, pan, rate = 1, amp = 1,
		attack = 0.001, decay = 0.02, outbus|
	var sig;
	sig = PlayBuf.ar(1, bufnum, rate * BufRateScale.kr(bufnum), 1, start, 0)
		* EnvGen.kr(Env.linen(attack, time, decay), doneAction:2);
	OffsetOut.ar(outbus, Pan2.ar(sig, pan, amp));
}).add;

p = Pbind(
	\instrument, \bufGrainPan,
	\bufnum, b,
	\start, 15000,
	\time, 0.1,
	\dur, 0.2
);

b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

q = p.trace.play;  // nothing
