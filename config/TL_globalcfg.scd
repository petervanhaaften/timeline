//this needs to run before anything else!! why is it not???

//
// (
// Platform.case(
// 	\osx,       {
// 		Server.default.options.inDevice_("JackRouter");
// 	Server.default.options.outDevice_("JackRouter"); },
// 	\linux,     {  },
// );
// s = Server.default;
// s.options.sampleRate = 48000;
// s.boot;
// );
//

//TIMELINE GLOBAL SCLANG CONFIG
// # flag for timeline src directory
~srcdir = Platform.userHomeDir +/+ "src/timeline/";

// # flag for timeline operator speech
~operatorwav = ~srcdir +/+ "audio/speakoneword.wav";
~operatorclosewav = ~srcdir +/+ "audio/08_thankyouforcalling.wav";
// # flag for timeline operator error msg
~operatorerrorwav = ~srcdir +/+ "audio/sorry.wav";
// # flag for timeline goodbye msg
//~goodbyewav = ~srcdir +/+ "audio/goodbye.wav";
~goodbyewav = ~srcdir +/+ "audio/08_thankyouforcalling.wav";
// # flag for simplelogic location
~simplelogic = ~srcdir +/+ "/synths/TL_recorder_logic.scd";
// # flag for simplerec location
~simplerec = ~srcdir +/+ "/synths/TL_recorder.scd";
// # flag for gransyn1 location
~gransyn1 = ~srcdir +/+ "/synths/pvh.gransyn1_4.scd";
// # flag for killscore location. --killscore really needed??
~killscore = ~srcdir +/+ "/scenes/TL_kill_score.scd";
// # flag for timescore location.
//~timescore = ~srcdir +/+ "TL_score_scene1.scd";



