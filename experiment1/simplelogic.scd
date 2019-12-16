(
Routine {
~maxtime = 5;
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
		//"Requesting position from server".postln;
	});
	(msg[2] == 9999).if({
		//receive position from buffer
		~position = msg[3];
		"paused, waiting at ".post;
		~position.postln;

		//calculating amount of time recorded so far
		~postime = (~position / 48000);
		"position calculation = ".post;
		~postime.postln;

		//if amount of recorded time is more than maxtime,
		//stop recording
		(~postime > ~maxtime).if({
			"OVER MAX TIME".postln;
		})
	});
}, '/tr', s.addr)
}
)