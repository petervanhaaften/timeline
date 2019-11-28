s.options.sampleRate = 44100;

{ Impulse.ar(0, 0.0, 0.5, 0) }.scope

// GRANULAR BUFGRAINB_take2

////
//tgrains synthdef
////

s.sendMsg(\b_allocRead, 10, "/Users/pvh/src/Projects/timeline/test2.wav");
c=Buffer.alloc(s, s.sampleRate * 0.2, 1)

(
var y, h;
y=Signal.hammingWindow(s.sampleRate * 0.4);
h=Array.fill(s.sampleRate * 0.2, {|i| y[i]});
c.loadCollection(h);
)

// TGrains3.ar(numChannels, trigger: 0, bufnum: 0, rate: 1, centerPos: 0, dur: 0.1, pan: 0, amp: 0.1, att: 0.5, dec: 0.5, window: 1, interp: 4)

(
SynthDef(\gransyn1, {arg out, trate;
	Out.ar(out,
		TGrains3.ar(1, \trig.kr, \b.kr, \rate.kr, \pos.kr, \dur.kr, \pan.kr, 0.1, \dur.kr*0.1, \dur.kr*0.3, c.bufnum, 4)
	)
}).add;
)

//clk 1*
//b = 10*
//rate = 1??
//pos = 0*
//dur = 0.1*
//pan = 0*
//amp = 0.1
//attack = 0.5
//decay  = 0.5
// window = 1
//interp = 4

x = PatternProxy.new;

x.play;
x.source = Pbind(\instrument, \gransyn1, \trig, 1, \b, 10, \rate, -0.5, \pos, 20, \dur, 0.5, \pan, 0);

x.source = Pbind(
	\instrument, \gransyn1,
	\trig, 1,
	\b, 10,
	\rate, -1,
	\pos, 200,
	\dur, 0.1,
	\pan, 0
);

x.set(\clk, 1);

(
// Alternative syntax, using a key/pattern array:
Pbind(*[
    instrument:            \test,
    nharms:                Pseq([4, 10, 40], inf),
    dur:                Pseq([1, 1, 2, 1]/10, inf),
    #[freq, sustain]:    Ptuple([
                            Pseq( (1..16) * 50, 4),
                            Pseq([1/10, 0.5, 1, 2], inf)
                        ])
]).play;
)



////
//named control
/////

// use NamedControl to create a number of multichannel controls:

a = { SinOsc.ar(NamedControl.kr(\freq, [300, 330, 370], [1, 0.3, 0.02])).sum * 0.1 }.play;
a.setn(\freq, [700, 705, 890]);
a.setn(\freq, [0, 2, 5].midiratio * 400);

// synonymous:
a = { SinOsc.ar(\freq.kr([300, 330, 370], [1, 0.3, 0.02])).sum * 0.1 }.play;

// multiple usage of the same name:
a = { SinOsc.ar(\freq.kr(440, 3.5)) + Saw.ar(\freq.kr(440, 0.05) * 0.5) * 0.1 }.play;


a.set(\freq, 1220)
a.set(\freq, 120)

//////
// GRANULAR BUFGRAINB
//////

// BufGrainB.ar(trigger: 0, dur: 1, sndbuf, rate: 1, pos: 0, envbuf, interp: 2, mul: 1, add: 0)

(
SynthDef(\buf_grain_test, {arg gate = 1, sndbuf, amp = 1, envbuf, trigger = 4, duration = 1, lfofreq = 0.3;
    Out.ar(0,
		BufGrainB.ar(Impulse.kr(trigger), duration, sndbuf, LFSaw.ar(lfofreq, 0, 3, 0), PinkNoise.kr.range(0, 1),
            envbuf, 2,
            EnvGen.kr(
                Env([0, 1, 0], [0.02, 0.9, 5], \sin, 1),
                gate,
                levelScale: amp,
				timeScale: 1,
                doneAction: 2)
        )
    )
}).add;
)

s.sendMsg(\b_allocRead, x = s.bufferAllocator.alloc(1), "/Users/pvh/src/Projects/timeline/test2.wav");

x = PatternProxy.new;

x.play;
x.source = Pbind(\instrument, \buf_grain_test, \dur, 1, \lfofreq, Pseq([0, 3, 2], inf), \trigger, Pseq([100, 3, 50], inf));
x.source = Pbind(\instrument, \buf_grain_test, \dur, 1, \lfofreq, 9, \trigger, 200);
x.stop;
x.free;
