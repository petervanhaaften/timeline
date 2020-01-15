(
~wavprocess = Routine {
	//normalise recorded wave w/sox
	a = "/usr/local/bin/sox" + ~srcdir +/+ "audio/bufferrec1.wav" + ~srcdir +/+ "audio/bufferrec1_normalised.wav" + "gain -n -3";
	a.unixCmd("done : normalise".postln, false);
	0.1.wait;
	//compress recorded file
	//compand 0.02,0.2 5:-60,-40,-20 -5 -80 0.1
c = "/usr/local/bin/sox" + ~srcdir +/+ "audio/bufferrec1_normalised.wav" + ~srcdir +/+ "audio/bufferrec1_compressed.wav" + "compand 0.02,0.2 5:-60,-40,-20 -5 -80 0.1";
	c.unixCmd("done : compression".postln, false);
	0.1.wait;
	//switch buffer
	b = Buffer.read(s, ~srcdir +/+ "/audio/bufferrec1_compressed.wav");
};
);

(
//elapsed actual recording time
//TODO: figure out better labels
(
//timeCurrent
var recordClock = 0;
//timeOld
m = Date.getDate.rawSeconds;
)


//netaddress re: trigger for second beep and music perform
n = NetAddr("127.0.0.1", 57120);
~recordvoice = Routine {
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
		//timestuff
		u = Date.getDate.rawSeconds + u;
	});
	//if signal < threshold (id1001), ask synth to send position in buffer
	(msg[2] == 1001).if({
		//pause recorder, send time position
		~rec.set(\t_sendTime, 1);
		//DEBUG//"Requesting position from server".postln;
	});
	(msg[2] == 9999).if({
		//receive position from buffer
		~position = msg[3];
		//DEBUG//"paused, waiting at ".post;
		//DEBUG//~position.postln;

		//calculating amount of time recorded so far
		~postime = (~position / s.sampleRate);
		//DEBUG//"position calculation = ".post;
		//DEBUG//~postime.postln;

		//time stuff
		t = Date.getDate.rawSeconds - u;
		"SAVEDTIME : " + t.postln;

		//if amount of recorded time is more than maxtime,
		//stop recording
		(~postime > ~maxrecordtime).if({
			"TIME"+t.poll;
				t.postln;
			"OVER MAX TIME".postln;
			//Buffer.set
			//stop recording
			~rec.free;
			~trigger.free;
			//print buffer as .wav
			b.write(path: ~srcdir +/+ "audio/bufferrec1.wav";, headerFormat: "wav", sampleFormat: "int24", numFrames: ~position, startFrame: 0, leaveOpen: false, completionMessage: "finished".postln;);
			//compress and normalize
			~wavprocess.play;
			//trigger oscdef in main score file, for second beep and music score !
			n.sendMsg("/timenet", \recdone);
			//free OSCdef
			//OSCdef.freeAll;
		})
	});
}, '/tr', s.addr)
};
)



(
//u = ((Date.getDate.rawSeconds - m) + u );//(Date.getDate.rawSeconds - u));
var recordClock = (Date.getDate.rawSeconds - m);
recordClock.postln;
)