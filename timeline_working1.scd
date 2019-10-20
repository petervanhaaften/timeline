s.boot;
// { SinOsc.ar(440, 0, 0.5) }.play;

Server.local.waitForBoot({
		{ SinOsc.ar(2200)*0.1 }.play;
	});