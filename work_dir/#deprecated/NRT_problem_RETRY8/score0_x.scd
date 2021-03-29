(
///////////////////////
//    SCORE PLAYER
///////////////////////


//~pattern = Pdef(\scene0, Pdef(\main,
//	Pseq([
//		//start score
//		Pfindur(17, Pdef(\part1)),
//		Pfindur(20, Pdef(\part2)),
//		Pfindur(22, Pdef(\part3)),
//	],1),
//));




///////////////////////
//   SCENE 0 / PART 1
///////////////////////

(
Pdef(\scene0, Pdef(\part1,
	Ppar([
			Pmono(
				\gransyn,
			    \soundBuf, ~sndbuf,
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
			    \amp, Pseq([0, 1, 0, 0], 1),
			    \ampLag, Pseq([3, 1, 1/2, 4], 1),
			    \ampCurve, Pseq([0, 0, 0, 0], 1),
			),
	])
));
);


///////////////////////
//   SCENE 0 / PART 2
///////////////////////

(
Pdef(\scene0, Pdef(\part2,
	Ppar([
			Pmono(
				\gransyn,
			    \soundBuf, ~sndbuf,
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
			    \amp, Pseq([0, 1, 1, 0], 1),
				\ampLag, Pseq([3, 1, 5, 0], 1),
			    \ampCurve, Pseq([0, 0, 0, 0], 1),
			),
			Pmono(
				\gransyn,
			    \soundBuf, ~sndbuf,
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
			    \amp, Pseq([0, 0, 1, 2], 1),
				\ampLag, Pseq([0, 3, 2, 2], 1),
			    \ampCurve, Pseq([0, 0, 0, 0.5], 1),
			),
	])
));
);


///////////////////////
//   SCENE 0 / PART 3
///////////////////////

(
Pdef(\scene0, Pdef(\part3,
	Ppar([
			Pmono(
				\gransyn,
			    \soundBuf, ~sndbuf,
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
			    \amp, Pseq([0, 1, 0, 0], 1),
			    \ampLag, Pseq([3, 1, 3, 4], 1),
			    \ampCurve, Pseq([0, 0, 0.5, 0], 1),
			),
			Pmono(
				\gransyn,
			    \soundBuf, ~sndbuf,
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
			    \amp, Pseq([0, 1, 1, 0], 1),
				\ampLag, Pseq([0, 3, 1, 3], 1),
			    \ampCurve, Pseq([0, 0, 0.6, 0.5], 1),
			),
			Pmono(
				\gransyn,
			    \soundBuf, ~sndbuf,
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
			    \amp, Pseq([0, 1, 1, 1], 1),
				\ampLag, Pseq([0, 4, 2, 5], 1),
			    \ampCurve, Pseq([0, 0, 0, 1], 1),
			),
	])
));
);


)
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