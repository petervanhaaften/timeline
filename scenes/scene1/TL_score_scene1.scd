///////////////////////
//  SCENE 1 / PART 1
///////////////////////

(
Pdef(\scene1, Pdef(\part1,
	Ppar([
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([5, 10, 3, 3, 4, 1], 1),
			\attack, Pseq([0, 0, 0, 0, 0, 0], 1),
			\release, Pseq([0, 0, 0, 0, 0, 0], 1),
			\posLo, Pseq([0, 0.5, 0.5, 0.5, 0.5, 0], 1),
			\posHi, Pseq([1, 1, 1, 1, 1, 1], 1),
			\posRateE, Pseq([0.1, 0.1, 0, 0, 0, 0], 1),
			\posRateM, Pseq([0.1, 0.1, 0.2, 0.2, 0.2, 1], 1),
			\posRateMLag, Pseq([0, 0, 0, 0, 0, 0], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\overlap, Pseq([1.5, 2.5, 1, 1, 1, 1], 1),
			\overlapLag, Pseq([0, 0, 0, 0, 0, 0], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\trigRate, Pseq([1, 1, 100, 1, 1, 10], 1),
			\trigRateLag, Pseq([0, 0, 3, 3, 3, 1], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\rate, Pseq([-1.5, -1.3, -1.7, -1.7, -2.7, 1], 1),
			\rateLag, Pseq([0, 2, 3, 3, 3, 1], 1),
			\rateCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([20000, 2000, 5000, 5000, 20000], 1),
			\lpLag, Pseq([0, 7, 2, 0, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 10, 10, 10, 10], 1),
			\hpLag, Pseq([0, 0, 0, 0, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0, 0.3, 0.5, 0, 0, 0], 1),
			\amp, Pseq([1, 1, 1, 1, 0, 0], 1),
			\ampLag, Pseq([0, 0, 0, 0, 1/16, 0], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0,], 1),
		),
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([9, 6, 6, 7, 3, 1], 1),
			\attack, Pseq([0, 0, 0, 0, 0, 0], 1),
			\release, Pseq([0, 0, 0, 0, 0, 0], 1),
			\posLo, Pseq([0, 0.5, 0.5, 0.5, 0.5, 0], 1),
			\posHi, Pseq([1, 1, 1, 1, 1, 0.2], 1),
			\posRateE, Pseq([0.1, 0.1, 0, 0, 0, 0], 1),
			\posRateM, Pseq([0.1, 0.05, 0.2, 1, 1, 1], 1),
			\posRateMLag, Pseq([0, 0, 0, 5, 1, 1], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\overlap, Pseq([1.5, 3, 1, 50, 20, 1], 1),
			\overlapLag, Pseq([0, 0, 0, 0, 0, 0], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\trigRate, Pseq([1, 5, 1, 10, 5, 5], 1),
			\trigRateLag, Pseq([0, 3, 4, 6, 3, 3], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0.5, 0.5, 0.5], 1),
			\rate, Pseq([-1.5, -4.3, -2.7, 1.5, 2, 1], 1),
			\rateLag, Pseq([0, 2, 3, 3, 3, 3], 1),
			\rateCurve, Pseq([0, 0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([20000, 2500, 10000, 10000, 10000], 1),
			\lpLag, Pseq([0, 3, 3, 0, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 1000, 1000, 500, 500], 1),
			\hpLag, Pseq([0, 3, 0, 0, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0, 0.3, 0, 0.3, 0, 0], 1),
			\amp, Pseq([0, 1, 1, 1, 0, 0], 1),
			\ampLag, Pseq([0, 4, 0, 0, 1, 1], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0], 1),
		),
	])
));
);

///////////////////////
//  SCENE 1 / PART 2
///////////////////////

(
Pdef(\scene1, Pdef(\part2,
	Ppar([
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([3, 8, 3, 5, 5], 1),
			\attack, Pseq([0, 0, 0, 0, 0], 1),
			\release, Pseq([0, 0, 0, 0, 0], 1),
			\posLo, Pseq([0, 0.5, 0.5, 0.5, 0.5], 1),
			\posHi, Pseq([1, 1, 1, 1, 1], 1),
			\posRateE, Pseq([0.1, 0.1, 0, 0, 0], 1),
			\posRateM, Pseq([0.1, 0.001, 0.5, 1, 0.2], 1),
			\posRateMLag, Pseq([0, 0, 0, 0, 0], 1),
			\posRateMCurve, Pseq([0, 0, 0, 0, 0], 1),
			\overlap, Pseq([1.5, 2.5, 1, 1, 1], 1),
			\overlapLag, Pseq([0, 0, 0, 0, 0], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0], 1),
			\trigRate, Pseq([1, 5, 10, 30, 30], 1),
			\trigRateLag, Pseq([0, 2, 3, 3, 3], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0, 0], 1),
			\rate, Pseq([-1.5, -2, -3, 5, -2.7], 1),
			\rateLag, Pseq([0, 2, 3, 5, 3], 1),
			\rateCurve, Pseq([0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([20000,20000, 20000, 8000, 20000], 1),
			\lpLag, Pseq([0, 0, 0, 0, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 10, 10, 10, 10], 1),
			\hpLag, Pseq([0, 0, 3, 3, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0, 0.1, 0, 0, 0], 1),
			\amp, Pseq([1, 1, 1, 1, 0], 1),
			\ampLag, Pseq([0, 0, 0, 0, 2], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0], 1),
		),
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([7, 4, 6, 7, 5], 1),
			\attack, Pseq([0, 0, 0, 0, 0], 1),
			\release, Pseq([0, 0, 0, 0, 0], 1),
			\posLo, Pseq([0, 0.5, 0.5, 0.5, 0.5], 1),
			\posHi, Pseq([1, 1, 1, 1, 1], 1),
			\posRateE, Pseq([0.1, 0.1, 0, 0, 0], 1),
			\posRateM, Pseq([0.1, 0.05, 1, 0.02, 0.02], 1),
			\posRateMLag, Pseq([0, 0, 0, 3, 0], 1),
			\posRateMCurve, Pseq([0, 0, 1, 0, 0], 1),
			\overlap, Pseq([1.5, 3, 1, 7, 3], 1),
			\overlapLag, Pseq([0, 0, 0, 0, 0], 1),
			\overlapCurve, Pseq([0, 0, 0, 0, 0], 1),
			\trigRate, Pseq([1, 5, 30, 3, 100], 1),
			\trigRateLag, Pseq([0, 3, 5, 4, 3], 1),
			\trigRateCurve, Pseq([0, 0, 0, 0.5, 0.5], 1),
			\rate, Pseq([-1.5, -4.3, -2.7, -3.7, -0.7], 1),
			\rateLag, Pseq([0, 2, 3, 3, 3], 1),
			\rateCurve, Pseq([0, 0, 0, 0, 0], 1),
			\lpFreq, Pseq([20000, 20000, 5000, 5000, 5000], 1),
			\lpLag, Pseq([0, 0, 0, 0, 0], 1),
			\lpCurve, Pseq([0, 0, 0, 0, 0], 1),
			\hpFreq,Pseq([10, 10, 1000, 1000, 1000], 1),
			\hpLag, Pseq([0, 0, 3, 0, 0], 1),
			\hpCurve, Pseq([0, 0, 0, 0, 0], 1),
			\panMax, Pseq([0, 0.3, 0, 0, 0], 1),
			\amp, Pseq([0, 1, 1, 1, 0], 1),
			\ampLag, Pseq([0, 4, 0, 3, 3], 1),
			\ampCurve, Pseq([0, 0, 0, 0, 0], 1),
		),
	])
));
);


///////////////////////
//    SCORE PLAYER
///////////////////////

~myscore = Pdef(\scene1, Pdef(\main,
	Pseq([
		//start score
		Pfindur(33, Pdef(\part1)),
		Pfindur(23, Pdef(\part2)),
		Pfunc({~net.sendMsg('/timeline/scene',9999, ~telephoneNum, ~asteriskChannel, ~wavPin)}).collect;
	],1),
));

/*
///////////////////////
//    SCORE INIT
///////////////////////

(
Pdef(\scene1, Pdef(\part3,
	Ppar([
		Pmono(
			\gransyn,
			\soundBuf,~sndbuf,
			\dur, Pseq([1], 1),
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
			\trigRate, Pseq([1], 1),
			\trigRateLag, Pseq([0], 1),
			\trigRateCurve, Pseq([0], 1),
			\rate, Pseq([1], 1),
			\rateLag, Pseq([0], 1),
			\rateCurve, Pseq([0], 1),
			\lpFreq, Pseq([20000], 1),
			\lpLag, Pseq([0], 1),
			\lpCurve, Pseq([0], 1),
			\hpFreq,Pseq([10], 1),
			\hpLag, Pseq([0], 1),
			\hpCurve, Pseq([0], 1),
			\panMax, Pseq([0], 1),
			\amp, Pseq([1], 1),
			\ampLag, Pseq([0], 1),
			\ampCurve, Pseq([0], 1),
			\out,0,
		),

	])
));
);



///////////////////////
//    SCORE INIT
///////////////////////

(
Pdef(\part, Pdef(\part1,
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
			\lpFreq, Pseq([20000], 1),
			\lpLag, Pseq([0], 1),
			\lpCurve, Pseq([0], 1),
			\hpFreq,Pseq([10], 1),
			\hpLag, Pseq([0], 1),
			\hpCurve, Pseq([0], 1),
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
));
);

*/