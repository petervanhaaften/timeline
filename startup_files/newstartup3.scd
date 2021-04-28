/////////////////////////////
//CORE SERVER INTIALIZATION
/////////////////////////////

// set up Server to use a different executable
//Server.program = "/usr/local/bin/scsynth";

// same for Score
//Score.program = Sedrver.program;

Server.default = Server.new(\sc3, NetAddr("localhost", 57112), o);
s.options.numInputBusChannels = 1;
s.options.numOutputBusChannels = 1;
s.options.sampleRate = 48000;
s.options.device = "scpartyline_chan3";

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
		//~net = NetAddr.new("127.0.0.1", 57120);
		//~net = NetAddr.langPort;

		~net = NetAddr("localhost", NetAddr.langPort);
		// set osc output port to asterisk
	    ~asterisk = NetAddr.new("127.0.0.1", 59663);
	
    	// define instance number, used for buffer file naming etc
	    ~instancenum = "3_";
	    
	    "INSTANCE".post;
	    ~instancenum.post;
	    "booted".postln;
	
		// MASTER HOST CONFIG
		// # flag for timeline src directory
		~srcdir = Platform.userHomeDir +/+ "src/timeline/";
		// call external config files
		Require(~srcdir +/+ "/config/TL_globalcfg.scd");

		Require(~srcdir +/+ "/Partyline_global_host8.scd/");

	    Require(~tlcallflowglobal);
		"LangPort = ".post;
		NetAddr.langPort.postln;
	}.play;
}
);
