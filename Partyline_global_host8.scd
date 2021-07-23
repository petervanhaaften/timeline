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

	// //receiving chan name from asterisk
	// ~callerChanreceive = OSCFunc({
	// 	arg msg, time, addr, recvPort;
	// 	//~callerChan =  "asterisk -x 'channel request hangup"+msg[1]+"'";
	//
	// 	//retry for redirect current jack channel back to asterisk dialplan
	//
	// 	//asterisk manual channel redirect usage:
	// 	//channel redirect <channel> <[[context,]exten,]priority>
	// 	//~callerChan = "asterisk -x 'channel redirect Local/1@scenes-00000004;2 scenes-outro,1,1'";
	//
	// 	//so end start osc message with AsteriskChannel as an argument, and
	// 	//scene as an argument, and feed those into ~callerChan, which will play at end of scene
	// 	//message arrives in format: msg0_/timeline/scene msg1_scene msg2_telephoneNum msg3_AsteriskChan msg4_randomString
	//
	// 	//for future, when multi scene scenes-outro exists
	// 	//~callerChan = "asterisk -x 'channel redirect"+msg[3]+"scenes-outro,"+msg[1]+",1'";
	// 	~callerChan = "asterisk -x 'channel redirect"+msg[3]+"scenes-outro,1,1'";
	// 	"received asterisk message is:".postln;
	// 	~callerChan.postln;
	// 	//"Caller requests hangup on channel : ".post; ~callerChan.postln;
	// }, '/timeline/scene');
	//

	//~redirectChannel.postln;

	~redirectChannel = {
	//"asterisk -x 'channel redirect"+~asteriskChannel+"scenes-outro,1,1'".return;
	//
    //-- Executing [1@scenes-outro:1] playback("Local/0@scenes-00000004;2", "PARTYLINE/goodbye1")
	arg asteriskChan = "LOCAL/hey";
	//var return = "asterisk -x 'channel redirect"+asteriskChan+"scenes-outro,3,1'";
		var return = "asterisk -x 'channel redirect"+asteriskChan+"scenes-outro,"++12.rand++",1'";
	return;
	//~asteriskChannel.postln;
	};

	//calling scenes, on receipt of OSC message
	~globalosc_scene = OSCFunc({
		arg msg, time, addr, recvPort; [msg, time, addr, recvPort].postln;
		//"received message #0, address:".postln;
		//msg[0].postln;
		"received message #1, scene: ".post;
		~sceneChoice = msg[1];
		~sceneChoice.postln;
		"received message #2, telephoneNum: ".post;
		~telephoneNum = msg[2];
		~telephoneNum.postln;
		"received message #3 asteriskChannel: ".post;
		~asteriskChannel = msg[3];
		~asteriskChannel.postln;
		"received message #4, wavPin: ".post;
		~wavPin = msg[4];
		~wavPin.postln;

		(msg[1] == 9999).if({
			// HANGUP, KILL running audio
			"/timeline/scene 9999 << kill audio >>".postln;
			CmdPeriod.run;
			//terminate caller channel via asterisk unixCmd
			//~callerChan.unixCmd;
			//need to call function to fill variable, first
			~returnDialplan = ~redirectChannel.value(~asteriskChannel);
			~returnDialplan.unixCmd;
			"this is the return dialplan variable value!!!! : ".postln;
			~returnDialplan.postln;
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
			"received asterisk message is:".postln;
			~callerChan.postln;

			Require(~srcdir +/+ "/scenes/scene0/TL_localcfg_scene0.scd");
			//Require(~srcdir +/+ "/scenes/scene0/TL_callflow_scene0.scd");
			//Require(~srcdir +/+ "/scenes/TL_playback.scd");
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

			Require(~srcdir +/+ "/scenes/scene1/TL_localcfg_scene1.scd");
			//Require(~srcdir +/+ "/scenes/scene2/TL_callflow_scene2.scd");
			//Require(~srcdir +/+ "/scenes/TL_playback.scd");

			"loaded scene 1".postln;
			~callflow.reset;
			~callflow.play;
		});
		(msg[1] == 2).if({
			// /timeline/scene/2
			//delay 53sec
			"/timeline/scene 2 << run scene 2 >>".postln;
			"caller jack channel is:".postln;
			~callerJackChan = msg[2];
			~callerJackChan.postln;

			Require(~srcdir +/+ "/scenes/scene2/TL_localcfg_scene2.scd");
			//Require(~srcdir +/+ "/scenes/scene2/TL_callflow_scene2.scd");
			//Require(~srcdir +/+ "/scenes/TL_playback.scd");

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

			Require(~srcdir +/+ "/scenes/scene3/TL_localcfg_scene3.scd");
			//Require(~srcdir +/+ "/scenes/scene3/TL_callflow_scene3.scd");
			//Require(~srcdir +/+ "/scenes/TL_playback.scd");

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

			Require(~srcdir +/+ "/scenes/scene4/TL_localcfg_scene4.scd");
			//Require(~srcdir +/+ "/scenes/scene4/TL_callflow_scene4.scd");
			//Require(~srcdir +/+ "/scenes/TL_playback.scd");

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

			Require(~srcdir +/+ "/scenes/scene5/TL_localcfg_scene5.scd");
			//Require(~srcdir +/+ "/scenes/scene5/TL_callflow_scene5.scd");
			//Require(~srcdir +/+ "/scenes/TL_playback.scd");

			"loaded scene5".postln;
			~callflow.reset;
			~callflow.play;
		});
		(msg[1] == 6).if({
			// /timeline/scene/2
			//delay 54
			"/timeline/scene 5 << run scene 6 >>".postln;
			"caller jack channel is:".postln;
			~callerJackChan = msg[2];
			~callerJackChan.postln;

			Require(~srcdir +/+ "/scenes/scene6/TL_localcfg_scene6.scd");
			//Require(~srcdir +/+ "/scenes/scene5/TL_callflow_scene5.scd");
			//Require(~srcdir +/+ "/scenes/TL_playback.scd");

			"loaded scene5".postln;
			~callflow.reset;
			~callflow.play;
		});
		(msg[1] == 7).if({
			// /timeline/scene/2
			//delay 54
			"/timeline/scene 5 << run scene 7 >>".postln;
			"caller jack channel is:".postln;
			~callerJackChan = msg[2];
			~callerJackChan.postln;

			Require(~srcdir +/+ "/scenes/scene7/TL_localcfg_scene7.scd");
			//Require(~srcdir +/+ "/scenes/scene5/TL_callflow_scene5.scd");
			//Require(~srcdir +/+ "/scenes/TL_playback.scd");

			"loaded scene5".postln;
			~callflow.reset;
			~callflow.play;
		});
		(msg[1] == 8).if({
			// /timeline/scene/2
			//delay 54
			"/timeline/scene 5 << run scene 8 >>".postln;
			"caller jack channel is:".postln;
			~callerJackChan = msg[2];
			~callerJackChan.postln;

			Require(~srcdir +/+ "/scenes/scene8/TL_localcfg_scene8.scd");
			//Require(~srcdir +/+ "/scenes/scene5/TL_callflow_scene5.scd");
			//Require(~srcdir +/+ "/scenes/TL_playback.scd");

			"loaded scene5".postln;
			~callflow.reset;
			~callflow.play;
		});
		(msg[1] == 9).if({
			// /timeline/scene/2
			//delay 54
			"/timeline/scene 5 << run scene 9 >>".postln;
			"caller jack channel is:".postln;
			~callerJackChan = msg[2];
			~callerJackChan.postln;

			Require(~srcdir +/+ "/scenes/scene9/TL_localcfg_scene9.scd");
			//Require(~srcdir +/+ "/scenes/scene5/TL_callflow_scene5.scd");
			//Require(~srcdir +/+ "/scenes/TL_playback.scd");

			"loaded scene5".postln;
			~callflow.reset;
			~callflow.play;
		});
		(msg[1] == 10).if({
			// /timeline/scene/2
			//delay 54
			"/timeline/scene 5 << run scene 10 >>".postln;
			"caller jack channel is:".postln;
			~callerJackChan = msg[2];
			~callerJackChan.postln;

			Require(~srcdir +/+ "/scenes/scene10/TL_localcfg_scene10.scd");
			//Require(~srcdir +/+ "/scenes/scene5/TL_callflow_scene5.scd");
			//Require(~srcdir +/+ "/scenes/TL_playback.scd");

			"loaded scene5".postln;
			~callflow.reset;
			~callflow.play;
		});
	}, '/timeline/scene')
}.play;
)
)
)
//
// (
// f = {
// 	//"asterisk -x 'channel redirect"+~asteriskChannel+"scenes-outro,1,1'".return;
// 	arg asteriskChan = "LOCAL/hey";
// 	var return = "asterisk -x 'channel redirect"+asteriskChan+"scenes-outro,1,1'";
// 	return;
// 	//~asteriskChannel.postln;
// }
// )
// f.value(a = "who");
//
