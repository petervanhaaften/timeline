//1. A SynthDef that receives the vocal input (via SoundIn.ar() ) and processes it with a Compander.ar() configured as a noise gate.  The signal then goes through a DetectSilence.ar(), then SendTrig, wich sends a trigger to the language.
//
//2. The language receives triggers everytime threshold X is passed.  It creates another synth (item 3) that starts when the threshold is passed.  Routines pause or stop the synth according to your algo.  Some vaguely complicated logic is requiered here.
//
//3. Another SynthDef records in a buffer (using BufWr() ). The phase of the BufWr is a Line.ar() that goes through a Gate.ar(), so it can pause.  This is controled by the routines mentioned before.  Not sure of the details.
//
//
///
//
// Specific issue : I need to record into a buffer (or direct to disk) the callers voice. The recording should be (as much as possible) strictly composed of voice---silences should be ignored.
//
// Step1 -  If the caller takes a few moments to respond, the buffer should wait until they begin speaking (signal passes threshold « X ») before recording.
//
// Step2 - If the caller pauses speaking, the buffer should pause recording and wait until the callers voice signal passes threshold « X » before recording again from the same position it had paused.
//
// Step3 - If amount of time « Y » has passed, and the buffer has already recorded some content, the buffer should stop recording.
//
// Step4 - If amount of time « Y » has passed, and the buffer has NOT recorded voice (threshold « X » never passed), the operator should play an « ErrorMsg » buffer, repeat the original question, and return to Step1.


//start routiune a fork,

Tdef

s.options.sampleRate = 44100;
s.boot;

s.options.dump
//////////////
//voice input synthdef
//////////////

b = Buffer.alloc(s, 20 * s.sampleRate);

(
SynthDef(\trigger, {
	var in, ctl;
	in = SoundIn.ar(0);
	ctl = Amplitude.ar(in, 0.001, 2);
	SendTrig.ar(Schmidt.ar(ctl, 0.07, 0.15), 1000, ctl);
	SendTrig.ar(Schmidt.ar(1 - ctl, 0.85, 0.93), 1001, 1);
}).add;
)

(
SynthDef(\voiceRecorder, {
	arg bufnum=0, pos=0, t_trig=1, t_sendTime=0;
	var in, phase, ctl;
	in = SoundIn.ar(0);
	phase = Phasor.ar(t_trig, BufRateScale.kr(bufnum), 0, BufFrames.kr(bufnum), pos);
	SendTrig.kr(t_sendTime, 9999, phase);
	BufWr.ar(in, bufnum, phase);
	0.0;
}).add;
)

(
//TDEF waiter, is waiting for when there is no more sound
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
		"Requesting position".postln;
	});
	(msg[2] == 9999).if({
		//receive position in buffer,
		~position = msg[3];
		//start waiting (10 sec)
		Tdef(\waiter).play;
		"something".postln;
	});
}, '/tr', s.addr)
)



x.free;
b.play

(
SynthDef(\voicesig, { |out|
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
	SendTrig.ar(in: trig_record > 0, id: 1, value: 1);
	//detect when the noisegate closes with DetectSilence
	trig_pause = DetectSilence.ar(gate,
		amp: 0.0001,
		time: 0.1,
		doneAction: 0
	);
	//send "trig_pause" trigger to client, to pause recording buffer
	SendTrig.ar(in: trig_pause, id: 0, value: 0);
	Out.ar(out, gate);
}).add;
)

Synth("voicesig");
p = Pmono(\voicesig).play

//////////////
//voice record synthdef
//////////////

(
//allocate 100 second buffer for audience voice
s = Server.local;
s.sendMsg("/b_alloc", 0, 44100 * 100);
)

//record voice synthdef, with gate for pausing/unpausing
(
SynthDef(\voicerec, { | out, rate = 1, trig = 0 |
	var mic;
	mic = SoundIn.ar(0,1,0);
    BufWr.ar(mic,
		bufnum: 0,
		//gate the phasor to pause
		phase: Gate.ar(
			//start needs to be variable, sent from q.set
			in: Line.ar(start: 0, end: BufFrames.kr(0), dur: 100.0, mul: 1, add: 0, doneAction: 0),
			trig: trig).poll,
		loop: 1.0
	);
	//debugging
	trig.poll;
}).add;
)

//works
q = Synth("voicerec");

q.set(\trig, 1);
q.set(\trig,0);


//NOT WORKING: instead of pausing, the Line.ar seems to restart whenever the gate re-opens.
//Pbind version
//pause recording
p = Pbind(\type, \set, \id, q.nodeID, \trig, 0).play;
//start recording
p = Pbind(\type, \set, \id, q.nodeID, \trig, 1).play;
//Pmono version
//pause recording
p = Pmono(\voicerec, \trig, 0).play
//start recording
p = Pmono(\voicerec, \trig, 1).play

//////////////
//play buffer
//////////////
(
x = { arg rate=1;
    BufRd.ar(1, 0, Phasor.ar(0, BufRateScale.kr(0) * rate, 0, BufFrames.kr(0)))
}.play(s);
)


//////////////////////////////////
////newlogic
////

(
q = Synth("voicerec");
y = Synth("voicesig");
)

//receive trigger from server
(
o = OSCFunc({ arg msg, time;
	//need to set it up so it looks for the id first
	var a = msg[3], b;
	//q.set(\trig, a);
	time.postln;
},'/tr', s.addr);
)


