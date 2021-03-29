//EXAMPLE #1
//a working score playback
(
s.boot;
//currently my synthdef 'gransyn' in gransyn.scd receives a buffer name in 'soundBuf' variable
//which is received from the score in score.scd ("\soundBuf, b.bufnum,").
//in my next example, i need to understand how to move this buffer to the NRT server
b = Buffer.alloc(s, 100 * s.sampleRate);
b = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "voice.wav");
Require("gransyn.scd");
Require("score.scd");
~score.play;
)

(
score = Score.new;
sndbuf = Buffer.new;
score.add([0, sndbuf.allocReadMsg(thisProcess.nowExecutingPath.dirname +/+ "voice.wav"));
)

//EXAMPLE #2
//not working: how to record score in non-realtime, and also print valid score file that can be used repeatedly with new audio buffers?
(
//i need to understand how to call my gransyn synthdef on the NRT server
Require("gransyn.scd");
Require("score.scd");
z = ~score.asScore(17.0);

// trying to load my buffer onto the NRT server
//i need to understand out how to call this buffer from my 'gransyn' synthdef in gransyn.scd
z = z.add([0.0, [\b_allocRead, 1, thisProcess.nowExecutingPath.dirname +/+ "voice.wav"]]);
z.score.postcs;

//trying to render the audio
z.recordNRT(
    outputFilePath: thisProcess.nowExecutingPath.dirname +/+ "score-recordnrt-test1.wav".standardizePath,
    headerFormat: "wav",
    sampleFormat: "int16",
    options: s.options,
    duration: 15,
    action: { "done".postln }
);

//trying to print out a valid score file
f = File(thisProcess.nowExecutingPath.dirname +/+ "score-print-test1","w");
f.write(z.asCompileString);
f.close;
)


//EXAMPLE #3
//CTK attempt
//the synthdef
(
Require("gransyn.scd");
// the score
//~score = CtkScore.new;
Require("score.scd");
// the buffer
b = CtkBuffer.playbuf(thisProcess.nowExecutingPath.dirname +/+ "voice.wav");

// add the buffer to the score
~score = CtkScore;
~score.add(b);
)

~score.play
~score.recordNRT(
    outputFilePath: thisProcess.nowExecutingPath.dirname +/+ "score-recordnrt-test1.wav".standardizePath,
    headerFormat: "wav",
    sampleFormat: "int16",
    options: s.options,
    duration: 15,
    action: { "done".postln }
);
)
~score.add(~peternew);


~sops = ServerOptions.new.numOutputBusChannels = 2;


~score.write("/Users/pvh/emptyNRT.aiff", options: ~sops);



///////////
///////////
///////////

// example from :
// https://sc-users.bham.ac.narkive.com/Q1N4Si0H/nrt-mode-and-soundfile-buffers
(
var now = 0.0, sops;

a = CtkSynthDef(\sampscore,{| incr = 1.0, buffer |
var killer = Line.kr(1, 1, 2.0, doneAction: 2);
Out.ar(0,
PlayBuf.ar( 2, buffer, incr, Impulse.kr(0),0,0 );
)
});

// the buffer
b = CtkBuffer.playbuf("shortsound.aiff");
// the score
z = CtkScore;
// add the buffer to the score
z.add(b);

4.do({
// create a new instance of the prototype in the 'a' var... add it to
the score
z.add(a.new(now, b.duration).buffer_(b).incr_(rrand(0.5,1.0)))
now = now + 0.5;
})

sops = ServerOptions.new.numOutputBusChannels = 2; // stereo output

z.write("emptyNRT.aiff", options: sops)

)

///////////////////////////
//FROM CHAPTER18CODE.SCD
//IN THE SUPERCOLLIDER BOOK
///////////////////////////

/* Figure 18.5 */
(
var score, soundBuf, starttime, synth, options;
// open a file for writing raw OSC data to
f = File("~/test.osc".standardizePath,"w");
// the synthesizer
Require("gransyn.scd");
// ~ctksynth

// the score
//~score = CtkScore.new;
Require("score.scd");
score = Score.new;

p = ~music.asScore(17.0);

//score.add(~score);
// create a Buffer object for adding to the Score
//sndbuf = Buffer.new;
soundBuf = Buffer.new;

p = ~music.asScore(17.0);
p.score.postcs;

//write out file
f.write(p.asCompileString);
f.close;

// for NRT rendering, the buffer messages must be added to the Score
//score.add([0, sndbuf.allocReadMsg("/Users/pvh/voice.wav")]);
score.add([0, soundBuf.allocReadMsg("/Users/pvh/voice.wav")]);
//score.add(~music.asScore(17.0));
//score.add(p.asCompileString);
// the dummy command. The soundfile will be 11 seconds long
//score.add([11, 0]);

score.sort;

// the ServerOptions for rendering the soundfile
options = ServerOptions.new.numOutputBusChannels_(2);

// write the soundfile out to disk
score.recordNRT(
	"/tmp/trashme", "~/test2.aiff".standardizePath, options: options);


)

/* End Figure 18.5 */

///////////////////////////
//FROM CHAPTER18CODE.SCD
//IN THE SUPERCOLLIDER BOOK
///////////////////////////

/* Figure 18.5 */
(
var score, soundBuf, starttime, synth, options;

(
~m = 5;
~n = 2 * ~m;

SynthDef(\gransyn, { |out = 0, soundBuf, gate = 1, attack = 0.01, release = 0.5, posLo = 0.1, posHi = 0.9, posRateE = 0, posRateM= 1, posRateMLag = 0, posRateMCurve = 0, rate= 1, rateLag = 0, rateCurve = 0, panMax = 0, bpRQ = 0.1, bpRQLag = 0, bpRQCurve = 0, bpLo = 50, bpLoLag = 0, bpLoCurve = 0, bpHi = 5000, bpHiLag = 0, bpHiCurve = 0, amp = 1, ampLag = 0, ampCurve = 0 overlap = 2, overlapLag = 0, overlapCurve = 0, trigRate = 1, trigRateLag = 0, trigRateCurve = 0, interp = 2, posRate = 0, lpFreq = 20000, lpLag = 3, lpCurve = 0, hpFreq = 20, hpLag = 0, hpCurve = 0, rateRandomness = 0, rateRandomnessLag = 0, rateRandomnessCurve = 0, overlapRandomness = 0, overlapRandomnessLag = 0, overlapRandomnessCurve = 0, verbMix = 0, verbMixLag = 0, verbMixCurve = 0, verbRoom = 0, verbDamp =0|

	var sig, sigL, sigR, sigOut, sigLimiter, sigCompressor, env, bpFreq, chan, dUgen, trig, trigs, bufDur, pos, lpfSig, rateNoiseSig, overlapNoiseSig, verbSig;

	//trigger for grains
	trig = Impulse.ar(trigRate);

	//randomness for rate
	rateNoiseSig = PinkNoise.kr(mul: VarLag.kr(rateRandomness, rateRandomnessLag, rateRandomnessCurve), add: 0);
	//rateNoiseSig = rateNoiseSig / 2
	//randomness for overlap
	overlapNoiseSig = PinkNoise.kr(mul: VarLag.kr(overlapRandomness, overlapRandomnessLag, overlapRandomnessCurve), add: 0);

	//define all of your VarLag controlled values here
	trigRate = Demand.ar(trig, 0, VarLag.ar(Demand.ar(trig, 0, trigRate, inf), trigRateLag, trigRateCurve), inf);
	lpFreq = VarLag.kr(lpFreq, lpLag, lpCurve);
	hpFreq = VarLag.kr(hpFreq, hpLag, hpCurve);
	rate = VarLag.ar(Demand.ar(trig, 0, rate + rateNoiseSig, inf), rateLag, rateCurve);
	overlap = VarLag.ar(Demand.ar(trig, 0, overlap + overlapNoiseSig, inf), overlapLag, overlapCurve);
	//trigRate = VarLag.kr(trigRate, trigRateLag, trigRateCurve);
	posRateM = VarLag.kr(posRateM, posRateMLag, posRateMCurve);
	amp = VarLag.kr(amp, ampLag, ampCurve);
	verbMix = VarLag.ar(Demand.ar(trig, 0, verbMix, inf), verbMixLag, verbMixCurve);

    // we need a multichannel trigger that steps through all consecutive channels
    trigs = { |i| PulseDivider.ar(trig, ~n, ~n-1-i) } ! ~n;

    chan = Demand.ar(trig, 0, Dseq((0..~n-1), inf));

	env = Linen.kr(gate, attack, 1, release, 2) * amp;

    posRate = 10 ** posRateE * posRateM;
    bufDur = BufDur.kr(soundBuf);
    pos = Phasor.ar(0, BufRateScale.kr(soundBuf) * posRate * SampleDur.ir / bufDur, posLo, posHi);


	sig = TGrains.ar(~n, trig, soundBuf, Demand.ar(trig, 0, rate, inf), pos * bufDur, Demand.ar(trig, 0, overlap, inf) / Demand.ar(trig, 0, trigRate, inf),

	chan.linlin(0, ~n-1, -1/~n, (2*~n - 3)/~n), 1, interp);

    dUgen = Dwhite(0.0, 1);

	sig = sig.collect { |ch, i|
		// this is the place to define fxs per channel/grain
		lpfSig = LPF.ar(in: ch, freq: lpFreq, mul: 1, add: 0);

		HPF.ar(in: lpfSig, freq: hpFreq, mul: 1, add: 0);
	};

    // routing to two channels ...
    sigL = Mix(((0..(~m-1)) * 2).collect(sig[_]));
    sigR = Mix(((0..(~m-1)) * 2 + 1).collect(sig[_]));

	//route stereo sig thru cheap verb
	verbSig = FreeVerb2.ar(sigL, sigR, mix: Demand.ar(trig, 0, verbMix, inf), room: verbRoom, damp: verbDamp);

	//output
	Out.ar(out, Pan2.ar(verbSig[0], panMax.neg) + Pan2.ar(verbSig[1], panMax) * env);

})).load(s);

// open a file for writing raw OSC data to
f = File("~/test.osc".standardizePath,"w");
// the synthesizer
//Require("gransyn.scd");
// ~ctksynth

// the score
//~score = CtkScore.new;
//Require("score.scd");
score = Score.new;

pattern = (
	Pdef(\scene0, Pdef(\part1,
	Ppar([
			Pmono(
				\gransyn,
			    //\soundBuf, b.bufnum,
				\dur, Pseq([1, 5, 4,5], 1),
				\attack, Pseq([0, 0, 0, 1], 1),
				\release, Pseq([0, 0, 0, 1], 1),
				\posLo, Pseq([0, 0, 0, 1], 1),
				\posHi, Pseq([1, 1, 1, 1], 1),
				\posRateE, Pseq([0, 0, 0, 0], 1),
				\posRateM, Pseq([1, 0.5, 1, 1], 1),
				\posRateMLag, Pseq([0, 0, 0, 0], 1),
				\posRateMCurve, Pseq([0, 0, 0, 0], 1),
			    \overlap, Pseq([1, 2, 1, 1], 1),
				\overlapLag, Pseq([0, 2, 1, 1], 1),
				\overlapCurve, Pseq([0, 0, 0, 0], 1),
				\trigRate, Pseq([0, 10, 2, 2], 1),
				\trigRateLag, Pseq([0, 0, 3, 3], 1),
				\trigRateCurve, Pseq([0, 0, 0, 0], 1),
				\rate, Pseq([1, 3, 1, 1], 1),
			    \rateLag, Pseq([0, 3, 2, 0], 1),
				\rateCurve, Pseq([0, 0, 0, 0], 1),
				\lpFreq, Pseq([20000,20000, 20000, 20000], 1),
				\lpLag, Pseq([0, 0, 0, 0], 1),
				\lpCurve, Pseq([0, 0, 0, 0], 1),
				\hpFreq,Pseq([10, 10, 10, 10], 1),
				\hpLag, Pseq([0, 0, 0, 0], 1),
				\hpCurve, Pseq([0, 0, 0, 0], 1),
				\panMax, Pseq([0, 0.2, 0, 0], 1),
			    \amp, Pseq([0, 1, 0, 0], 1),
			    \ampLag, Pseq([3, 1, 1/2, 4], 1),
			    \ampCurve, Pseq([0, 0, 0, 0], 1),
			),
	])
)).asScore;
);


//p = ~music.asScore(17.0);

//score.add(~score);
// create a Buffer object for adding to the Score
//sndbuf = Buffer.new;
soundBuf = Buffer.new;

p = pattern.asScore(17.0);
p.score.postcs;

//write out file
f.write(p.asCompileString);
f.close;

// for NRT rendering, the buffer messages must be added to the Score
//score.add([0, sndbuf.allocReadMsg("/Users/pvh/voice.wav")]);
score.add([0, soundBuf.allocReadMsg("/Users/pvh/voice.wav")]);

score.sort;

// the ServerOptions for rendering the soundfile
options = ServerOptions.new.numOutputBusChannels_(2);

// write the soundfile out to disk
score.recordNRT(
	"/tmp/trashme", "~/test2.aiff".standardizePath, options: options);


)

/* End Figure 18.5 */

