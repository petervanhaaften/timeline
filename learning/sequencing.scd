
(
SynthDef(\event,{ arg freq=440, amp=0.5, pan=0.0;
	var env;
	env = EnvGen.ar(  Env([0,1,1,0],[0.01, 0.1, 0.2]),  doneAction:2);
	Out.ar(0,  Pan2.ar(Blip.ar(freq) * env * amp, pan))
}).add;
)

//test event sound
Synth(\event)	//accepts defaults. Event shouldn't hang around once envelope finished due to doneAction:2

//specifying values
Synth(\event,[\freq,120,\amp,0.8,\pan,1.0]) //pan 1.0 should send to right ear



(
{

	Synth(\event);
	1.0.wait;	//wait for 1 time unit of default tempo, will probably work out to 1 second
	Synth(\event,[\freq,120,\amp,0.8,\pan,1.0]);

}.fork; 	//.fork is a computer science term for setting a new process (sequence) in action
)

(
{

	Synth(\event);
	1.0.wait;
	Synth(\event);
	1.0.wait;
	Synth(\event);
	1.0.wait;
	Synth(\event);

}.fork;
)

(
{

	4.do {
		Synth(\event);
		1.0.wait;
	};

}.fork;
)

(
{

	8.do {
		//rrand(low, hi) gets a uniform random number in that range
		Synth(\event,[\freq, rrand(440,880)]);
		1.0.wait;
	};

}.fork;
)


(
{

	8.do {
		Synth(\event,[\freq, rrand(110,220)]);
		rrand(0.2,0.6).wait;
	};

	4.do {
		Synth(\event);
		0.25.wait;
	};

}.fork;

)


(
{

Synth(\event,[\freq, 60.midicps]);
0.2.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.25.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.2.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.25.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.25.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.25.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.15.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.15.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.15.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.15.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.15.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.15.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.15.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.15.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.15.wait;
Synth(\event,[\freq, rrand(110,220)]);
0.25.wait;

}.fork;
)









///// patterns sequences
// run this line

a = Pbind.new.play(quant:1.0);



a.stop;		// Or stop it with cmd+period;



// now run this line

Pbind(\freq, 440).play(quant:1.0);



// run this, go back and run some of the others at the same time

(

Pbind(

	\dur,0.125,

	\midinote, Pseq([0, 4, 0, 2, 3, 0, 0] + 60,inf),

	\amp, Prand([0.125, 0.2, 0.25],inf)

).play(quant:1.0)

)


