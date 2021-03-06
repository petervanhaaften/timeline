///////////////////////
//    SCENE2 PART1
///////////////////////

(
Pdef(\scene2, Pdef(\part1,
	Ppar([
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([0, 4, 3, 3, 10, 4], 1),
			\gate, Pseq([1, 1, 1, 1, 1, 0], 1),
			\attack, Pseq([0, 0, 0, 0, 0, 0], 1),
			\release, Pseq([0, 0, 0, 0, 3, 6], 1),
			\posLo, Pseq([0, 0, 0, 0, 0.5, 0.5], 1),
			\posHi, Pseq([1, 0.3, 0.3, 0.5, 0.9, 0.9], 1),
			\posRateE, Pseq([0, 0, 0, 0, 0], 1),
			\posRateM, Pseq([1, -0.2, 0.5, -2, -2 ], 1),
			\posRateMLag, Pseq([0, 4, 3, 4, 2], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0], 1),
			\overlap, Pseq([30, 1, 75, 5, 5, 5], 1),
			\overlapLag, Pseq([0, 5, 1, 1, 1, 4], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\overlapRandomness, Pseq([0, 0, 3, 5, 100, 100],1),
			\overlapRandomnessLag, Pseq([0, 0, 4, 0, 7, 0],1),
			\overlapRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0],1),
			\trigRate, Pseq([1, 5, 1, 30, 20], 1),
			\trigRateLag, Pseq([0, 5, 2, 5, 3, 5], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\rate, Pseq([1, 2, 1, -1.5, -7, -7], 1),
			\rateLag, Pseq([0, 3, 0, 3, 6, 2], 1),
			\rateCurve, Pseq([0, 0, 0, 1, 1, 1], 1),
			\rateRandomness, Pseq([0, 2, 0, 0, -30, -100], 1),
			\rateRandomnessLag, Pseq([0, 4, 1, 0, 8, 2], 1),
			\rateRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([10, 10000, 20000, 20000, 20000, 20000], 1),
			\lpLag, Pseq([0, 0, 4, 0, 0, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 10, 10, 10, 1000, 1000], 1),
			\hpLag, Pseq([0, 0, 0, 0, 7, 1], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0, 0, 0.2, 0, 0.3, 0], 1),
			\amp, Pseq([0, 0.75, 0.75, 0, 1, 0], 1),
			\ampLag, Pseq([0, 2, 1, 3, 2, 0], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\verbMix, Pseq([0, 0, 1, 1, 1, 0], 1),
			\verbMixLag, Pseq([0, 0, 2, 0, 3, 0], 1),
			\verbMixCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\verbRoom, Pseq([0, 0, 1, 1, 0.5, 0.5, 0], 1),
			\verbDamp, Pseq([0, 0, 0, 0, 0, 0], 1),
			\out,0,
		),
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([1, 3, 3, 3, 10, 10], 1),
			\gate, Pseq([0, 0, 1, 0, 1, 0], 1),
			\attack, Pseq([0, 0, 3, 0, 0, 0], 1),
			\release, Pseq([0, 0, 2, 0, 2, 2], 1),
			\posLo, Pseq([0, 0, 0, 0, 0.5, 0.5], 1),
			\posHi, Pseq([1, 0.3, 0.3, 0.8, 0.9, 0.9], 1),
			\posRateE, Pseq([0, 0, 0, 0, 0], 1),
			\posRateM, Pseq([1, 0.02, 0.5, 2, 2 ], 1),
			\posRateMLag, Pseq([0, 4, 3, 4, 2], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0], 1),
			\overlap, Pseq([1, 5, 9, 5, 50, 2], 1),
			\overlapLag, Pseq([0, 5, 1, 1, 10, 10], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\overlapRandomness, Pseq([0, 100, 50, 0, 3, 0],1),
			\overlapRandomnessLag, Pseq([0, 0, 0, 0, 0, 0],1),
			\overlapRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0],1),
			\trigRate, Pseq([1, 10, 30, 20, 10], 1),
			\trigRateLag, Pseq([0, 3, 3, 5, 3, 0], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\rate, Pseq([1, 5, -1.25, 0, -3.5, 1], 1),
			\rateLag, Pseq([0, 3, 3, 3, 3, 2], 1),
			\rateCurve, Pseq([0, 0, 0, 1, 1, 1], 1),
			\rateRandomness, Pseq([0, 3, 2, 100, 3, 0], 1),
			\rateRandomnessLag, Pseq([0, 2, 1, 7, 5, 0], 1),
			\rateRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([20000, 20000, 20000, 20000, 20000, 20000], 1),
			\lpLag, Pseq([0, 0, 4, 3, 6, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 1000, 10, 100, 100, 10], 1),
			\hpLag, Pseq([0, 3, 0, 0, 0, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0, 0, 0, 0, 0, 0], 1),
			\amp, Pseq([0, 0, 0.75, 0, 1, 0], 1),
			\ampLag, Pseq([0, 2, 2, 1, 4, 4], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\verbMix, Pseq([0, 0, 0, 0, 1, 1], 1),
			\verbMixLag, Pseq([0, 0, 0, 0, 3, 0], 1),
			\verbMixCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\verbRoom, Pseq([0, 0, 0, 0, 0, 0.5, 0.5], 1),
			\verbDamp, Pseq([0, 0, 0, 0, 0, 0], 1),
			\out,0,
		),
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([1, 3, 3, 3, 10, 10], 1),
			\gate, Pseq([1, 1, 1, 1, 1, 0], 1),
			\attack, Pseq([0, 0, 3, 0, 0, 0], 1),
			\release, Pseq([0, 0, 0, 0, 5, 0], 1),
			\posLo, Pseq([0, 0, 0, 0, 0.5, 0.5], 1),
			\posHi, Pseq([1, 0.3, 0.3, 0.8, 0.9, 0.9], 1),
			\posRateE, Pseq([0, 0, 0, 0, 0], 1),
			\posRateM, Pseq([1, 0.02, 0.5, 0.5, 1 ], 1),
			\posRateMLag, Pseq([0, 4, 3, 4, 2], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0], 1),
			\overlap, Pseq([1, 5, 9, 5, 30, 20], 1),
			\overlapLag, Pseq([0, 5, 1, 1, 10, 10], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\overlapRandomness, Pseq([0, 100, 50, 0, 3, 10],1),
			\overlapRandomnessLag, Pseq([0, 0, 0, 0, 0, 1],1),
			\overlapRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0],1),
			\trigRate, Pseq([1, 10, 30, 20, 20], 1),
			\trigRateLag, Pseq([0, 3, 3, 5, 3, 0], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\rate, Pseq([1, 5, -1.25, 1, 1, 1], 1),
			\rateLag, Pseq([0, 3, 3, 3, 3, 2], 1),
			\rateCurve, Pseq([0, 0, 0, 1, 1, 1], 1),
			\rateRandomness, Pseq([0, 3, 2, 0, 4, 3], 1),
			\rateRandomnessLag, Pseq([0, 2, 1, 7, 5, 1], 1),
			\rateRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([20000, 20000, 20000, 20000, 20000, 20000], 1),
			\lpLag, Pseq([0, 0, 4, 3, 6, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 10, 10, 100, 100, 10], 1),
			\hpLag, Pseq([0, 3, 0, 0, 0, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0, 0, 0, 0, 0, 0], 1),
			\amp, Pseq([0, 0, 0, 1, 1, 0], 1),
			\ampLag, Pseq([0, 2, 2, 2, 4, 6], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\verbMix, Pseq([0, 0, 0, 0, 0.3, 1], 1),
			\verbMixLag, Pseq([0, 0, 0, 0, 8, 0], 1),
			\verbMixCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\verbRoom, Pseq([0, 0, 0, 0, 0, 0.5, 1], 1),
			\verbDamp, Pseq([0, 0, 0, 0, 0, 0], 1),
			\out,0,
		),
	])
));
);


///////////////////////
//    SCENE2 PART 2
///////////////////////

(
Pdef(\scene2, Pdef(\part2,
	Ppar([
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([3, 6, 7, 3, 10, 4], 1),
			\gate, Pseq([0, 1, 0, 1, 1, 0], 1),
			\attack, Pseq([0, 0, 0, 0, 0, 0], 1),
			\release, Pseq([0, 2, 0, 0, 3, 6], 1),
			\posLo, Pseq([0, 0, 0, 0, 0.5, 0.5], 1),
			\posHi, Pseq([1, 0.3, 0.3, 0.5, 0.9, 0.9], 1),
			\posRateE, Pseq([0, 0, 0, 0, 0], 1),
			\posRateM, Pseq([1, -0.2, 0.5, -2, -2 ], 1),
			\posRateMLag, Pseq([0, 4, 3, 4, 2], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0], 1),
			\overlap, Pseq([30, 1, 75, 5, 5, 5], 1),
			\overlapLag, Pseq([0, 5, 1, 1, 1, 4], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\overlapRandomness, Pseq([0, 50, 3, 5, 100, 100],1),
			\overlapRandomnessLag, Pseq([0, 0, 4, 0, 7, 0],1),
			\overlapRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0],1),
			\trigRate, Pseq([1, 5, 1, 30, 20], 1),
			\trigRateLag, Pseq([0, 5, 2, 5, 3, 5], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\rate, Pseq([1, 2, 1, -1.5, -7, -7], 1),
			\rateLag, Pseq([0, 1, 0, 3, 6, 2], 1),
			\rateCurve, Pseq([0, 0, 0, 1, 1, 1], 1),
			\rateRandomness, Pseq([0, 2, 0, 0, -30, -100], 1),
			\rateRandomnessLag, Pseq([0, 4, 1, 0, 8, 2], 1),
			\rateRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([10, 10000, 20000, 20000, 20000, 20000], 1),
			\lpLag, Pseq([0, 0, 4, 0, 0, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 10, 10, 10, 1000, 1000], 1),
			\hpLag, Pseq([0, 0, 0, 0, 7, 1], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0, 0, 0.2, 0, 0.3, 0], 1),
			\amp, Pseq([0, 1, 1, 0, 0, 0], 1),
			\ampLag, Pseq([0, 0, 1, 3, 2, 0], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\verbMix, Pseq([0, 0, 1, 1, 1, 0], 1),
			\verbMixLag, Pseq([0, 0, 2, 0, 3, 0], 1),
			\verbMixCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\verbRoom, Pseq([0, 0, 1, 1, 0.5, 0.5, 0], 1),
			\verbDamp, Pseq([0, 0, 0, 0, 0, 0], 1),
			\out,0,
		),
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([0, 9, 3, 3, 5, 10], 1),
			\gate, Pseq([0, 1, 0, 0, 0, 0], 1),
			\attack, Pseq([0, 2, 3, 0, 0, 0], 1),
			\release, Pseq([0, 0, 2, 0, 2, 2], 1),
			\posLo, Pseq([0, 0, 0, 0, 0.5, 0.5], 1),
			\posHi, Pseq([1, 0.3, 0.3, 0.8, 0.9, 0.9], 1),
			\posRateE, Pseq([0, 0, 0, 0, 0], 1),
			\posRateM, Pseq([1, 0.02, 0.024, 2, 2 ], 1),
			\posRateMLag, Pseq([0, 4, 4, 4, 2], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0], 1),
			\overlap, Pseq([1, 20, 20, 5, 50, 2], 1),
			\overlapLag, Pseq([0, 0, 1, 1, 10, 10], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\overlapRandomness, Pseq([0, 1, 1, 0, 3, 0],1),
			\overlapRandomnessLag, Pseq([0, 0, 0, 0, 0, 0],1),
			\overlapRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0],1),
			\trigRate, Pseq([1, 100, 100, 20, 10], 1),
			\trigRateLag, Pseq([0, 0, 3, 5, 3, 0], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\rate, Pseq([1, 3.25, 3.25, 0, -3.5, 1], 1),
			\rateLag, Pseq([0, 0, 1/2, 3, 3, 2], 1),
			\rateCurve, Pseq([0, 0, 0, 1, 1, 1], 1),
			\rateRandomness, Pseq([0, 0, 0, 100, 3, 0], 1),
			\rateRandomnessLag, Pseq([0, 2, 1, 7, 5, 0], 1),
			\rateRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([20000, 7000, 7000, 20000, 20000, 20000], 1),
			\lpLag, Pseq([0, 0, 4, 3, 6, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 1500, 1500, 100, 100, 10], 1),
			\hpLag, Pseq([0, 1, 0, 3, 0, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0, 0, 0, 0, 0, 0], 1),
			\amp, Pseq([0, 1, 1, 0, 0, 0], 1),
			\ampLag, Pseq([0, 2, 2, 1, 4, 4], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\verbMix, Pseq([1, 0, 0, 0, 1, 1], 1),
			\verbMixLag, Pseq([0, 0, 0, 0, 3, 0], 1),
			\verbMixCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\verbRoom, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\verbDamp, Pseq([0, 0, 0, 0, 0, 0], 1),
			\out,0,
		),
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([3, 6, 7, 7, 10, 10], 1),
			\gate, Pseq([1, 1, 1, 1, 1, 0], 1),
			\attack, Pseq([0, 0, 3, 0, 0, 0], 1),
			\release, Pseq([0, 0, 0, 0, 5, 0], 1),
			\posLo, Pseq([0, 0, 0, 0, 0.5, 0.5], 1),
			\posHi, Pseq([1, 0.3, 0.3, 0.8, 0.9, 0.9], 1),
			\posRateE, Pseq([0, 0, 0, 0, 0], 1),
			\posRateM, Pseq([1, 0.3, 0.1, 0.02, 1 ], 1),
			\posRateMLag, Pseq([0, 0, 3, 4, 2], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0], 1),
			\overlap, Pseq([1, 5, 9, 100, 300, 20], 1),
			\overlapLag, Pseq([0, 5, 1, 1, 10, 10], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\overlapRandomness, Pseq([0, 100, 50, 0, 3, 10],1),
			\overlapRandomnessLag, Pseq([0, 0, 0, 0, 0, 1],1),
			\overlapRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0],1),
			\trigRate, Pseq([1, 10, 30, 200, 20], 1),
			\trigRateLag, Pseq([0, 4, 3, 5, 3, 0], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\rate, Pseq([1, 1, -1.25, 2, 2, 1], 1),
			\rateLag, Pseq([0, 0, 3, 3, 3, 2], 1),
			\rateCurve, Pseq([0, 0, 0, 1, 1, 1], 1),
			\rateRandomness, Pseq([0, 3, 0, 4, 4, 3], 1),
			\rateRandomnessLag, Pseq([0, 0, 1, 3, 5, 1], 1),
			\rateRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([1000, 1000, 20000, 20000, 20000, 20000], 1),
			\lpLag, Pseq([0, 0, 4, 3, 6, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 10, 10, 100, 100, 10], 1),
			\hpLag, Pseq([0, 3, 0, 0, 0, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0, 0, 0, 0, 0, 0], 1),
			\amp, Pseq([0, 0, 0, 1, 0, 0], 1),
			\ampLag, Pseq([0, 0, 2, 2, 4, 6], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\verbMix, Pseq([0, 0, 0, 0, 0, 1], 1),
			\verbMixLag, Pseq([0, 0, 0, 0, 8, 0], 1),
			\verbMixCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\verbRoom, Pseq([0, 0, 0, 0.5, 0, 0.5, 1], 1),
			\verbDamp, Pseq([0, 0, 0, 0, 0, 0], 1),
			\out,0,
		),
	])
));
);

///////////////////////
//    SCORE PLAYER
///////////////////////

~myscore = Pdef(\scene2, Pdef(\main,
	Pseq([
		//start score
		Pfunc({ "THIS IS THE START OF THE SCORE NOW".postln;}).collect,
		Pfindur(31, Pdef(\part1)),
		Pfindur(16, Pdef(\part2)),
		//Pfuncn({~net.sendMsg('/timeline/scene',9999, ~telephoneNum, ~asteriskChannel, ~wavPin)}, repeats: 1);
		//Pfunc{ ~net.sendMsg('/timeline/scene',9999, ~telephoneNum, ~asteriskChannel, ~wavPin) },
		Pfunc({ "THIS IS THE END OF THE SCORE NOW".postln;}).collect,
		//Pfunc({~net.sendMsg('/timeline/scene',9999, ~telephoneNum, ~asteriskChannel, ~wavPin)}).collect;
	],1),
));


/*TEST FOR RAMPING
///////////////////////
//    SCORE INIT
///////////////////////

(
Pdef(\scene, Pdef(\part2,
	Ppar([
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([3, 3], 1),
            \gate, Pseq([1, 1], 1),
			\attack, Pseq([0, 0], 1),
			\release, Pseq([0, 0], 1),
			\posLo, Pseq([0, 0], 1),
			\posHi, Pseq([1, 1], 1),
			\posRateE, Pseq([0, 0], 1),
			\posRateM, Pseq([1, 1], 1),
			\posRateMLag, Pseq([0, 0], 1),
			\posRateMCurve, Pseq([0, 0], 1),
			\overlap, Pseq([1, 100], 1),
			\overlapLag, Pseq([0, 0], 1),
			\overlapCurve, Pseq([0, 0], 1),
			\overlapRandomness, Pseq([0, 0],1),
			\overlapRandomnessLag, Pseq([0, 0],1),
			\overlapRandomnessCurve, Pseq([0, 0],1),
			\trigRate, Pseq([1, 200], 1),
			\trigRateLag, Pseq([0, 10], 1),
			\trigRateCurve, Pseq([0, 0], 1),
			\rate, Pseq([1, 1], 1),
			\rateLag, Pseq([0, 0], 1),
			\rateCurve, Pseq([0, 0], 1),
			\rateRandomness, Pseq([0, 0], 1),
			\rateRandomnessLag, Pseq([0, 0], 1),
			\rateRandomnessCurve, Pseq([0, 0], 1),
			\lpFreq, Pseq([20000, 50], 1),
			\lpLag, Pseq([0, 9], 1),
			\lpCurve, Pseq([0, 0], 1),
			\hpFreq,Pseq([10, 10], 1),
			\hpLag, Pseq([0, 10], 1),
			\hpCurve, Pseq([0, 0], 1),
			\panMax, Pseq([0, 4], 1),
			\amp, Pseq([1, 0], 1),
			\ampLag, Pseq([0, 3], 1),
			\ampCurve, Pseq([0, 0], 1),
			\verbMix, Pseq([0, 0], 1),
			\verbMixLag, Pseq([0, 0], 1),
			\verbMixCurve, Pseq([0, 0], 1),
			\verbRoom, Pseq([0, 0], 1),
			\verbDamp, Pseq([0, 0], 1),
			\out,0,
		),

	])
));
);

*/

/*
///////////////////////
//    SCORE INIT
///////////////////////

(
Pdef(\scene, Pdef(\part2,
	Ppar([
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
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
			\overlap, Pseq([0.5], 1),
			\overlapLag, Pseq([0], 1),
			\overlapCurve, Pseq([0], 1),
			\overlapRandomness, Pseq([0],1),
			\overlapRandomnessLag, Pseq([0],1),
			\overlapRandomnessCurve, Pseq([0],1),
			\trigRate, Pseq([5], 1),
			\trigRateLag, Pseq([0], 1),
			\trigRateCurve, Pseq([0], 1),
			\rate, Pseq([1], 1),
			\rateLag, Pseq([0], 1),
			\rateCurve, Pseq([0], 1),
			\rateRandomness, Pseq([0], 1),
			\rateRandomnessLag, Pseq([0], 1),
			\rateRandomnessCurve, Pseq([0], 1),
			\lpFreq, Pseq([20000], 1),
			\lpLag, Pseq([0], 1),
			\lpCurve, Pseq([0], 1),
			\hpFreq,Pseq([10], 1),
			\hpLag, Pseq([0], 1),
			\hpCurve, Pseq([0], 1),
			\panMax, Pseq([0], 1),
			\amp, Pseq([0.6], 1),
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
));
);
/*