s.boot;
// { SinOsc.ar(440, 0, 0.5) }.play;

Server.local.waitForBoot({
		{ SinOsc.ar(480)*0.1 }.play;
	});


