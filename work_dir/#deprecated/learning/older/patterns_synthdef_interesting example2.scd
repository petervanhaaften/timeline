//using Pspawner

(
t = TempoClock(1);

p = Pspawner { |sp|
	sp.seq(
		Pbind(
			\degree, Pn(0, 4),
			\dur, 0.2
		)
	);
	sp.wait(0.3);
	sp.seq(
		Pbind(
			\degree, Pn(2, 2),
			\dur, 0.2
		)
	);
	sp.wait(0.5);
	sp.seq(
		Pbind(
			\degree, Pn(9, 4),
			\dur, 0.2
		)
	);
}.play(t)
)



////Concerning the tempo fade, you could do it by using one pattern changing the tempo clock of the other one. This solution is a bit lazy (here changing every 0.02 seconds), but practically it works. Note that Pseg is also a very useful Pattern, you can define curve types e.g. which is nice to find out convincing transitions.

(
TempoClock.default.tempo = 1;
t = TempoClock(1);

p = Pspawner { |sp| loop {
	sp.seq(
		Pbind(
			\degree, Pn(0, 4),
			\dur, 0.2
		)
	);
	sp.wait(0.3);
	sp.seq(
		Pbind(
			\degree, Pn(2, 2),
			\dur, 0.2
		)
	);
	sp.wait(0.5);
	sp.seq(
		Pbind(
			\degree, Pn(3, 3),
			\dur, 0.2
		)
	);
} };

q = Pbind(
	\dur, 0.02,
	\type, \rest,
	\newTempo, Pseg(Pseq([1, 1.5], inf), Pseq([5, 3, 2], inf)),
	\do, Pfunc { |ev| t.tempo = ev[\newTempo] }
);
)

(
x = p.play(t);
y = q.play;
)

(
x.stop;
y.stop;
)

//Besides you could do it also with multiplying durations with a factor, but this is probably less comfortable here, as the factor would have to be written at several places.
//
//Other than that the tempo fade question has just been posed 5 days ago, and Simon has pointed to a worked-out soluion by Fredrik (which I haven’t tried yet):