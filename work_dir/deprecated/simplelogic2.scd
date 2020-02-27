///////////////////////
// WAV PROCESSING W/SOX
///////////////////////
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

///////////////////////
// FINALPROCESS
///////////////////////
(
~finalprocess = Routine {
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
}
);

///////////////////////
// PRIMARY LOGIC
///////////////////////
(
//netaddress re: trigger for second beep and music perform
n = NetAddr("127.0.0.1", 57120);
~recordvoice = Routine {
~position = 0;
~postime = 0;
//create voicerecorder
~rec = Synth(\voiceRecorder, [\bufnum, b.bufnum, \pos, 0, \t_trig, 0]);
//trigger is always running
~trigger = Synth(\trigger);

//elapsed actual recording time
//TODO: figure out better labels
//timeCurrent
t = 0;
//timeOld
m = Date.getDate.rawSeconds;

//var mintime, var maxtime, var recordedtime, var pausewaittime
//if recorded or paused. . .
//////if t > ~maxrecordtime, then STOP
//if paused. . .
//////if (t > ~minrecordtime) && (~minrecordtimeBreak > 4) then STOP
//////if (t > ~minrecordtime) && (~minrecordtimeBreak < 5) then STILL ALLOW RECORDING POTENTIAL
d = 0;
OSCdef(\trigger, {
	arg msg;
	//if signal > threshold (id1000), trigger record
	(msg[2] == 9998).if({
		d = d + 1;
			"watch" + d.postln;
		(t > ~maxrecordtime).if({
			"WINNER".postln;
			~finalprocess;
		});
	});
	(msg[2] == 1000).if({
		//get correct time of recording, to enable minimum and maximum recording lengths
		//t = (Date.getDate.rawSeconds - m);
		//"rec".postln;
		//"current_time : "+t.postln;
		//start recorder
		~rec.set(\pos, ~position, \t_trig, 1);
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

		//if amount of recorded time is more than maxtime,
		//stop recording

		(~postime > ~maxrecordtime).if({
			~finalprocess.play;
		})
	});
}, '/tr', s.addr)
};
);

//var mintime, var maxtime, var recordedtime, var pausewaittime
//if recorded or paused. . .
//////if t > ~maxrecordtime, then STOP
//if paused. . .
//////if (t > ~minrecordtime) && (~minrecordtimeBreak > 4) then STOP
//////if (t > ~minrecordtime) && (~minrecordtimeBreak < 5) then STILL ALLOW RECORDING POTENTIAL


d = 0;
t = Task({ { d = d + 1;"I'm loopy"+d.postln; 1.wait;}.loop });
t.start;
t.stop;
t.pause;
