

///////////////////////
//    SCORE BLOCK 3
///////////////////////

(
Pdef(\part, Pdef(\part3,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([8, 3, 8, 1, 2, 3, 18, 10, 15], 1),
				\attack, 3,
				\release, Pseq([4, 4, 8, 3, 4, 4, 4, 4, 10], 1),
				\posLo, 0.4,
				\posHi, 0.70,
				\posRateE, 0,
				\posRateM, Pseq([0.002, 0.002, 0.029, 0.005, 0.002, 0.002, 0.002, 0.002, 0.008], 1),
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([2, 2, 1, 1, 3, 1, 1, 1, 10], 1),
				\overlapLag, 1,
				\overlapCurve, 1,
				\trigRate, Pseq([9, 0, 5, 0, 0, 0, 9, 0, 50], 1),
				\trigRateLag, Pseq([2, 2, 2, 2, 2, 2, 0, 2, 2], 1),
				\trigRateCurve, 0.5,
				\rate, Pseq([0.4, 0.5, 0.5, 0.8, 2, 0.4, 0.4, 1], 1),
				\rateLag, Pseq([2, 2, 2, 2, 2, 1, 2, 2, 10], 1),
				\rateCurve, -1,
				\bpRQ, 0.25,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 50,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi,Pseq([2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 15000], 1),
				\bpHiLag, Pseq([1, 1, 1, 1, 1, 1, 1, 1, 20], 1),
				\bpHiCurve, 1,
				\panmax, 0,
			    \amp, Pseq([0.8, 0.8, 0.5, 1, 0.5, 0.8, 6, 0.8, 0.8], 1),
			    //amp, 0,
			),
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([8, 1, 2, 4, 4, 3, 20 ], 1),
				\attack, 3,
				\release, 7,
				\posLo, 0.2,
				\posHi, 0.70,
				\posRateE, 0,
				\posRateM, 0.001,
				\posRateMLag, 3,
				\posRateMCurve, 1,
				\overlap, Pseq([1, 2, 1, 10, 15, 30, 2], 1),
				\overlapLag, 1,
				\overlapCurve, 1,
				\trigRate, Pseq([3, 30, 0, 2, 0, 20, 50], 1),
				\trigRateLag, 1,
				\trigRateCurve, 0.5,
				\rate, Pseq([2, 2, 3, 5, 2, 10, 50], 1),
				\rateLag, Pseq([1, 3, 1, 1, 1, 1, 15], 1),
				\rateCurve, -1,
				\bpRQ, 0.25,
				\bpRQLag, 0.25,
				\bpRQCurve, 1,
				\bpLo, 50,
				\bpLoLag, 50,
				\bpLoCurve, 0,
				\bpHi, 20000,
				\bpHiLag, 0,
				\bpHiCurve, 1,
				\panmax, 0,
			    \amp, Pseq([0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5], 1),
			    //\amp, 0,
			),
	])
)).play;
);

///////////////////////
//    SCORE INIT
///////////////////////

(
Pdef(\part, Pdef(\part3,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([1], 1),
				\attack, Pseq([0], 1),
				\release, Pseq([1], 1),
				\posLo, Pseq([0], 1),
				\posHi, Pseq([1], 1),
				\posRateE, Pseq([0], 1),
				\posRateM, Pseq([1], 1),
				\posRateMLag, Pseq([3], 1),
				\posRateMCurve, Pseq([1], 1),
				\overlap, Pseq([3], 1),
				\overlapLag, Pseq([1], 1),
				\overlapCurve, Pseq([1], 1),
				\trigRate, Pseq([1], 1),
				\trigRateLag, Pseq([5], 1),
				\trigRateCurve, Pseq([0.5], 1),
				\rate, Pseq([1], 1),
				\rateLag, Pseq([1], 1),
				\rateCurve, Pseq([-1], 1),
				\bpRQ, Pseq([0.25], 1),
				\bpRQLag, Pseq([0.25], 1),
				\bpRQCurve, Pseq([1], 1),
				\bpLo, Pseq([50], 1),
				\bpLoLag, Pseq([50], 1),
				\bpLoCurve, Pseq([0], 1),
				\bpHi,Pseq([1], 1),
				\bpHiLag, Pseq([1], 1),
				\bpHiCurve, Pseq([1], 1),
				\panmax, Pseq([0], 1),
			    \amp, Pseq([0.8], 1),
			    //amp, 0,
			)
	])
)).play;
);


//var mintime, var maxtime, var recordedtime, var pausewaittime
//if recorded or paused. . .
//////if recordtime > maxtime, then STOP
//if paused. . .
//////if (recordtime > mintime) && (pausewaittime > 4) then STOP
//////if (recordtime > mintime) && (pausewaittime < 5) then STILL ALLOW RECORDING POTENTIAL
