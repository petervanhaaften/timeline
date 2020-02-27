OSCFunc.trace(true); // Turn posting on
OSCFunc.trace(false); // Turn posting off

(
q = OSCFunc({
	arg msg, time, addr, recvPort; [msg, time, addr, recvPort].postln;
	(msg[1] == 1).if({
		// /timeline/scene 1
		"/timeline/scene 1".postln;
		Require("/Users/pvh/src/Projects/timeline/timescriptA1_16.scd");
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
);
)
