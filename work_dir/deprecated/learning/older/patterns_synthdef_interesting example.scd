~t = 155/4/60; TempoClock.default.tempo = ~t;

(

SynthDef(\brownbass, { arg out=0, amp=0.1, gate=1, pan=0, freq=200;
	var sig;
	sig = LFPulse.ar(freq);
	sig = RLPF.ar(sig, ( \lpfr.kr(16) * freq ).clip(20,20000), \rq.kr(0.6)) + ( sig / 5 );
	sig = sig * EnvGen.ar(Env.adsr(0.01,0.1,0.8,0.1),gate,doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(out, sig);
}).add;
SynthDef(\organ, { arg out=0, amp=0.1, gate=1, pan=0, freq=200;
	var sig;
	sig = Pulse.ar(freq * [1,1.0001, 2/3],mul: [1,1,1/3]).mean;
	sig = RLPF.ar(sig, \lpfr.kr(1.1) * freq, \rq.kr(0.5));
	sig = sig * EnvGen.kr(\adsr.kr(Env.adsr(0.01,0.1,0.8,0.1)), gate, doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(out, sig);
}).add;

SynthDef(\snapkickx, { |out = 0, pan = 0, amp = 0.3|
	var body, bodyFreq, bodyAmp;
	var pop, popFreq, popAmp;
	var click, clickAmp;
	var snd;

	bodyFreq = EnvGen.ar(\bodyfreqenv.kr(Env([261, 60, 51], [0.035, 0.08], curve: \exp)));
	bodyAmp = EnvGen.ar(\bodyenv.kr(Env.linen(0.005, 0.1, 0.3)), doneAction: 2);
	body = SinOsc.ar(bodyFreq) * bodyAmp;
	popFreq = XLine.kr(\popfstart.kr(750), \popfend.kr(261), \popfdur.kr(0.02));
	popAmp = EnvGen.ar(\popenv.kr(Env.linen(0.001, 0.02, 0.001))) * \popamp.kr(0.15);
	pop = SinOsc.ar(popFreq) * popAmp;
	clickAmp = EnvGen.ar(Env.perc(\clickat.kr(0.001), \clickrel.kr(0.01))) * \clickamp.kr(0.15);
	click = LPF.ar(Formant.ar(\formfund.kr(910), \formfreq.kr(4760), \formbw.kr(2110)), \lpf.kr(3140)) * clickAmp;

	snd = body + pop + click;
	snd = snd * \distpreamp.kr(1);
	snd = snd.tanh;
	snd = snd * \distpostamp.kr(1);

	Out.ar(out, Pan2.ar(snd, pan, amp));
}).add;

SynthDef(\phyhat3, { arg out=0, amp=0.1, gate=1, pan=0, freq=200;
	var sig;
	var env1, env2, env3, env4, env5, env6, env7, env8;
	var sig1, sig2, sig3, sig4, sig5, sig6, sig7, sig8;
	sig = SinOsc.ar(freq);
	sig = WhiteNoise.ar;
	env1 = EnvGen.kr(Env([8210,1100,2051],[0.1,0.8]), 1, levelScale:LFNoise1.kr((1..8)/8).range(0.7,1.1) );
	env2 = EnvGen.kr(Env([18210,200,7451],[0.1,0.8],-4), 1, levelScale:LFNoise1.kr((1..8)/8).range(0.7,1.1) );
	sig = BPF.ar(sig, env1, LFNoise1.kr((1..8)/8).range(0.1,0.9));
	sig = HPF.ar(sig, 20000-env2);
	sig1 = sig;
	//sig = RLPF.ar(sig, env2, \rq.kr(0.5));
	sig = WhiteNoise.ar;
	env3 = EnvGen.kr(Env([1,0.9,1]*Rand(0.91,1.1),[0.01+Rand(0,0.1),0.8]), 1);
	sig = sig + Ringz.ar(sig, [9400,17030,1410,8000.14,5000] * env3, 0.001).mean/10;
	env1 = EnvGen.kr(Env([8821,7810,251],[0.01,0.8]), 1, levelScale:LFNoise1.kr((1..8)/8).range(0.7,1.1) );
	env2 = EnvGen.kr(Env([13820,15800,151],[0.01,0.8*\fac1.kr(1)],-4), 1, levelScale:LFNoise1.kr((1..8)/8).range(0.7,1.1) );
	sig = HPF.ar(sig, env1);
	sig = LPF.ar(sig, env2);
	sig2 = sig*1.3;

	sig = sig1+sig2;

	sig = sig * EnvGen.ar(\adsr.kr( Env.adsr(0.01,0.1,0.8,0.4,1,-4) ),gate,doneAction:2);
	sig = Pan2.ar(sig, pan, amp).sum;
	Out.ar(out, sig);
}).add;
)

~rest = Pfunc({ arg ev; if(ev[\isRest]) { Rest(0) } { 1 } });


(
Pdef(\part, Pdef(\part1,
	Ppar([
		Pbind(
			\instrument, \snapkickx,
			\bodyfreqenv, [ Env([261, 54, 21], [0.035, 0.08], curve: \exp) ],
			\dur, 1/8,
			\isRest, Pseq([
				1,0,0,1, 0,0,1,0,
			],inf).coin.not,
			\rest, ~rest,
			\amp, 0.1,
		),
		Pbind(
			\instrument, \phyhat3,
			\isRest, Pseq([
				1,1, 0,1, 1,1, 1,1,
				1,1, 1,1, 1,1, 0,1,
			],inf).coin.not,
			\rest, ~rest,
			\sustain, 0.05,
			\fac1,0.1,
			\dur, 1/8,
			\amp, 0.01 * Pseq([1,0.7],inf),
		),
		Pbind(
			\instrument, \brownbass,
			\note, Pseq([
				0,-1,
			],inf),
			\octave, 3,
			\dur, 1,
			\amp, 0.1,
		),
		Pbind(
			\instrument, \organ,
			\note, Pseq([
				0,1,-1,
			],inf),
			\legato, Pseq([
				0,0,2,0, 0,1/2,0,1/2,
			],inf),
			\isRest, Pfunc({ arg ev; ev[\legato] <= 0 }),
			\rest, ~rest,
			\dur, 1/8,
			\amp, 0.1,
		),
	])
)).play;
)

(
Pdef(\part, Pdef(\part2,
	Ppar([
		Pbind(
			\instrument, \snapkickx,
			\bodyfreqenv, [ Env([261, 54, 21], [0.035, 0.08], curve: \exp) ],
			\dur, 1/8,
			\isRest, Pseq([
				1,0,1,0, 1,0,1,0,
				0,0,0,0, 0,0,0,0,
			],inf).coin.not,
			\rest, ~rest,
			\amp, 0.1,
		),
		Pbind(
			\instrument, \phyhat3,
			\isRest, Pseq([
				1,0, 0,0, 1,1, 1,0,
				1,0, 0,1, 0,0, 0,0,
			],inf).coin.not,
			\rest, ~rest,
			\sustain, 0.05,
			\fac1,0.1,
			\dur, 1/8,
			\amp, 0.01 * Pseq([1,0.7],inf),
		),
		Pbind(
			\instrument, \brownbass,
			\note, Pseq([
				0,-2,
			],inf),
			\octave, 3,
			\dur, 1,
			\amp, 0.1,
		),
		Pbind(
			\instrument, \organ,
			\note, Pseq([
				0,1,-1,
			],inf),
			\legato, Pseq([
				0,0,0,0, 0,0,0,0,
				1,1,1,1, 1,1,1,1,
			],inf),
			\isRest, Pfunc({ arg ev; ev[\legato] <= 0 }),
			\rest, ~rest,
			\dur, 1/8,
			\amp, 0.1,
		),
	])
)).play;
)

(
Pdef(\part, Pdef(\main,
	Pseq([
		Pfindur(8, Pdef(\part1)),
		Pfindur(8, Pdef(\part2)),
	],1),
)).play;
)