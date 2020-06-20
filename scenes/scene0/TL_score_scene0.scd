///////////////////////
//    SCENE 0
///////////////////////

(
Pdef(\part, Pdef(\part1,
	Ppar([
			Pmono(
				\gran_1e,
			    \soundBuf, b.bufnum,
				\dur, Pseq([1, 5, 3, 5, 3, 12, 3], 1),
				\attack, Pseq([0, 1, 0, 0, 0, 0, 0], 1),
				\release, Pseq([0, 2, 2, 0, 0, 0, 0], 1),
				\posLo, Pseq([0.5, 0.1, 0.4, 0, 0, 0.2, 0.2], 1),
				\posHi, Pseq([0.9, 0.9, 0.8, 1, 1, 0.7, 0.4], 1),
				\posRateE, Pseq([0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01], 1),
				\posRateM, Pseq([0.002, 0.002, 0.002, 1, 1, 0.2, 0.2], 1),
				\posRateMLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
				\posRateMCurve, Pseq([1, 1, 1, 1, 1, 1, 1], 1),
				\overlap, Pseq([3, 3, 10, 1, 1, 25, 10], 1),
				\overlapLag, Pseq([1, 1, 1, 1, 1, 4, 1], 1),
				\overlapCurve, Pseq([1, 1, 1, 1, 1, 1, 1], 1),
				\trigRate, Pseq([100, 1, 5, 5, 5, 200, 10], 1),
				\trigRateLag, Pseq([1, 2, 1, 1, 1, 9, 1], 1),
				\trigRateCurve, Pseq([0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5], 1),
				\rate, Pseq([1.5, 1, 2, 1, 3, 3, 0.5], 1),
				\rateLag, Pseq([1, 2, 2, 2, 2, 1, 0.2], 1),
				\rateCurve, Pseq([1, 1, 1, 1, 1, 1, 1], 1),
				\bpRQ, Pseq([0.25, 0.5, 0.15, 0.15, 0.15, 0.25, 0.25], 1),
				\bpRQLag, Pseq([0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25], 1),
				\bpRQCurve, Pseq([1, 1, 1, 1, 1, 1, 1], 1),
				\bpLo, Pseq([50, 50, 50, 50, 50, 200, 50], 1),
				\bpLoLag, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
				\bpLoCurve, Pseq([0, 0, 0, 0, 0, 0, 0], 1),
			    \bpHi,Pseq([4000, 2000, 5000, 2000, 20000, 100, 5000], 1),
				\bpHiLag, Pseq([1, 1, 1, 1, 2, 2, 2], 1),
				\bpHiCurve, Pseq([1, 1, 1, 1, 1, 1, 1], 1),
			    \amp, Pseq([0, 0.8, 0, 1, 0, 0.6, 0], 1),
			    \ampLag, Pseq([1, 1, 2, 1, 2, 2, 2], 1),
				\ampCurve, Pseq([0.5, 0, 1, 1, 1, 0.5, 0.5], 1),
			)
	])
)).play;
);

(
Pdef(\part, Pdef(\part2,
	Ppar([
		Pmono(
			\gran_1e,
			\soundBuf, b.bufnum,
			\dur, Pseq([1, 8], 1),
			\attack, Pseq([0, 0], 1),
			\release, Pseq([0, 3], 1),
			\posLo, Pseq([0, 0.2], 1),
			\posHi, Pseq([1, 0.8], 1),
			\posRateE, Pseq([0.01, 0.01], 1),
			\posRateM, Pseq([1, 1], 1),
			\posRateMLag, Pseq([0, 0], 1),
			\posRateMCurve, Pseq([1,1], 1),
			\overlap, Pseq([1,1.5], 1),
			\overlapLag, Pseq([0,1], 1),
			\overlapCurve, Pseq([0,1], 1),
			\trigRate, Pseq([1,3], 1),
			\trigRateLag, Pseq([0,10], 1),
			\trigRateCurve, Pseq([0,1], 1),
			\rate, Pseq([1,1], 1),
			\rateLag, Pseq([0,1], 1),
			\rateCurve, Pseq([0,1], 1),
			\bpRQ, Pseq([0.25,0.25], 1),
			\bpRQLag, Pseq([0,0.25], 1),
			\bpRQCurve, Pseq([0,1], 1),
			\bpLo, Pseq([50,50], 1),
			\bpLoLag, Pseq([0,0], 1),
			\bpLoCurve, Pseq([0,0], 1),
			\bpHi,Pseq([1000,1000], 1),
			\bpHiLag, Pseq([0,1], 1),
			\bpHiCurve, Pseq([0,1], 1),
			\amp, Pseq([0,0.5], 1),
			\ampLag, Pseq([0,1], 1),
			\ampCurve, Pseq([0,0.5], 1),
		),
		Pmono(
			\gran_1e,
			\soundBuf, b.bufnum,
			\dur, Pseq([1.2,3,9,4], 1),
			\attack, Pseq([0,0,2,0], 1),
			\release, Pseq([0,3,4,0], 1),
			\posLo, Pseq([0, 0.2,0.2,0.5], 1),
			\posHi, Pseq([1, 0.8, 0.8,1], 1),
			\posRateE, Pseq([0.01, 0.01, 0.01,0.01], 1),
			\posRateM, Pseq([1, 1, 1,1], 1),
			\posRateMLag, Pseq([0, 0, 0,0], 1),
			\posRateMCurve, Pseq([0,1, 1,1], 1),
			\overlap, Pseq([1,1.5, 1.5,1], 1),
			\overlapLag, Pseq([0,1, 1,1], 1),
			\overlapCurve, Pseq([0,1, 1,1], 1),
			\trigRate, Pseq([1,3, 3,6], 1),
			\trigRateLag, Pseq([0,0, 5,4], 1),
			\trigRateCurve, Pseq([0,1, 1,0.8], 1),
			\rate, Pseq([1,1, 1.3,1.7], 1),
			\rateLag, Pseq([0,1, 3,3], 1),
			\rateCurve, Pseq([0,1, 1,1], 1),
			\bpRQ, Pseq([0.25,0.25, 0.25,0.25], 1),
			\bpRQLag, Pseq([0,0.25, 0.25,0.25], 1),
			\bpRQCurve, Pseq([1,1, 1,1], 1),
			\bpLo, Pseq([50,50,500,500], 1),
			\bpLoLag, Pseq([0,0,0,0], 1),
			\bpLoCurve, Pseq([1,1,1,1], 1),
			\bpHi,Pseq([0,0,10000,10000], 1),
			\bpHiLag, Pseq([0,0,0,0], 1),
			\bpHiCurve, Pseq([1,1,1,1], 1),
			\amp, Pseq([0,0,0.5,0.5], 1),
			\ampLag, Pseq([0,1,2,2], 1),
			\ampCurve, Pseq([0,0.5,0.5,0.5], 1),
		)
	])
)).play;


(
Pdef(\part, Pdef(\part3,
		n = NetAddr.new("127.0.0.1", NetAddr.langPort);
		n.sendMsg("/timeline/scene", "9999");
    ));
);//.play;

);

// Pdef(\part, Pdef(\main,
// 	Pseq([
// 		//start scores
// 		Pfindur(30, Pdef(\part1)),
// 		Pfindur(24, Pdef(\part2)),
// 	],1),
// )).play;

/*(
Pdef(\part, Pdef(\part3,
		n = NetAddr.new("127.0.0.1", NetAddr.langPort);
		n.sendMsg("/timeline/scene", "9999");
    ));
);*/
//b.play

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
				\attack, Pseq([0], 1),
				\release, Pseq([1], 1),
				\posLo, Pseq([0], 1),
				\posHi, Pseq([1], 1),
				\posRateE, Pseq([0], 1),
				\posRateM, Pseq([1], 1),
				\posRateMLag, Pseq([3], 1),
				\posRateMCurve, Pseq([1], 1),
				\overlap, Pseq([1], 1),
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
*/