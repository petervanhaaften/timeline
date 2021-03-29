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
	"// FINAL PROCESSING".postln;
	//turn off clcoks
	v.stop;
	t.stop;
	w.stop;
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
//create voicerecorder
~rec = Synth(\voiceRecorder, [\bufnum, b.bufnum, \pos, 0, \t_trig, 0]);
//trigger is always running
~trigger = Synth(\trigger);
~recpause = 0;

//sorry.wav var trig
k = 0;
//clock1 time, record time
d = 0;
//clock2 time, paused time
q = 0;
//clock3 time, paused time
r = 0;
//clock1, record
t = Task({ { d = d + 1; 1.wait;}.loop });
//clock2, pause
v = Task({ { q = q + 1; "$ pause klok : ".post; q.postln; 1.wait; }.loop });
//clock3, pause time before error message
w = Task({ { r = r + 1; "$ ERROR klok : ".post; r.postln; 1.wait; }.loop });
//trig for min record time pause length
h = 1;
OSCdef(\trigger, {
	arg msg;
	//constantly triggered on id 9998 once per-second during recording
	(msg[2] == 9998).if({
		//if < min record play sorry.wav
		//if paused or no record for more than 8 seconds then
			if((((d <= ~minrecordtime)&&(~recpause == 0;))&&(r >= 5))&&(h == 1)&&(k == 0), {
				//"minrecordtime".post; ~minrecordtime.postln;
				~errorplayback.reset;
				//"rVal : ".post; r.postln;
				//"hVal : ".post; h.postln;
				//"kVal : ".post; k.postln;
				//var k set to 1 to indicate currently going through sorry process
				//k = 1;
				w.stop;
				"shoudplaynow".postln;
				~errorplayback.play;
				"shoudHAVEplaynow".postln;
				h = 0;
				d = 0;
				q = 0;
				r = 0;
				//"dval".post; d.postln;
				~recpause == 1;
				"LoopEnd".postln;

			};
		);
		//if current time >= ~maxrecordtime, then stop & run ~finalprocess

		(d >= ~maxrecordtime).if({
			t.play;
			"// ~maxrecordtime threshold reached".postln;
			~finalprocess.play;
		});
		//if (t > ~minrecordtime) && (~minrecordtimeBreak < 5) then STILL ALLOW RECORDING POTENTIAL
			if((d >= ~minrecordtime)&&(~recpause == 0;)&&(k == 0),
				//minimum recording time reached
				//only v.play if recording is paused.....
				{ v.start; "minrecordtime".post; ~minrecordtime.postln; "dVal : ".post; d.postln; }
		);
		//record pause longer than ~minrecordtimeBreak, then process recorded audio
		if(((q >= ~minrecordtimeBreak)&&(~recpause == 0;))&&(d >= ~minrecordtime),
				{ "// ~minrecordtimeBreak threshold reached".postln; v.stop; ~finalprocess.play; };
		);
	});
	//if signal > threshold (id1000), trigger record
	(msg[2] == 1000).if({
				~recpause = 1;
				k = 0;
				h = 1;
				r = 0;
				q =0;
				//start < minrecordtime pause counter before error
				w.play;
				v.stop;
				//start recording clock, on begin record
				t.start;
				//start recorder
				~rec.set(\pos, ~position, \t_trig, 1);
	});
	//if signal < threshold (id1001), ask synth to send position in buffer, pause record
	(msg[2] == 1001).if({
		~recpause = 0;
		k = 0;
		h = 1;
		r = 0;
		q =0;
		v.stop;
		//pause recording clock, on pause record
		t.pause;
		"dval".post; d.postln;
		//pause recorder, send time position
		~rec.set(\t_sendTime, 1);
	});
	//receive position from buffer
	(msg[2] == 9999).if({
		//receive position from buffer
		~position = msg[3];
	});
}, '/tr', s.addr)
};
);


