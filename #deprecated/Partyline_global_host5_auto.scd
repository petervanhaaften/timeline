//OSCFunc.trace(true); // Turn posting on
//OSCFunc.trace(false); // Turn posting off

(

(
////////////////////////////
// GLOBAL VARIABLES SETUP //
////////////////////////////

//fill callerChan with something to avoid crash
~callerChan = "blank";

//
//things to do on platform switch45
// TL_recorder_logic:
// - modify sox location in both compressor and normalize processes

(
~globalscenectl = Routine {

//boot server first
	/*
(
Platform.case(
    \osx,       {
				Server.default.options.inDevice_("JackRouter");
				Server.default.options.outDevice_("JackRouter");
			},
    \linux,     {
				Server.default.options.numOutputBusChannels = 10;
				Server.default.options.numInputBusChannels = 10;
				s.postln;
			},
    );
s = Server.default;
s.options.sampleRate = 48000;
s.boot;
);
*/
2.wait;
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
0.5.wait;
Require(~timescore);
Require(~killscore);
//gotta wait or the 9999 orutine in timescore will create a feedback loop with the code that follows
0.5.wait;
//setup net address
	/*
~net = NetAddr.new("127.0.0.1", 57120);
~asterisk = NetAddr.new("127.0.0.1", 59663);
	*/

//receiving chan name from asterisk
~callerChanreceive = OSCFunc({
	arg msg, time, addr, recvPort;
	~callerChan =  "asterisk -x 'channel request hangup"+msg[1]+"'";
	//"Caller requests hangup on channel : ".post; ~callerChan.postln;
}, '/timeline/channel');


//~channel_connect = OSCFunc({
//	arg msg, time, addr, recvPort;
//	// ~callerChan =  "asterisk -x 'channel request connect"+msg[1]+"'";
//	~callerChan =  "asterisk -x 'channel request connect"+msg[1]+"'";
//	//"Caller requests connection on channel 2: ".post;
//	~callerChan.postln;
//}, '/timeline/scene');

//calling scenes, on receipt of OSC message
~globalosc_scene = OSCFunc({
	arg msg, time, addr, recvPort; [msg, time, addr, recvPort].postln;
	(msg[1] == 9999).if({
		// HANGUP, KILL running audio
		CmdPeriod.run;
		"/timeline/scene 9999 << kill audio >>".postln;
		//terminate caller channel via asterisk unixCmd
		~callerChan.unixCmd;
		"hangup command complete, cleaning up routine".postln;
		~globalscenectl.reset;
		~globalscenectl.play;
		"ready for incoming call".postln;
	});
	(msg[1] == 0).if({
		// /timeline/scene 0
		//delay 31
		"/timeline/scene 0 << run scene 0s >>".postln;
		"caller jack channel is:".postln;
		~callerJackChan = msg[2];
		~callerJackChan.postln;
		Require(~srcdir +/+ "/scenes/scene0/TL_localcfg_scene0.scd");
		Require(~srcdir +/+ "/scenes/scene0/TL_callflow_scene0.scd");
		"loaded scene 0".postln;
		~callflow.reset;
		~callflow.play;
	});
	(msg[1] == 1).if({
		// /timeline/scene/1
		///delay 52sec
		"/timeline/scene 1 << run scene 1 >>".postln;
		"caller jack channel is:".postln;
		~callerJackChan = msg[2];
		~callerJackChan.postln;
		Require(~srcdir +/+ "/scenes/scene0/TL_localcfg_scene0.scd");
		Require(~srcdir +/+ "/scenes/scene0/TL_callflow_scene0.scd");
		"loaded scene 1".postln;
		//~callflow.reset;
		~callflow.play;
	});
	(msg[1] == 2).if({
		// /timeline/scene/2
			//delay 53sec
		"/timeline/scene 2 << run scene 2 >>".postln;
		"caller jack channel is:".postln;
		~callerJackChan = msg[2];
		~callerJackChan.postln;
		Require(~srcdir +/+ "/scenes/scene0/TL_localcfg_scene0.scd");
		Require(~srcdir +/+ "/scenes/scene0/TL_callflow_scene0.scd");
		"loaded scene2".postln;
		~callflow.reset;
		~callflow.play;
	});
	(msg[1] == 3).if({
		// /timeline/scene/2
		//delay 51
		"/timeline/scene 3 << run scene 3 >>".postln;
		"caller jack channel is:".postln;
		~callerJackChan = msg[2];
		~callerJackChan.postln;
		Require(~srcdir +/+ "/scenes/scene0/TL_localcfg_scene0.scd");
		Require(~srcdir +/+ "/scenes/scene0/TL_callflow_scene0.scd");
		"loaded scene3".postln;
		~callflow.reset;
		~callflow.play;
	});

	(msg[1] == 4).if({
		// /timeline/scene/2
		//delay 55
		"/timeline/scene 4 << run scene 4 >>".postln;
		"caller jack channel is:".postln;
		~callerJackChan = msg[2];
		~callerJackChan.postln;
		Require(~srcdir +/+ "/scenes/scene0/TL_localcfg_scene0.scd");
		Require(~srcdir +/+ "/scenes/scene0/TL_callflow_scene0.scd");
		"loaded scene4".postln;
		~callflow.reset;
		~callflow.play;
	});
	(msg[1] == 5).if({
		// /timeline/scene/2
		//delay 54
		"/timeline/scene 5 << run scene 5 >>".postln;
		"caller jack channel is:".postln;
		~callerJackChan = msg[2];
		~callerJackChan.postln;
		Require(~srcdir +/+ "/scenes/scene0/TL_localcfg_scene0.scd");
		Require(~srcdir +/+ "/scenes/scene0/TL_callflow_scene0.scd");
		"loaded scene5".postln;
		~callflow.reset;
		~callflow.play;
	});
}, '/timeline/scene')
}.play;
)
)
)