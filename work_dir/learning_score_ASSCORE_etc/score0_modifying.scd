///////////////////////≥
//    SCORE PLAYER
///////////////////////


(
p = Pdef(\scene0, Pdef(\main,
	Pseq([
		//start score
		Pfindur(17, Pdef(\part1)),
		Pfindur(20, Pdef(\part2)),
		Pfindur(22, Pdef(\part3)),
	],1),
)).play;
)

//////////////////////////
//// asScore version /////
//////////////////////////


//b = Buffer.alloc(s, 100 * s.sampleRate);
//b = Buffer.read(s, ~srcdir +/+ "/audio/goodpvoice2.wav");
p = Pdef(\scene0, Pdef(\main,
	Pseq([
		//start score
		Pfindur(17, Pdef(\part1)),
		Pfindur(20, Pdef(\part2)),
		Pfindur(22, Pdef(\part3)),
	],1),
)).asScore(duration: 59, timeOffset: 0.001);

(
y.recordNRT(
    outputFilePath: "~/nrt-help9117.wav".standardizePath,
    headerFormat: "wav",
    sampleFormat: "int16",
    options: s.options,
    duration: 20,
    action: { "done".postln }
);
)

TempoClock.default.tempo = 1;

~zoo = ~peternew.asScore(17.0);

~zoo = ~zoo.add([0.0, [\b_allocRead, 2, ~srcdir +/+ "/audio/VOICE_COMP.wav"]]);
~zoo.score.postcs;
~zoo.play;
~zoo.render("/Users/pvh/asScore-Help.aif", 12.0);

y = ~peternew2.asScore(20.0);
//z.score.postcs;
y.play;


f = File("/Users/pvh/score-test39","w");
f.write(~peternew2.asCompileString);
f.close;
//convert it to a binary OSC file for use with NRT
Score.writeFromFile("/Users/pvh/score-test39", "/Users/pvh/score-test38.osc");


Score.newFromFile("/Users/pvh/score-test37")
Score.playFromFile("/Users/pvh/score-test38")

~peternew.render("/Users/pvh/asScore-Help2.aif", 12.0);
z.render("/Users/pvh/asScore-Help2.aif", 12.0);

~peternew = ~peternew.add([0.0, [\b_allocRead, b, "/Users/pvh/src/timeline/audio/VOICE_COMP.wav")]]);

///////////////
///another try
//////////////

// the buffer
b = CtkBuffer.playbuf(~srcdir +/+ "/audio/VOICE_COMP.wav");
// the score
~score = CtkScore.new;
// add the buffer to the score
~score.add(b);
~score.add(~peternew);


~sops = ServerOptions.new.numOutputBusChannels = 2;


~score.write("/Users/pvh/emptyNRT.aiff", options: ~sops);


(
~peternew = CtkScore.new( Pdef(\scene0, Pdef(\part1,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
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
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([1, 5, 4, 7], 1),
				\attack, Pseq([0, 0, 0, 0], 1),
				\release, Pseq([0, 0, 0, 0], 1),
				\posLo, Pseq([0, 0, 0.4, 0.4], 1),
				\posHi, Pseq([1, 1, 0.5, 0.5], 1),
				\posRateE, Pseq([0, 0, 0, 0], 1),
				\posRateM, Pseq([1, 0.5, -1, 1], 1),
				\posRateMLag, Pseq([0, 0, 0, 0], 1),
				\posRateMCurve, Pseq([0, 0, 0, 0], 1),
			    \overlap, Pseq([1, 2, 2, 3], 1),
				\overlapLag, Pseq([0, 2, 0, 0], 1),
				\overlapCurve, Pseq([0, 0, 0, 0], 1),
				\trigRate, Pseq([0, 10, 10, 20], 1),
				\trigRateLag, Pseq([0, 0, 0, 2], 1),
				\trigRateCurve, Pseq([0, 0, 0, 0], 1),
				\rate, Pseq([1, 1, 0.75, 0.6], 1),
			    \rateLag, Pseq([0, 3, 0, 0], 1),
				\rateCurve, Pseq([0, 0, 0, 0], 1),
				\lpFreq, Pseq([20000,20000, 2000, 1000], 1),
				\lpLag, Pseq([0, 0, 3, 3], 1),
				\lpCurve, Pseq([0, 0, 0, 0], 1),
				\hpFreq,Pseq([10, 10, 10, 10], 1),
				\hpLag, Pseq([0, 0, 0, 0], 1),
				\hpCurve, Pseq([0, 0, 0, 0], 1),
				\panMax, Pseq([0, 0.2, 0, 0], 1),
			    \amp, Pseq([0, 1, 1, 0], 1),
				\ampLag, Pseq([0, 3, 2, 3], 1),
			    \ampCurve, Pseq([0, 0, 0, 0.5], 1),
			),
	])
	//)).play;)
)).play;)
);

(
~peternew = Pdef(\scene0, Pdef(\part1,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
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
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([1, 5, 4, 7], 1),
				\attack, Pseq([0, 0, 0, 0], 1),
				\release, Pseq([0, 0, 0, 0], 1),
				\posLo, Pseq([0, 0, 0.4, 0.4], 1),
				\posHi, Pseq([1, 1, 0.5, 0.5], 1),
				\posRateE, Pseq([0, 0, 0, 0], 1),
				\posRateM, Pseq([1, 0.5, -1, 1], 1),
				\posRateMLag, Pseq([0, 0, 0, 0], 1),
				\posRateMCurve, Pseq([0, 0, 0, 0], 1),
			    \overlap, Pseq([1, 2, 2, 3], 1),
				\overlapLag, Pseq([0, 2, 0, 0], 1),
				\overlapCurve, Pseq([0, 0, 0, 0], 1),
				\trigRate, Pseq([0, 10, 10, 20], 1),
				\trigRateLag, Pseq([0, 0, 0, 2], 1),
				\trigRateCurve, Pseq([0, 0, 0, 0], 1),
				\rate, Pseq([1, 1, 0.75, 0.6], 1),
			    \rateLag, Pseq([0, 3, 0, 0], 1),
				\rateCurve, Pseq([0, 0, 0, 0], 1),
				\lpFreq, Pseq([20000,20000, 2000, 1000], 1),
				\lpLag, Pseq([0, 0, 3, 3], 1),
				\lpCurve, Pseq([0, 0, 0, 0], 1),
				\hpFreq,Pseq([10, 10, 10, 10], 1),
				\hpLag, Pseq([0, 0, 0, 0], 1),
				\hpCurve, Pseq([0, 0, 0, 0], 1),
				\panMax, Pseq([0, 0.2, 0, 0], 1),
			    \amp, Pseq([0, 1, 1, 0], 1),
				\ampLag, Pseq([0, 3, 2, 3], 1),
			    \ampCurve, Pseq([0, 0, 0, 0.5], 1),
			),
	])
)).asScore;
);


(
~peternew2 = Pdef(\scene0, Pdef(\part2,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([1, 7, 4, 8], 1),
				\attack, Pseq([0, 0, 0, 1], 1),
				\release, Pseq([0, 0, 0, 1], 1),
				\posLo, Pseq([0, 0, 0, 1], 1),
				\posHi, Pseq([1, 1, 1, 1], 1),
				\posRateE, Pseq([0, 0.4, 0.1, 0], 1),
				\posRateM, Pseq([0.2, 0.7, 0.7, 1], 1),
				\posRateMLag, Pseq([0, 0, 0, 0], 1),
				\posRateMCurve, Pseq([0, 0, 0, 0], 1),
			    \overlap, Pseq([1, 5, 1, 1], 1),
				\overlapLag, Pseq([0, 2, 1, 1], 1),
				\overlapCurve, Pseq([0, 0, 0, 0], 1),
				\trigRate, Pseq([0, 10, 4, 30], 1),
				\trigRateLag, Pseq([0, 0, 3, 3], 1),
				\trigRateCurve, Pseq([0, 0, 0, 0], 1),
				\rate, Pseq([7, 5, 4, 1], 1),
			    \rateLag, Pseq([0, 4, 3, 0], 1),
				\rateCurve, Pseq([0, 0, 0, 0], 1),
				\lpFreq, Pseq([20000, 20000, 20000, 20000], 1),
				\lpLag, Pseq([0, 0, 0, 0], 1),
				\lpCurve, Pseq([0, 0, 0, 0], 1),
				\hpFreq,Pseq([10, 10, 10, 1000], 1),
				\hpLag, Pseq([0, 0, 0, 3], 1),
				\hpCurve, Pseq([0, 0, 0, 0], 1),
				\panMax, Pseq([0, 0.5, 0, 0], 1),
			    \amp, Pseq([0, 1, 1, 0], 1),
				\ampLag, Pseq([3, 1, 5, 0], 1),
			    \ampCurve, Pseq([0, 0, 0, 0], 1),
			),
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([1, 7, 4, 8], 1),
				\attack, Pseq([0, 0, 0, 0], 1),
				\release, Pseq([0, 0, 0, 0], 1),
				\posLo, Pseq([0, 0, 0.4, 0.4], 1),
				\posHi, Pseq([1, 1, 0.5, 0.6], 1),
				\posRateE, Pseq([0, 0, 0, 0], 1),
				\posRateM, Pseq([1, 0.5, 0.3, 0.1], 1),
				\posRateMLag, Pseq([0, 0, 0, 3], 1),
				\posRateMCurve, Pseq([0, 0, 0, 0], 1),
			    \overlap, Pseq([1, 2, 2, 2], 1),
				\overlapLag, Pseq([0, 2, 0, 3], 1),
				\overlapCurve, Pseq([0, 0, 0, 0], 1),
				\trigRate, Pseq([0, 1, 100, 50], 1),
				\trigRateLag, Pseq([0, 0, 3, 4], 1),
				\trigRateCurve, Pseq([0, 0, 0, 0], 1),
				\rate, Pseq([1, 1, 0.75, 5], 1),
			    \rateLag, Pseq([0, 3, 0, 3], 1),
				\rateCurve, Pseq([0, 0, 0, 0], 1),
				\lpFreq, Pseq([20000,20000, 20000, 20000], 1),
				\lpLag, Pseq([0, 0, 0, 0], 1),
				\lpCurve, Pseq([0, 0, 0, 0], 1),
				\hpFreq,Pseq([10, 10, 10, 5000], 1),
				\hpLag, Pseq([0, 0, 0, 3], 1),
				\hpCurve, Pseq([0, 0, 0, 0], 1),
				\panMax, Pseq([0, 0.2, 0, 0], 1),
			    \amp, Pseq([0, 0, 1, 2], 1),
				\ampLag, Pseq([0, 3, 2, 2], 1),
			    \ampCurve, Pseq([0, 0, 0, 0.5], 1),
			),
	])
)).asScore;
);
_



////score from file
(
Score.play([ 0.0, [ "/g_new", 1, 0, 0 ] ], [ 0.001, [ 9, 'gran_1e', 1000, 0, 1, 'out', 0, 'soundBuf', 8, 'attack', 0, 'release', 0, 'posLo', 0, 'posHi', 1, 'posRateE', 0, 'posRateM', 1, 'posRateMLag', 0, 'posRateMCurve', 0, 'rate', 1, 'rateLag', 0, 'rateCurve', 0, 'panMax', 0, 'amp', 0, 'ampLag', 3, 'ampCurve', 0, 'overlap', 1, 'overlapLag', 0, 'overlapCurve', 0, 'trigRate', 0, 'trigRateLag', 0, 'trigRateCurve', 0, 'lpFreq', 20000, 'lpLag', 0, 'lpCurve', 0, 'hpFreq', 10, 'hpLag', 0, 'hpCurve', 0 ] ], [ 0.001, [ 9, 'gran_1e', 1001, 0, 1, 'out', 0, 'soundBuf', 8, 'attack', 0, 'release', 0, 'posLo', 0, 'posHi', 1, 'posRateE', 0, 'posRateM', 1, 'posRateMLag', 0, 'posRateMCurve', 0, 'rate', 1, 'rateLag', 0, 'rateCurve', 0, 'panMax', 0, 'amp', 0, 'ampLag', 0, 'ampCurve', 0, 'overlap', 1, 'overlapLag', 0, 'overlapCurve', 0, 'trigRate', 0, 'trigRateLag', 0, 'trigRateCurve', 0, 'lpFreq', 20000, 'lpLag', 0, 'lpCurve', 0, 'hpFreq', 10, 'hpLag', 0, 'hpCurve', 0 ] ], [ 1.001, [ 15, 1000, 'out', 0, 'soundBuf', 8, 'attack', 0, 'release', 0, 'posLo', 0, 'posHi', 1, 'posRateE', 0, 'posRateM', 0.5, 'posRateMLag', 0, 'posRateMCurve', 0, 'rate', 3, 'rateLag', 3, 'rateCurve', 0, 'panMax', 0.2, 'amp', 1, 'ampLag', 1, 'ampCurve', 0, 'overlap', 2, 'overlapLag', 2, 'overlapCurve', 0, 'trigRate', 10, 'trigRateLag', 0, 'trigRateCurve', 0, 'lpFreq', 20000, 'lpLag', 0, 'lpCurve', 0, 'hpFreq', 10, 'hpLag', 0, 'hpCurve', 0 ] ], [ 1.001, [ 15, 1001, 'out', 0, 'soundBuf', 8, 'attack', 0, 'release', 0, 'posLo', 0, 'posHi', 1, 'posRateE', 0, 'posRateM', 0.5, 'posRateMLag', 0, 'posRateMCurve', 0, 'rate', 1, 'rateLag', 3, 'rateCurve', 0, 'panMax', 0.2, 'amp', 1, 'ampLag', 3, 'ampCurve', 0, 'overlap', 2, 'overlapLag', 2, 'overlapCurve', 0, 'trigRate', 10, 'trigRateLag', 0, 'trigRateCurve', 0, 'lpFreq', 20000, 'lpLag', 0, 'lpCurve', 0, 'hpFreq', 10, 'hpLag', 0, 'hpCurve', 0 ] ], [ 6.001, [ 15, 1000, 'out', 0, 'soundBuf', 8, 'attack', 0, 'release', 0, 'posLo', 0, 'posHi', 1, 'posRateE', 0, 'posRateM', 1, 'posRateMLag', 0, 'posRateMCurve', 0, 'rate', 1, 'rateLag', 2, 'rateCurve', 0, 'panMax', 0, 'amp', 0, 'ampLag', 0.5, 'ampCurve', 0, 'overlap', 1, 'overlapLag', 1, 'overlapCurve', 0, 'trigRate', 2, 'trigRateLag', 3, 'trigRateCurve', 0, 'lpFreq', 20000, 'lpLag', 0, 'lpCurve', 0, 'hpFreq', 10, 'hpLag', 0, 'hpCurve', 0 ] ], [ 6.001, [ 15, 1001, 'out', 0, 'soundBuf', 8, 'attack', 0, 'release', 0, 'posLo', 0.4, 'posHi', 0.5, 'posRateE', 0, 'posRateM', -1, 'posRateMLag', 0, 'posRateMCurve', 0, 'rate', 0.75, 'rateLag', 0, 'rateCurve', 0, 'panMax', 0, 'amp', 1, 'ampLag', 2, 'ampCurve', 0, 'overlap', 2, 'overlapLag', 0, 'overlapCurve', 0, 'trigRate', 10, 'trigRateLag', 0, 'trigRateCurve', 0, 'lpFreq', 2000, 'lpLag', 3, 'lpCurve', 0, 'hpFreq', 10, 'hpLag', 0, 'hpCurve', 0 ] ], [ 10.001, [ 15, 1000, 'out', 0, 'soundBuf', 8, 'attack', 1, 'release', 1, 'posLo', 1, 'posHi', 1, 'posRateE', 0, 'posRateM', 1, 'posRateMLag', 0, 'posRateMCurve', 0, 'rate', 1, 'rateLag', 0, 'rateCurve', 0, 'panMax', 0, 'amp', 0, 'ampLag', 4, 'ampCurve', 0, 'overlap', 1, 'overlapLag', 1, 'overlapCurve', 0, 'trigRate', 2, 'trigRateLag', 3, 'trigRateCurve', 0, 'lpFreq', 20000, 'lpLag', 0, 'lpCurve', 0, 'hpFreq', 10, 'hpLag', 0, 'hpCurve', 0 ] ], [ 10.001, [ 15, 1001, 'out', 0, 'soundBuf', 8, 'attack', 0, 'release', 0, 'posLo', 0.4, 'posHi', 0.5, 'posRateE', 0, 'posRateM', 1, 'posRateMLag', 0, 'posRateMCurve', 0, 'rate', 0.6, 'rateLag', 0, 'rateCurve', 0, 'panMax', 0, 'amp', 0, 'ampLag', 3, 'ampCurve', 0.5, 'overlap', 3, 'overlapLag', 0, 'overlapCurve', 0, 'trigRate', 20, 'trigRateLag', 2, 'trigRateCurve', 0, 'lpFreq', 1000, 'lpLag', 3, 'lpCurve', 0, 'hpFreq', 10, 'hpLag', 0, 'hpCurve', 0 ] ], [ 15.001, [ 15, 1000, 'gate', 0.0 ] ], [ 17.001, [ 15, 1001, 'gate', 0.0 ] ], [ 59.001, [ 'c_set', 0, 0 ] ])
)


////////////////
////concrete examp
///////////////
(
~server2 = Server(\nrt,
    options: ServerOptions.new
    .numOutputBusChannels_(2)
    .numInputBusChannels_(2)
);

c = Buffer.new(~server2, 4410000, 2)
//b = Buffer.alloc(~server2, ~server.sampleRate * 8.0, 2);
c  = Buffer.read(~server2, ~srcdir +/+ "/audio/goodpvoice2.wav");
Require(~gransyn1);
TempoClock.default.tempo = 1;

(
~petersong = Pdef(\scene0, Pdef(\part1,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, c.bufnum,
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
			Pmono(
				\gran_1e,
			    \soundBuf, c.bufnum,
				\dur, Pseq([1, 5, 4, 7], 1),
				\attack, Pseq([0, 0, 0, 0], 1),
				\release, Pseq([0, 0, 0, 0], 1),
				\posLo, Pseq([0, 0, 0.4, 0.4], 1),
				\posHi, Pseq([1, 1, 0.5, 0.5], 1),
				\posRateE, Pseq([0, 0, 0, 0], 1),
				\posRateM, Pseq([1, 0.5, -1, 1], 1),
				\posRateMLag, Pseq([0, 0, 0, 0], 1),
				\posRateMCurve, Pseq([0, 0, 0, 0], 1),
			    \overlap, Pseq([1, 2, 2, 3], 1),
				\overlapLag, Pseq([0, 2, 0, 0], 1),
				\overlapCurve, Pseq([0, 0, 0, 0], 1),
				\trigRate, Pseq([0, 10, 10, 20], 1),
				\trigRateLag, Pseq([0, 0, 0, 2], 1),
				\trigRateCurve, Pseq([0, 0, 0, 0], 1),
				\rate, Pseq([1, 1, 0.75, 0.6], 1),
			    \rateLag, Pseq([0, 3, 0, 0], 1),
				\rateCurve, Pseq([0, 0, 0, 0], 1),
				\lpFreq, Pseq([20000,20000, 2000, 1000], 1),
				\lpLag, Pseq([0, 0, 3, 3], 1),
				\lpCurve, Pseq([0, 0, 0, 0], 1),
				\hpFreq,Pseq([10, 10, 10, 10], 1),
				\hpLag, Pseq([0, 0, 0, 0], 1),
				\hpCurve, Pseq([0, 0, 0, 0], 1),
				\panMax, Pseq([0, 0.2, 0, 0], 1),
			    \amp, Pseq([0, 1, 1, 0], 1),
				\ampLag, Pseq([0, 3, 2, 3], 1),
			    \ampCurve, Pseq([0, 0, 0, 0.5], 1),
			),
	])
)).asScore;
);



h = File("/Users/pvh" +/+ "score-test11","w");
h.write(~petersong.asCompileString);
h.close;
)

~petersong.recordNRT(
    outputFilePath: "~/nrt-help9112.wav".standardizePath,
    headerFormat: "wav",
    sampleFormat: "int24",
    options: ~server2.options,
    duration: 20,
    action: { "done".postln }
);

server.remove;
)

// b = Buffer.alloc(s, 100 * s.sampleRate);
// b = Buffer.read(s, ~srcdir +/+ "/audio/goodpvoice2.wav");
// Require(~gransyn1);

///////////////////////
//   SCENE 0 / PART 1
///////////////////////

(
Pdef(\scene0, Pdef(\part1,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
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
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([1, 5, 4, 7], 1),
				\attack, Pseq([0, 0, 0, 0], 1),
				\release, Pseq([0, 0, 0, 0], 1),
				\posLo, Pseq([0, 0, 0.4, 0.4], 1),
				\posHi, Pseq([1, 1, 0.5, 0.5], 1),
				\posRateE, Pseq([0, 0, 0, 0], 1),
				\posRateM, Pseq([1, 0.5, -1, 1], 1),
				\posRateMLag, Pseq([0, 0, 0, 0], 1),
				\posRateMCurve, Pseq([0, 0, 0, 0], 1),
			    \overlap, Pseq([1, 2, 2, 3], 1),
				\overlapLag, Pseq([0, 2, 0, 0], 1),
				\overlapCurve, Pseq([0, 0, 0, 0], 1),
				\trigRate, Pseq([0, 10, 10, 20], 1),
				\trigRateLag, Pseq([0, 0, 0, 2], 1),
				\trigRateCurve, Pseq([0, 0, 0, 0], 1),
				\rate, Pseq([1, 1, 0.75, 0.6], 1),
			    \rateLag, Pseq([0, 3, 0, 0], 1),
				\rateCurve, Pseq([0, 0, 0, 0], 1),
				\lpFreq, Pseq([20000,20000, 2000, 1000], 1),
				\lpLag, Pseq([0, 0, 3, 3], 1),
				\lpCurve, Pseq([0, 0, 0, 0], 1),
				\hpFreq,Pseq([10, 10, 10, 10], 1),
				\hpLag, Pseq([0, 0, 0, 0], 1),
				\hpCurve, Pseq([0, 0, 0, 0], 1),
				\panMax, Pseq([0, 0.2, 0, 0], 1),
			    \amp, Pseq([0, 1, 1, 0], 1),
				\ampLag, Pseq([0, 3, 2, 3], 1),
			    \ampCurve, Pseq([0, 0, 0, 0.5], 1),
			),
	])
)).play;
);


///////////////////////
//   SCENE 0 / PART 2
///////////////////////

(
Pdef(\scene0, Pdef(\part2,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([1, 7, 4, 8], 1),
				\attack, Pseq([0, 0, 0, 1], 1),
				\release, Pseq([0, 0, 0, 1], 1),
				\posLo, Pseq([0, 0, 0, 1], 1),
				\posHi, Pseq([1, 1, 1, 1], 1),
				\posRateE, Pseq([0, 0.4, 0.1, 0], 1),
				\posRateM, Pseq([0.2, 0.7, 0.7, 1], 1),
				\posRateMLag, Pseq([0, 0, 0, 0], 1),
				\posRateMCurve, Pseq([0, 0, 0, 0], 1),
			    \overlap, Pseq([1, 5, 1, 1], 1),
				\overlapLag, Pseq([0, 2, 1, 1], 1),
				\overlapCurve, Pseq([0, 0, 0, 0], 1),
				\trigRate, Pseq([0, 10, 4, 30], 1),
				\trigRateLag, Pseq([0, 0, 3, 3], 1),
				\trigRateCurve, Pseq([0, 0, 0, 0], 1),
				\rate, Pseq([7, 5, 4, 1], 1),
			    \rateLag, Pseq([0, 4, 3, 0], 1),
				\rateCurve, Pseq([0, 0, 0, 0], 1),
				\lpFreq, Pseq([20000, 20000, 20000, 20000], 1),
				\lpLag, Pseq([0, 0, 0, 0], 1),
				\lpCurve, Pseq([0, 0, 0, 0], 1),
				\hpFreq,Pseq([10, 10, 10, 1000], 1),
				\hpLag, Pseq([0, 0, 0, 3], 1),
				\hpCurve, Pseq([0, 0, 0, 0], 1),
				\panMax, Pseq([0, 0.5, 0, 0], 1),
			    \amp, Pseq([0, 1, 1, 0], 1),
				\ampLag, Pseq([3, 1, 5, 0], 1),
			    \ampCurve, Pseq([0, 0, 0, 0], 1),
			),
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([1, 7, 4, 8], 1),
				\attack, Pseq([0, 0, 0, 0], 1),
				\release, Pseq([0, 0, 0, 0], 1),
				\posLo, Pseq([0, 0, 0.4, 0.4], 1),
				\posHi, Pseq([1, 1, 0.5, 0.6], 1),
				\posRateE, Pseq([0, 0, 0, 0], 1),
				\posRateM, Pseq([1, 0.5, 0.3, 0.1], 1),
				\posRateMLag, Pseq([0, 0, 0, 3], 1),
				\posRateMCurve, Pseq([0, 0, 0, 0], 1),
			    \overlap, Pseq([1, 2, 2, 2], 1),
				\overlapLag, Pseq([0, 2, 0, 3], 1),
				\overlapCurve, Pseq([0, 0, 0, 0], 1),
				\trigRate, Pseq([0, 1, 100, 50], 1),
				\trigRateLag, Pseq([0, 0, 3, 4], 1),
				\trigRateCurve, Pseq([0, 0, 0, 0], 1),
				\rate, Pseq([1, 1, 0.75, 5], 1),
			    \rateLag, Pseq([0, 3, 0, 3], 1),
				\rateCurve, Pseq([0, 0, 0, 0], 1),
				\lpFreq, Pseq([20000,20000, 20000, 20000], 1),
				\lpLag, Pseq([0, 0, 0, 0], 1),
				\lpCurve, Pseq([0, 0, 0, 0], 1),
				\hpFreq,Pseq([10, 10, 10, 5000], 1),
				\hpLag, Pseq([0, 0, 0, 3], 1),
				\hpCurve, Pseq([0, 0, 0, 0], 1),
				\panMax, Pseq([0, 0.2, 0, 0], 1),
			    \amp, Pseq([0, 0, 1, 2], 1),
				\ampLag, Pseq([0, 3, 2, 2], 1),
			    \ampCurve, Pseq([0, 0, 0, 0.5], 1),
			),
	])
)).play;
);


///////////////////////
//   SCENE 0 / PART 3
///////////////////////

(
Pdef(\scene0, Pdef(\part3,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([1, 5, 8, 8], 1),
				\attack, Pseq([0, 0, 0, 1], 1),
				\release, Pseq([0, 0, 0, 1], 1),
				\posLo, Pseq([0, 0.4, 0.4, 1], 1),
				\posHi, Pseq([1, 0.5, 0.5, 1], 1),
				\posRateE, Pseq([0, 0, 0, 0], 1),
				\posRateM, Pseq([1, -1, 1, 1], 1),
				\posRateMLag, Pseq([0, 0, 0, 0], 1),
				\posRateMCurve, Pseq([0, 0, 0, 0], 1),
			    \overlap, Pseq([1, 1, 1, 1], 1),
				\overlapLag, Pseq([0, 0, 1, 1], 1),
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
			    \ampLag, Pseq([3, 1, 3, 4], 1),
			    \ampCurve, Pseq([0, 0, 0.5, 0], 1),
			),
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([1, 5, 6, 8], 1),
				\attack, Pseq([0, 0, 0, 0], 1),
				\release, Pseq([0, 0, 0, 0], 1),
				\posLo, Pseq([0, 0.4, 0.4, 0.4], 1),
				\posHi, Pseq([1, 0.5, 0.5, 0.5], 1),
				\posRateE, Pseq([0, 0, 0, 0], 1),
				\posRateM, Pseq([1, -1, -1, 1], 1),
				\posRateMLag, Pseq([0, 0, 0, 0], 1),
				\posRateMCurve, Pseq([0, 0, 0, 0], 1),
			    \overlap, Pseq([1, 3, 2, 3], 1),
				\overlapLag, Pseq([0, 2, 0, 0], 1),
				\overlapCurve, Pseq([0, 0, 0, 0], 1),
				\trigRate, Pseq([0, 10, 10, 20], 1),
				\trigRateLag, Pseq([0, 0, 0, 2], 1),
				\trigRateCurve, Pseq([0, 0, 0, 0], 1),
				\rate, Pseq([1, 1.25, 0.75, 0.6], 1),
			    \rateLag, Pseq([0, 1, 0, 0], 1),
				\rateCurve, Pseq([0, 0, 0, 0], 1),
				\lpFreq, Pseq([20000, 20000, 2000, 1000], 1),
				\lpLag, Pseq([0, 0, 3, 3], 1),
				\lpCurve, Pseq([0, 0, 0, 0], 1),
				\hpFreq,Pseq([10, 10, 10, 10], 1),
				\hpLag, Pseq([0, 0, 0, 0], 1),
				\hpCurve, Pseq([0, 0, 0, 0], 1),
				\panMax, Pseq([0, 0.2, 0, 0], 1),
			    \amp, Pseq([0, 1, 1, 0], 1),
				\ampLag, Pseq([0, 3, 1, 3], 1),
			    \ampCurve, Pseq([0, 0, 0.6, 0.5], 1),
			),
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([1, 5, 8, 7], 1),
				\attack, Pseq([0, 0, 0, 0], 1),
				\release, Pseq([0, 0, 0, 0], 1),
				\posLo, Pseq([0, 0.4, 0, 0], 1),
				\posHi, Pseq([1, 0.5, 0.5, 0.5], 1),
				\posRateE, Pseq([0, 0, 0, 0], 1),
				\posRateM, Pseq([1, 1, 0.5, 0.1], 1),
				\posRateMLag, Pseq([0, 0, 0, 2], 1),
				\posRateMCurve, Pseq([0, 0, 0, 0], 1),
			    \overlap, Pseq([1, 3, 3, 1/2], 1),
				\overlapLag, Pseq([0, 2, 1, 1], 1),
				\overlapCurve, Pseq([0, 0, 0, 0], 1),
				\trigRate, Pseq([0, 50, 100, 2000], 1),
				\trigRateLag, Pseq([0, 5, 2, 4], 1),
				\trigRateCurve, Pseq([0, 0, 0, 0], 1),
				\rate, Pseq([1, 2.50, 3, 1], 1),
			    \rateLag, Pseq([0, 1, 0, 2], 1),
				\rateCurve, Pseq([0, 0, 0, 0], 1),
				\lpFreq, Pseq([20000, 20000, 10000, 20000], 1),
				\lpLag, Pseq([0, 0, 3, 1], 1),
				\lpCurve, Pseq([0, 0, 0, 0], 1),
				\hpFreq,Pseq([10, 10, 400, 400], 1),
				\hpLag, Pseq([0, 0, 3, 0], 1),
				\hpCurve, Pseq([0, 0, 0, 0], 1),
				\panMax, Pseq([0, 0.2, 1, 1], 1),
			    \amp, Pseq([0, 1, 1, 1], 1),
				\ampLag, Pseq([0, 4, 2, 5], 1),
			    \ampCurve, Pseq([0, 0, 0, 1], 1),
			),
	])
)).play;
);



/* TEST FOR RAMPING
///////////////////////
//    SCORE INIT
///////////////////////

(
Pdef(\scene, Pdef(\part2,
	Ppar([
		Pmono(
			\gran_1e,
			\soundBuf, b.bufnum,
			\dur, Pseq([1, 10], 1),
			\attack, Pseq([0, 0], 1),
			\release, Pseq([0, 0], 1),
			\posLo, Pseq([0, 0], 1),
			\posHi, Pseq([1, 1], 1),
			\posRateE, Pseq([0, 0], 1),
			\posRateM, Pseq([1, 1], 1),
			\posRateMLag, Pseq([0, 0], 1),
			\posRateMCurve, Pseq([0, 0], 1),
			\overlap, Pseq([0.5, 0.5], 1),
			\overlapLag, Pseq([0, 0], 1),
			\overlapCurve, Pseq([0, 0], 1),
			\overlapRandomness, Pseq([0, 0],1),
			\overlapRandomnessLag, Pseq([0, 0],1),
			\overlapRandomnessCurve, Pseq([0, 0],1),
			\trigRate, Pseq([5, 5], 1),
			\trigRateLag, Pseq([0, 0], 1),
			\trigRateCurve, Pseq([0, 0], 1),
			\rate, Pseq([1, 1], 1),
			\rateLag, Pseq([0, 0], 1),
			\rateCurve, Pseq([0, 0], 1),
			\rateRandomness, Pseq([0, 0], 1),
			\rateRandomnessLag, Pseq([0, 0], 1),
			\rateRandomnessCurve, Pseq([0, 0], 1),
			\lpFreq, Pseq([20000, 20000], 1),
			\lpLag, Pseq([0, 0], 1),
			\lpCurve, Pseq([0, 0], 1),
			\hpFreq,Pseq([10, 10], 1),
			\hpLag, Pseq([0, 0], 1),
			\hpCurve, Pseq([0, 0], 1),
			\panMax, Pseq([0, 0], 1),
			\amp, Pseq([0.6, 0.6], 1),
			\ampLag, Pseq([0, 0], 1),
			\ampCurve, Pseq([0, 0], 1),
			\verbMix, Pseq([0, 1], 1),
			\verbMixLag, Pseq([0, 10], 1),
			\verbMixCurve, Pseq([0, 1], 1),
			\verbRoom, Pseq([0, 0.5], 1),
			\verbDamp, Pseq([0, 0], 1),
			\out,0,
		),

	])
)).play;
);
*/

/*
///////////////////////
//    SCORE INIT
///////////////////////

(
Pdef(\part, Pdef(\part1,
	Ppar([
		Pmono(
			\gran_1e,
			\soundBuf, b.bufnum,
			\dur, Pseq([1], 1),
            \gate, Pseq([1], 1),
            \attack, Pseq([0], 1),
			\release, Pseq([0], 1),
			\posLo, Pseq([0], 1),
			\posHi, Pseq([1], 1),
			\posRateE, Pseq([0], 1),
			\posRateM, Pseq([1], 1),
			\posRateMLag, Pseq([0], 1),
			\posRateMCurve, Pseq([0], 1),
			\overlap, Pseq([1], 1),
			\overlapLag, Pseq([0], 1),
			\overlapCurve, Pseq([0], 1),
			\overlapRandomness, Pseq([0],1),
			\trigRate, Pseq([1], 1),
			\trigRateLag, Pseq([0], 1),
			\trigRateCurve, Pseq([0], 1),
			\rate, Pseq([1], 1),
			\rateLag, Pseq([0], 1),
			\rateCurve, Pseq([0], 1),
			\rateRandomness, Pseq([0], 1),
			\bpRQ, Pseq([0.01], 1),
			\bpRQLag, Pseq([0], 1),
			\bpRQCurve, Pseq([0], 1),
			\lpFreq, Pseq([20000], 1),
			\lpLag, Pseq([0], 1),
			\lpCurve, Pseq([0], 1),
			\hpFreq,Pseq([10], 1),
			\hpLag, Pseq([0], 1),
			\hpCurve, Pseq([0, 0, 0, 0], 1),
			\panMax, Pseq([0], 1),
			\amp, Pseq([1], 1),
			\ampLag, Pseq([0], 1),
			\ampCurve, Pseq([0], 1),
			\verbMix, Pseq([0], 1),
			\verbMixLag, Pseq([0], 1),
			\verbMixCurve, Pseq([0], 1),
			\verbRoom, Pseq([0], 1),
			\verbDamp, Pseq([0], 1),
			\out,0,
		),

	])
)).play;
);

*/


