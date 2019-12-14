//1. A SynthDef that receives the vocal input (via SoundIn.ar() ) and processes it with a Compander.ar() configured as a noise gate.  The signal then goes through a DetectSilence.ar(), then SendTrig, wich sends a trigger to the language.
//
//2. The language receives triggers everytime threshold X is passed.  It creates another synth (item 3) that starts when the threshold is passed.  Routines pause or stop the synth according to your algo.  Some vaguely complicated logic is requiered here.
//
//3. Another SynthDef records in a buffer (using BufWr() ). The phase of the BufWr is a Line.ar() that goes through a Gate.ar(), so it can pause.  This is controled by the routines mentioned before.  Not sure of the details.

s.options.sampleRate = 44100;
s.boot;

//////////////
//voice input synthdef
//////////////

(
SynthDef("voicesig", { |out|
	var mic, gate, trig_pause, trig_record;
	mic = SoundIn.ar(0,1,0);
	//pass microphone through noisegate
	//noisegate opens when audience speaks, closes when they stop
	gate = Compander.ar(mic, mic,
		thresh: 0.1,
        slopeBelow: 50,
        slopeAbove:  1,
        clampTime:   0.002, //2ms
        relaxTime:   0.1 //100ms
	);
	//detect when noisegate opens with envelope follower
	trig_record = Amplitude.ar(gate,
		attackTime: 0.01,
		releaseTime: 0.01,
	);
	//send "trig_record" trigger to client, to begin recording buffer
	SendTrig.ar(trig_record > 0, 1, 1);
	//detect when the noisegate closes with DetectSilence
	trig_pause = DetectSilence.ar(gate,
		amp: 0.0001,
		time: 0.1,
		doneAction: 0
	);
	//send "trig_pause" trigger to client, to pause recording buffer
	SendTrig.ar(trig_pause, 0, 0);
	Out.ar(out, gate);
}).add;
)

Synth("voicesig");
p = Pmono(\voicesig).play

//receive trigger from server
o = OSCFunc({ arg msg, time;
    [time, msg].postln;
},'/tr', s.addr);

//////////////
//voice record synthdef
//////////////

(
//allocate 10 second buffer for audiennce voice
s = Server.local;
s.sendMsg("/b_alloc", 0, 44100 * 10);
)

//record voice synthdef, with gate for pausing/unpausing
(
SynthDef("voicerec", { |out, rate = 1, gate = 0|
	var mic;
	mic = SoundIn.ar(0,1,0);
    BufWr.ar(mic,
		bufnum: 0,
		//gate the phasor to pause
		phase: Gate.ar(
			in: Phasor.ar(0, BufRateScale.kr(0) * rate, 0, BufFrames.kr(0)),
			trig: gate),
		loop: 1.0
	);
}).add;
)


//gen some logic to allow voicesig synthdef to trigger voicerec synthdef
(
var a = 1, z;
z = if (a < 5, { 100 },{ 200 });
z.postln;
Synth("voicerec", ["gate",1]);
)

y = Synth.new("voicerec");

p = Pmono(\voicerec, \gate, 1).play

(
var a = 1, z;
z = if (a < 5, { 100 },{ 200 });
z.postln;
)

//play buffer
(
x = { arg rate=1;
    BufRd.ar(1, 0, Phasor.ar(0, BufRateScale.kr(0) * rate, 0, BufFrames.kr(0)))
}.play(s);
)

