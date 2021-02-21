/////////////////////////////
//CORE SERVER INTIALIZATION
/////////////////////////////

// set up Server to use a different executable
//Server.program = "/usr/local/bin/scsynth";

// same for Score
//Score.program = Server.program;

Server.default = Server.new(\sc2, NetAddr("localhost", 57111), o);
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


//////////////////////////
//INSTRUMENT BOOT ROUTINE
//////////////////////////

(
s.doWhenBooted{

~boot = Routine {
		//osc stuff
		// supercollider osc receive port  from asterisk
		//~net = NetAddr.new("127.0.0.1", 57121);
		~net = NetAddr.langPort;
		// set osc output port to asterisk
		~asterisk = NetAddr.new("127.0.0.1", 59663);

		//2.wait;
		"loaded global host auto".postln;
		// MASTER HOST CONFIG
		// # flag for timeline src directory
		~srcdir = Platform.userHomeDir +/+ "src/timeline/";

		// call external config files
		Require(~srcdir +/+ "/config/TL_globalcfg.scd");

		//GLOBAL REQUIREMENTS
		//note: with this in place can I cut requires from elsewhere??
		//the synthesizer for this score
		Require(~gransyn1);

		//local cfg
		Require(~srcdir +/+ "/scenes/scene0/TL_localcfg_scene0.scd");
		//voice rec synthdef -- needs buffer preloaded!!
		Require(~simplerec);
		//voice rec logic, interacts with synthdef
		Require(~simplelogic);
		//if called during scene, it will trigger 9999 hangup, so do before
		//0.5.wait;
		Require(~timescore);
		Require(~killscore);


		Require(~srcdir +/+ "/Partyline_global_host7_auto.scd/");

		"INSTANCE 2 : booted".postln;
		"LangPort = ".post;
		NetAddr.langPort.postln;
	}.play;
}
);