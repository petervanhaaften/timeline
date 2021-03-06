///////////////////////
//    SCORE PLAYER
///////////////////////

~pattern = Pdef(\scene5, Pdef(\main,
	Pseq([
		//start score
		Pfindur(25, Pdef(\part1)),
		Pfindur(35, Pdef(\part2)),
	],1),
));

///////////////////////
//    SCENE5 PART1
///////////////////////
(
Pdef(\scene, Pdef(\part1,
	Ppar([
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([0, 5, 7, 2, 5, 6, 12], 1),
            \gate, Pseq([1, 1, 1, 1, 1, 0, 0], 1),
			\attack, Pseq([0, 0, 0, 0, 1, 0, 0], 1),
			\release, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\posLo, Pseq([0.6, 0.6, 0.6, 0, 0, 0, 0], 1),
			\posHi, Pseq([0.9, 0.9, 0.9, 0.5, 0.5, 1, 1], 1),
			\posRateE, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\posRateM, Pseq([0, 0.001, 0.001, -0.0001, 3, 2, 2], 1),
			\posRateMLag, Pseq([0, 1, 0, 0, 0, 0, 0], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\overlap, Pseq([2, 100, 5, 10, 30, 100, 100], 1),
			\overlapLag, Pseq([0, 0, 0, 2, 0, 0, 0], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\overlapRandomness, Pseq([1, 20, 0, 1, 0, 0, 0],1),
			\overlapRandomnessLag, Pseq([0, 3, 3, 0, 0, 0, 0],1),
			\overlapRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0, 0],1),
			\trigRate, Pseq([1, 20, 70, 10, 25, 25, 25], 1),
			\trigRateLag, Pseq([0, 5, 1, 2, 3, 3, 3], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rate, Pseq([0.5, 1, 2.2, 3.7, 15, 15, 1], 1),
			\rateLag, Pseq([0, 5, 7, 2, 0, 0, 0], 1),
			\rateCurve, Pseq([0, 0, 0.5, 0, 0, 0, 0], 1),
			\rateRandomness, Pseq([1, 1, 4, 0, 25, 25, 20], 1),
			\rateRandomnessLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rateRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([20000, 20000, 20000, 20000, 10000, 10000, 10000], 1),
			\lpLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 10, 10, 10, 10, 10, 10], 1),
			\hpLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0.3, 0, 0.5, 0.3, 0, 0.4, 0], 1),
			\amp, Pseq([0, 1, 1, 0, 1, 0, 0], 1),
			\ampLag, Pseq([0, 3, 0, 1/4, 4, 1/16, 9], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\verbMix, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\verbMixLag, Pseq([0, 0, 0, 2, 2, 0, 0], 1),
			\verbMixCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\verbRoom, Pseq([0, 0, 0, 0.5, 0.5, 0.5, 1], 1),
			\verbDamp, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\out,0,
		),
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([0, 5, 7, 2, 5, 6, 12], 1),
            \gate, Pseq([1, 1, 1, 1, 1, 0, 0], 1),
			\attack, Pseq([0, 0, 0, 0, 1, 0, 0], 1),
			\release, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\posLo, Pseq([0.6, 0.2, 0.2, 0, 0, 0, 0], 1),
			\posHi, Pseq([0.9, 0.5, 0.5, 0.4, 0.4, 1, 1], 1),
			\posRateE, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\posRateM, Pseq([0, 0.001, 0.001, -0.0001, -0.0001, 2, 2], 1),
			\posRateMLag, Pseq([0, 1, 0, 0, 0, 2, 0], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\overlap, Pseq([2, 100, 5, 10, 30, 100, 100], 1),
			\overlapLag, Pseq([0, 0, 0, 2, 0, 0, 0], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\overlapRandomness, Pseq([1, 20, 0, 1, 0, 25, 100],1),
			\overlapRandomnessLag, Pseq([0, 3, 3, 0, 0, 5, 0],1),
			\overlapRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0, 0],1),
			\trigRate, Pseq([1, 20, 70, 10, 25, 25, 25], 1),
			\trigRateLag, Pseq([0, 5, 1, 2, 3, 3, 3], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rate, Pseq([0.5, 1, 2.2, 7, 20, 1, 1], 1),
			\rateLag, Pseq([0, 5, 7, 2, 0, 0, 0], 1),
			\rateCurve, Pseq([0, 0, 0.5, 0, 0, 0, 0], 1),
			\rateRandomness, Pseq([1, 1, 4, 0, 20, 50, 20], 1),
			\rateRandomnessLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rateRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([20000, 20000, 20000, 20000, 10000, 10000, 10000], 1),
			\lpLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 10, 10, 10, 10, 10, 500], 1),
			\hpLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0.3, 0, 0.5, 0.3, 0, 0.4, 0], 1),
			\amp, Pseq([0, 0, 0, 0, 0, 1, 0], 1),
			\ampLag, Pseq([0, 3, 0, 1/4, 4, 0, 2], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\verbMix, Pseq([0, 0, 0, 0, 2, 1, 1], 1),
			\verbMixLag, Pseq([0, 0, 0, 2, 0, 6, 0], 1),
			\verbMixCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\verbRoom, Pseq([0, 0, 0, 0.5, 0.5, 0.5, 0.5], 1),
			\verbDamp, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\out,0,
		),
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([0, 5, 7, 5, 5, 6, 12], 1),
            \gate, Pseq([1, 1, 1, 1, 1, 0, 0], 1),
			\attack, Pseq([0, 0, 0, 0, 1, 0, 0], 1),
			\release, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\posLo, Pseq([0.2, 0.2, 0.1, 0, 0, 0, 0], 1),
			\posHi, Pseq([0.9, 0.9, 0.4, 0.5, 0.5, 1, 1], 1),
			\posRateE, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\posRateM, Pseq([2, 3, -0.01, -1, 3, 2, 2], 1),
			\posRateMLag, Pseq([0, 4, 0, 0, 0, 0, 0], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\overlap, Pseq([2, 40, 10, 10, 30, 100, 100], 1),
			\overlapLag, Pseq([0, 0, 0, 2, 0, 0, 0], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\overlapRandomness, Pseq([40, 10, 0, 1, 0, 0, 0],1),
			\overlapRandomnessLag, Pseq([0, 3, 3, 0, 0, 0, 0],1),
			\overlapRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0, 0],1),
			\trigRate, Pseq([50, 20, 5, 10, 25, 25, 25], 1),
			\trigRateLag, Pseq([0, 0, 1, 2, 3, 3, 3], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rate, Pseq([2, 0.85, 5.7, 3.7, 15, 15, 1], 1),
			\rateLag, Pseq([0, 3, 7, 2, 0, 0, 0], 1),
			\rateCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rateRandomness, Pseq([1, 0, 0.3, 2, 25, 25, 20], 1),
			\rateRandomnessLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rateRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([20000, 20000, 20000, 20000, 10000, 10000, 10000], 1),
			\lpLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 10, 500, 1000, 10, 10, 10], 1),
			\hpLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0.3, 0, 0.2, 0.3, 0, 0.4, 0], 1),
			\amp, Pseq([0, 0, 1, 0, 0, 0, 0], 1),
			\ampLag, Pseq([0, 0, 4, 5, 1/16, 1/16, 9], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\verbMix, Pseq([0, 0, 0.5, 0.5, 0, 0, 0], 1),
			\verbMixLag, Pseq([0, 0, 0.5, 0.5, 0, 0, 0], 1),
			\verbMixCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\verbRoom, Pseq([0, 0, 0.5, 0.5, 0.5, 0.5, 1], 1),
			\verbDamp, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\out,0,
		),
	])
));
);


///////////////////////
//    SCENE5 PART2
///////////////////////
(
Pdef(\scene5, Pdef(\part2,
	Ppar([
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([1/16, 5, 5, 5, 5, 6, 12], 1),
            \gate, Pseq([1, 1, 1, 1, 1, 0, 0], 1),
			\attack, Pseq([0, 0, 0, 0, 1, 0, 0], 1),
			\release, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\posLo, Pseq([0.6, 0.6, 0.6, 0, 0, 0, 0], 1),
			\posHi, Pseq([0.9, 0.9, 0.9, 0.5, 0.5, 1, 1], 1),
			\posRateE, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\posRateM, Pseq([0, 0.001, 0.001, -0.0001, 0.01, 0.02, 2], 1),
			\posRateMLag, Pseq([0, 1, 0, 0, 0, 0, 0], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\overlap, Pseq([2, 100, 5, 10, 30, 25, 50], 1),
			\overlapLag, Pseq([0, 0, 0, 2, 0, 0, 0], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\overlapRandomness, Pseq([1, 20, 0, 1, 0, 100, 50],1),
			\overlapRandomnessLag, Pseq([0, 3, 3, 0, 0, 0, 0],1),
			\overlapRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0, 0],1),
			\trigRate, Pseq([1, 20, 70, 1, 2, 25, 25], 1),
			\trigRateLag, Pseq([0, 5, 1, 2, 3, 3, 3], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rate, Pseq([4, 1, 2.2, 3.7, 6, 4, 1], 1),
			\rateLag, Pseq([0, 2, 7, 2, 0, 0, 0], 1),
			\rateCurve, Pseq([0, 0, 0.5, 0, 0, 0, 0], 1),
			\rateRandomness, Pseq([0, 0, 4, 0, 25, 4, 7], 1),
			\rateRandomnessLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rateRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([20000, 20000, 20000, 20000, 20000, 20000, 10000], 1),
			\lpLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 10, 10, 10, 10, 10, 10], 1),
			\hpLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0.3, 0, 0.5, 0.3, 0, 0.4, 0], 1),
			\amp, Pseq([0, 1, 1, 0, 0, 1, 0], 1),
			\ampLag, Pseq([0, 3, 3, 1/4, 4, 1/16, 9], 1),
			\ampCurve, Pseq([0, 0, 0.5, 0.5, 0, 0, 0], 1),
			\verbMix, Pseq([0, 0, 3, 0, 0, 1, 1], 1),
			\verbMixLag, Pseq([0, 0, 0, 2, 0, 5, 0], 1),
			\verbMixCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\verbRoom, Pseq([0, 0, 0.5, 0.5, 0.5, 1, 1], 1),
			\verbDamp, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\out,0,
		),
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([1/16, 5, 5, 5, 5, 6, 12], 1),
            \gate, Pseq([1, 1, 1, 1, 1, 1, 1], 1),
			\attack, Pseq([0, 0, 0, 0, 1, 0, 0], 1),
			\release, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\posLo, Pseq([0.6, 0.2, 0.2, 0, 0, 0, 0], 1),
			\posHi, Pseq([0.9, 0.5, 0.5, 0.4, 0.4, 1, 1], 1),
			\posRateE, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\posRateM, Pseq([0, 0.001, 0.001, -0.0001, -0.0001, 2, 2], 1),
			\posRateMLag, Pseq([0, 1, 0, 0, 0, 2, 0], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\overlap, Pseq([2, 100, 5, 10, 30, 100, 100], 1),
			\overlapLag, Pseq([0, 0, 0, 2, 0, 0, 0], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\overlapRandomness, Pseq([1, 20, 0, 1, 10, 15, 100],1),
			\overlapRandomnessLag, Pseq([0, 3, 3, 0, 2, 5, 0],1),
			\overlapRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0, 0],1),
			\trigRate, Pseq([1, 20, 70, 10, 3, 25, 25], 1),
			\trigRateLag, Pseq([0, 3, 1, 2, 3, 3, 3], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rate, Pseq([0.5, 1, 2.2, 7, 2, 1, 1], 1),
			\rateLag, Pseq([0, 5, 7, 2, 0, 0, 0], 1),
			\rateCurve, Pseq([0, 0, 0.5, 0, 0, 0, 0], 1),
			\rateRandomness, Pseq([1, 1, 4, 0, 20, 50, 20], 1),
			\rateRandomnessLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rateRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([20000, 20000, 20000, 20000, 10000, 10000, 10000], 1),
			\lpLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 10, 10, 10, 10, 10, 500], 1),
			\hpLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0.3, 0, 0.5, 0.3, 0, 0.4, 0], 1),
			\amp, Pseq([0, 0, 0, 1, 1, 0, 0], 1),
			\ampLag, Pseq([0, 3, 0, 4, 6, 0, 2], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\verbMix, Pseq([0, 0, 0, 0, 1, 1, 1], 1),
			\verbMixLag, Pseq([0, 0, 0, 2, 2, 6, 0], 1),
			\verbMixCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\verbRoom, Pseq([0, 0, 0, 0.5, 0.5, 0.5, 0.5], 1),
			\verbDamp, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\out,0,
		),
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([1/16, 5, 5, 5, 5, 6, 12], 1),
            \gate, Pseq([1, 1, 1, 1, 1, 0, 0], 1),
			\attack, Pseq([0, 0, 0, 0, 1, 0, 0], 1),
			\release, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\posLo, Pseq([0.2, 0.2, 0.1, 0, 0, 0, 0], 1),
			\posHi, Pseq([0.9, 0.9, 0.4, 0.5, 0.5, 1, 1], 1),
			\posRateE, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\posRateM, Pseq([2, 3, -0.01, -1, 3, 2, 2], 1),
			\posRateMLag, Pseq([0, 4, 0, 0, 0, 0, 0], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\overlap, Pseq([2, 40, 10, 10, 30, 10, 100], 1),
			\overlapLag, Pseq([0, 0, 0, 2, 0, 0, 0], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\overlapRandomness, Pseq([40, 10, 0, 1, 0, 0, 0],1),
			\overlapRandomnessLag, Pseq([0, 3, 3, 0, 0, 0, 0],1),
			\overlapRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0, 0],1),
			\trigRate, Pseq([50, 20, 5, 10, 25, 250, 25], 1),
			\trigRateLag, Pseq([0, 0, 1, 2, 3, 3, 3], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rate, Pseq([2, 0.85, 5.7, 3.7, -0.85, 15, 1], 1),
			\rateLag, Pseq([0, 3, 7, 2, 0, 0, 0], 1),
			\rateCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rateRandomness, Pseq([1, 0, 0.3, 2, 25, 25, 20], 1),
			\rateRandomnessLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\rateRandomnessCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([20000, 20000, 20000, 20000, 1000, 10000, 10000], 1),
			\lpLag, Pseq([0, 0, 0, 0, 3, 0, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 10, 500, 1000, 10, 10, 10], 1),
			\hpLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0.3, 0, 0, 0.2, 0, 0.4, 0], 1),
			\amp, Pseq([0, 0, 0, 0, 1, 0, 0], 1),
			\ampLag, Pseq([0, 0, 4, 5, 1/16, 3, 9], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\verbMix, Pseq([0, 0, 0.5, 0.5, 0, 0, 0], 1),
			\verbMixLag, Pseq([0, 0, 0.5, 0.5, 0, 0, 0], 1),
			\verbMixCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\verbRoom, Pseq([0, 0, 0.5, 0.5, 0.5, 0.5, 1], 1),
			\verbDamp, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			\out,0,
		),
	])
));
);

/*
///////////////////////
//    SCORE INIT
///////////////////////

(
Pdef(\sceneX, Pdef(\partX,
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