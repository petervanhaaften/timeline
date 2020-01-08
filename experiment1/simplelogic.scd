(
Routine {
~maxtime = 2;
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
		(~postime > ~maxtime).if({
			"OVER MAX TIME".postln;
			//Buffer.set
			//stop recording
			~rec.free;
			~trigger.free;
			//print buffer as .wav
			b.write(path: Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/audio/fuktest1.wav";, headerFormat: "wav", sampleFormat: "int24", numFrames: ~position, startFrame: 0, leaveOpen: false, completionMessage: "finished".postln;);
			//normalize recorded buffer
			//compress recorded file
			//free OSCdef
			OSCdef.freeAll;
		})
	});
}, '/tr', s.addr)
}
)

a = "/Users/pvh/cdpr7/_cdp/_cdprogs/modify loudness 3" + Platform.userHomeDir +/+ "/src/Projects/timeline/experiment1/audio/fuktest1.wav" + Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/audio/fuktest1_new51.wav -l0.95"

a.unixCmd("done".postln, false);

"/Users/pvh/cdpr7/_cdp/_cdprogs/modify loudness 3 /Users/pvh/src/Projects/timeline/experiment1/audio/fuktest1.wav /Users/pvh/src/Projects/timeline/experiment1/audio/fuktest1_new59.wav -l0.95".unixCmd("done".postln, false);

"/Users/pvh/cdpr7/_cdp/_cdprogs/modify loudness 3" + Platform.userHomeDir +/+ "/src/Projects/timeline/experiment1/audio/fuktest1.wav" + Platform.userHomeDir +/+ "src/Projects/timeline/experiment1/audio/fuktest1_new51.wav -l0.95".unixCmd("done".postln, false);

"/Users/pvh/cdpr7/_cdp/_cdprogs/modify loudness 3 /Users/pvh/src/Projects/timeline/experiment1/audio/fuktest1.wav /Users/pvh/src/Projects/timeline/experiment1/audio/fuktest1_new49.wav -l0.95".unixCmd("done".postln, false);
