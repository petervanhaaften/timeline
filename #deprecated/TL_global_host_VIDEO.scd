//OSCFunc.trace(true); // Turn posting on
//OSCFunc.trace(false); // Turn posting off

//building telephone filter
//{SinOsc.ar(440,0,0.5).round(2**(-8))}.scope //bit reduction to 8 bit signal

/*
Platform.case(
    \osx,       { "OSX".postln },
    \linux,     { "Linux".postln },
);
*/

(
(
Platform.case(
    \osx,       {
		Server.default.options.inDevice_("JackRouter");
		Server.default.options.outDevice_("JackRouter"); },
    \linux,     {  },
    );
s = Server.default;
s.options.sampleRate = 48000;
s.boot;
);

//things to do on platform switch
// TL_recorder_logic:
// - modify sox location in both compressor and normalize processes


(

~globalscenectl = Routine {
// MASTER HOST CONFIG
// # flag for timeline src directory
~srcdir = Platform.userHomeDir +/+ "src/timeline/";

// call external config files
Require(~srcdir +/+ "/config/TL_globalcfg.scd");
Require(~srcdir +/+ "/scenes/scene1/TL_localcfg_scene1_video.scd");

//calling scenes, on receipt of OSC message
~globalosc_scene = OSCFunc({
	arg msg, time, addr, recvPort; [msg, time, addr, recvPort].postln;
	(msg[1] == 9999).if({
		// HANGUP, KILL running audio
		"/timeline/scene 9999 << kill audio >>".postln;
		CmdPeriod.run;
		"hangup command complete, cleaning up routine".postln;
		~globalscenectl.reset;
		~globalscenectl.play;
		"ready for incoming call".postln;
	});
	(msg[1] == 1).if({
		// /timeline/scene 1
		"/timeline/scene 1 << run scene 1 >>".postln;
		Require(~srcdir +/+ "/scenes/scene1/TL_callflow_scene1_video.scd");
		"loaded scene 1".postln;
		~callflow.reset;
		~callflow.play;
	});
	(msg[1] == 2).if({
		// /timeline/scene/2
		Require(~srcdir +/+ "/scenes/scene1/TL_callflow_scene1_video.scd");
		"/timeline/scene 2".postln;
		~playscore.reset;
		~playscore.play;
	});
	(msg[1] == 3).if({
		// /timeline/scene/3
		"/timeline/scene 3".postln;
	});
}, '/timeline/scene')
}.play;
)
)
//b.play;
//~playscore.reset;
//~playscore.play;

