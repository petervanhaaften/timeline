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
			//stop recording
			~rec.free;
			~trigger.free;
			//free OSCdef
			OSCdef.freeAll;
		})
	});
}, '/tr', s.addr)
}
)