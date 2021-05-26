/*
A global scene offline recording script.
Uses .recordNRT to offline bounce the recorded audience buffer.

I need to make sure that this is actually playing the same scene as TL_callflow_sceneX.scd

I think some part of this needs to be moved from TL_callfow_scene0, or I need to somehow
feed variables out of TL_callflow_sceneX into this script !
*/

(
var options;

// create new score
~score = Score.new;

// create a Buffer object for adding to the Score
~sndbuf = Buffer.new;
//~sndbuf = b;

// for NRT rendering, the buffer messages must be added to the Score
//~score.add([0, ~sndbuf.allocReadMsg(thisProcess.nowExecutingPath.dirname +/+ "voice4.wav")]);
~score.add([0, ~sndbuf.allocReadMsg(~srcdir +/+ "/audio/" ++ ~instancenum ++ "bufferrec1_compressed.wav")]);
//~score.add([0, ~sndbuf]);

//call synthdef
Require("gransyn.scd");

// call external score
Require(thisProcess.nowExecutingPath.dirname +/+ "nrtscore/score" ++ ~sceneChoice ++ ".scd");
c = "THE SELECTED NRTscore" ++ ~sceneChoice ++ ".scd";
c.postln;

//~pattern2 = ~pattern;
~pattern = ~pattern.asScore(~sceneDuration);

// ~score.add(~pattern);
~pattern.score.do{|e| ~score.add(e)};

// setup concat
a = "sox" + "/home/asterisk/partyline-snd/scene0_stereo.wav" + "/home/asterisk/partyline-snd/holdbeep.wav" + "/home/asterisk/partyline-voicerec/" ++ ~wavPin ++ "_stereo.wav" +"/home/asterisk/partyline-snd/holdbeep2.wav" + "/home/asterisk/partyline-screc/" ++ ~wavPin ++ "_normalised.wav" + "/home/asterisk/partyline-snd/goodbye0.wav" + "/home/asterisk/partyline-concat/" ++ ~wavPin ++ "_concat.wav";

// setup screc output normalization
f = "sox" + "/home/asterisk/partyline-screc/" ++ ~wavPin ++ ".wav" + "/home/asterisk/partyline-screc/" ++ ~wavPin ++ "_normalised.wav --norm=-5";

//setup normalize and concat routine.
g = Routine {
	f.unixCmd("done : normalised screc".postln;, false);
	2.wait;
	a.unixCmd("done : concat final output".postln, false);
};

// the ServerOptions for rendering the soundfile
options = ServerOptions.new.numOutputBusChannels_(2);

~score.recordNRT(
    // outputFilePath: thisProcess.nowExecutingPath.dirname +/+ "testnew3.wav".standardizePath,
	outputFilePath: "/home/asterisk/partyline-screc/" ++ ~wavPin ++ ".wav".standardizePath,
    headerFormat: "wav",
    sampleFormat: "int24",
	sampleRate: 48000,
    options: options,
    duration: ~sceneDuration,
    action: {
		g.play;
	};
);

//~sndbuf = b;
//~sndbuf = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "voice4.wav");
~sndbuf = Buffer.read(s, ~srcdir +/+ "/audio/" ++ ~instancenum ++ "bufferrec1_compressed.wav");
//Require(thisProcess.nowExecutingPath.dirname +/+ "newscore/score" ++ ~currentScene ++ ".scd");
Require(thisProcess.nowExecutingPath.dirname +/+ "nrtscore/score" ++ ~sceneChoice ++ ".scd");




//5.wait;
//a.unixCmd("done : concat final output" + "/home/asterisk/partyline-concat/" ++ ~wavPin ++ "_concat.wav".postln, false);
)

// should be normalizing at end of recordNRT not concatenating