(
s = Server.new(\sc2, NetAddr("localhost", 57111), o);
s.options.numInputBusChannels = 1;
s.options.numOutputBusChannels = 1;
s.options.sampleRate = 48000;
s.options.device = "scpartyline_chan2";

//start with jack, but nothing connected
"SC_JACK_DEFAULT_INPUTS".setenv(
);
"SC_JACK_DEFAULT_OUTPUTS".setenv(
);

s.boot;
)

(
s.doWhenBooted{

~boot = Routine {
		//osc stuff
		// supercollider osc receive port  from asterisk
		~net = NetAddr.new("127.0.0.1", 57121);

		"TestScript : loaded".postln;
		"LangPort = ".post;
		NetAddr.langPort.postln;

		~globalosc_scene = OSCFunc({
			arg msg, time, addr, recvPort; [msg, time, addr, recvPort].postln;
			recvPort = ~net;
			(msg[1] == 0).if({
				// /timeline/scene 0
				//delay 31
				"/timeline/scene 0 << run scene 0s >>".postln;
				{ SinOsc.ar(200, 0, 0.5) }.play;

			});
			(msg[1] == 1).if({
				// /timeline/scene/1
				///delay 52sec
				"/timeline/scene 1 << run scene 1 >>".postln;
				{ SinOsc.ar(200, 0, 0.5) }.play;

			});
			(msg[1] == 2).if({
				// /timeline/scene/2
				//delay 53sec
				"/timeline/scene 2 << run scene 2 >>".postln;

			});
		}, '/timeline/scene')
	}.play;
};
);
);