
// set up Server to use a different executable
Server.program = "/usr/local/bin/scsynth";

// same for Score
Score.program = Server.program;

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

~srcdir = Platform.userHomeDir +/+ "src/timeline/";

// supercollider osc receive port  from asterisk
~net = NetAddr.new("127.0.0.1", 57122);
// set osc output port to asterisk
~asterisk = NetAddr.new("127.0.0.1", 59663);

Require(~srcdir +/+ "/Partyline_global_host5_auto.scd/");