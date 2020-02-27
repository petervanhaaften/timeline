OSCFunc.trace(true); // Turn posting on
OSCFunc.trace(false); // Turn posting off

s = Server.default
s.options.sampleRate = 44100;
s.boot;

(
// MASTER HOST CONFIG
// # flag for timeline src directory
// - macbook location
~srcdir = Platform.userHomeDir +/+ "src/Projects/timeline/";
// - debian location
//~srcdir = Platform.userHomeDir +/+ "src/timeline/";

Require(~srcdir +/+ "/config/TL_globalcfg.scd");
Require(~srcdir +/+ "/scenes/scene1/TL_localcfg_scene1.scd");

//calling scenes, on receipt of OSC message
q = OSCFunc({
	arg msg, time, addr, recvPort; [msg, time, addr, recvPort].postln;
	(msg[1] == 1).if({
		// /timeline/scene 1
		"/timeline/scene 1".postln;
		Require("/Users/pvh/src/Projects/timeline/scenes/scene1/TL_callflow_scene1.scd");
	});
	(msg[1] == 2).if({
		// /timeline/scene/2
		"/timeline/scene 2".postln;
	});
	(msg[1] == 3).if({
		// /timeline/scene/3
		"/timeline/scene 3".postln;
	});
}, '/timeline/scene')
);s
)

b.play;