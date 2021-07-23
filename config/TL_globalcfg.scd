//TIMELINE GLOBAL SCLANG CONFIG
// # flag for timeline src directory
//~srcdir = Platform.userHomeDir +/+ "src/timeline/";
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
~gransyn1 = ~srcdir +/+ "/synths/pvh.gransyn1_10_offline.scd";
// # flag for killscore location. --killscore really needed??
~killscore = ~srcdir +/+ "/scenes/TL_kill_score.scd";
// # flag for timescore location.
//~timescore = ~srcdir +/+ "TL_score_scene1.scd";
// # flag for TL_playback [ formerlly 'main.scd' ]
~tlplayback = ~srcdir +/+ "/scenes/TL_playback.scd";
// # flag for TL_callflow_global
~tlcallflowglobal = ~srcdir +/+ "/scenes/TL_callflow_global.scd";

//
//CALLIONG VARIOUS NEEDED SYNTHS AND LOGIC
//

// call external config files
//Require(~srcdir +/+ "/config/TL_globalcfg.scd");

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
//Require(~timescore);
Require(~killscore);

Require(~srcdir +/+ "/Partyline_global_host8.scd/");