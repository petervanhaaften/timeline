s.boot;


Server.local.waitForBoot({
		{ SinOsc.ar(480)*0.1 }.play;
	});



{ SinOsc.ar(440, 0, 0.5) }.play;

// http://danielnouri.org/docs/SuperColliderHelp/UGens/Playback%20and%20Recording/RecordBuf.html
//check DetectSilence

// Execute the following in order

(
// allocate a Buffer
s = Server.local;
b = Buffer.alloc(s, 44100 * 4.0, 1); // a four second 1 channel Buffer
)


// record for four seconds

(
SynthDef("record2buffer",{ arg out=0,bufnum=0;
	var input;
	input = SoundIn.ar(0,1,0);
	RecordBuf.ar(input, bufnum);
	// maximum 4 seconds, line frees syntha after 4sec
	Line.ar(0,1,4,1,0,doneAction:2)
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)


x = Synth.new("record2buffer");
x.free;


// play it back

(
SynthDef("record2buffer play",{ arg out=0,bufnum=0;
	var playbuf;
	playbuf = PlayBuf.ar(1,bufnum);
	FreeSelfWhenDone.kr(playbuf); // frees the synth when the PlayBuf is finished
	Out.ar(out, playbuf);
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)


// overdub

(
SynthDef("record2buffer overdub",{ arg out=0,bufnum=0;
	var input;
	// XLine will free the Synth when done
	input = SoundIn.ar(0,1,0);
	RecordBuf.ar(input, bufnum, 0, 0.5, 0.5); // mixes equally with existing data
		// maximum 4 seconds, line frees syntha after 4sec
	Line.ar(0,1,4,1,0,doneAction:2)
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)

// play back the overdubbed version

Synth.new("record2buffer play", [\out, 0, \bufnum, b.bufnum], s);


// write the contents of the buffer to a file (see Buffer for more options)

b.write(
	"/Users/pvh/src/Projects/timeline/test.wav", "WAVE","int16"
);



// CONCAT EXPERIMENTS

b = Buffer.read(s,"/Users/pvh/src/Projects/timeline/test.wav");


//granulator
(
{
var concat, control, input;

control= Saw.ar(SinOsc.kr(LFNoise0.kr(MouseY.kr(0.01,1),3,4.5),0,10,MouseY.kr(12,100)));

input=PlayBuf.ar(1,b.bufnum,BufRateScale.kr(b.bufnum), loop:1);

concat= Concat2.ar(control,input,2.0,2.0,2.0,MouseX.kr(0.01,0.1),0,MouseY.kr(0.0,1.0),1.0,0.5);

Out.ar(0,Pan2.ar(concat,0.0))}.play
)


// GRANULAR EXPERIMENTS


//num1
(
SynthDef(\buf_grain_test, {arg gate = 1, sndbuf, amp = 1;
    Out.ar(0,
        BufGrain.ar(Impulse.kr(2), .1, sndbuf, SinOsc.kr(5, 0.8, 1, add: 0), PinkNoise.kr.range(5, 9), 2,
            EnvGen.kr(
                Env([0, 1, 0], [1, 1], \sin, 1),
                gate,
                levelScale: amp,
                doneAction: 2)
        )
    )
}).add;
)

s.sendMsg(\b_allocRead, z = s.bufferAllocator.alloc(1), "/Users/pvh/src/Projects/timeline/test.wav");

s.sendMsg(\s_new, \buf_grain_test, a=s.nextNodeID, 0, 1, \amp, 0.1, \sndbuf, z);
s.sendMsg(\n_set, a, \gate, 0);
s.sendMsg(\b_free, z);

//num2
(
var winenv;

b = Buffer.read(s, "/Users/pvh/src/Projects/timeline/test.wav");
// a custom envelope
winenv = Env([0, 1, 0], [0.5, 0.5], [8, -8]);
z = Buffer.sendCollection(s, winenv.discretize, 1);

SynthDef(\buf_grain_test, { |out, gate = 1, amp = 1, sndbuf, envbuf|
    var pan, env, freqdev;
    // use mouse x to control panning
    pan = MouseX.kr(-1, 1);
    env = EnvGen.kr(
        Env([0, 1, 0], [1, 1], \sin, 1),
        gate,
        levelScale: amp,
        doneAction: Done.freeSelf);
    Out.ar(out,
        GrainBuf.ar(2, Impulse.kr(30), 5, sndbuf, LFNoise1.kr.range(0.5, 5),
            LFNoise2.kr(0.5).range(0, 1), 2, pan, envbuf) * env)
}).add;
)

// use built-in env
x = Synth(\buf_grain_test, [\sndbuf, b, \envbuf, -1])

// switch to the custom env
x.set(\envbuf, z)
x.set(\envbuf, -1);

x.set(\gate, 0);