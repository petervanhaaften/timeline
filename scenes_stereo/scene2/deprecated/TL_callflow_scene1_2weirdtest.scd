//
//first working voice2music composition for 'the timeline' project
//peter van haaften, january 2020
//


~callflow.play
~callflow.stop
~zebra.reset
a.stop
~zebra.play
~zebra.stop
~zebra.free
CmdPeriod.run
s.freeAll;
(
~callflow = Routine {


	// # flag for telephone mic gate [ non-positive value opens gate ]
	~micGate = 1;


	(
		/////////////////////////
		// VOICE INTRO SYNTHDEF
		/////////////////////////

		(
			SynthDef("bufferplay",{ arg out = 0, bufnum;
				Out.ar( out,
					PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
				)
			}
			).add;
			e = Buffer.read(s, ~operatorwav);
		);

		/////////////////////////
		// VOICE ERROR SYNTHDEF
		/////////////////////////

		(
			SynthDef("bufferplay",{ arg out = 0, bufnum;
				Out.ar( out,
					PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
				)
			}
			).add;
			o = Buffer.read(s, ~operatorerrorwav);
		);

		///////////////////////
		//    SINE TONE BEEP
		///////////////////////
		(
			SynthDef(\sinbeep, {|freq = 440, out, gate = 1, attack = 0, sustain = 1, release = 1, amp = 1|
				var env = Linen.kr(gate, attack, sustain, release) * amp;
				Out.ar(out, SinOsc.ar(freq, 0,0.2) * env)
			}
			).add;
		);
	);

	///////////////////////
	// ERROR SCORE PLAYBACK
	///////////////////////
	(
		~errorplayback = Routine.new( {

			//var k set to 1 to indicate currently going through sorry process
			k = 1;
			//clear buffer!!
			"kVALUEbegrec : ".post; k.postln;
			//b.free;
			//b = Buffer.alloc(s, 100 * s.sampleRate);
			o.play;
			6.22.wait;
			o.stop;
			"// beep_error".postln;
			f = Pmono(\sinbeep, \dur, 1, \amp, 1, \attack, 0, \sustain, 1, \release, 0, \freq, 440).play;
			//wait until beep is finished
			2.wait;
			f.stop;
			//Require(~timescore);
			//start global score
			1.wait;
			~trigger.set(\micGate, 1);
			~recordvoice.play;
			//u.play;
			k = 0;
			d = 0;
		};);
	);

	///////////////////////
	// VOICE SCORE PLAYBACK
	///////////////////////
	(
		~voiceplayback_pt2 = Routine.new( {
			//reset crap
			//b.free;
			//b = Buffer.alloc(s, 100 * s.sampleRate);
			"// beep2".postln;
			f = Pmono(\sinbeep, \dur, 1, \amp, 0.8, \attack, 0, \sustain, 1, \release, 0, \freq, 440).play;
			//wait until beep is finished
			1.5.wait;
			f.stop;
			//Require(~timescore);
			//start global score
			1.wait;
			"crappppp".postln;
			u.play;
			//~recordvoice.play;
		};);
	);

	///////////////////////
	// THE GLOBAL SCORE
	///////////////////////
	(
		u = Routine {
			Require(~timescore);
			//play master score
			p = Pdef(\part, Pdef(\main,
				Pseq([
					//start score
					Pfindur(100, Pdef(\part3)),
				],1),
			)).play;
		};
	);

	///////////////////////
	// MASTER SCORE PLAYER
	///////////////////////
	(
		~zebra = Routine {
			//the synthesizer for this score
			Require(~gransyn1);
			//voice rec synthdef
			Require(~simplerec);
			//voice rec logic, interacts with synthdef
			Require(~simplelogic);


			//reset crap
			b.free;
			b = Buffer.alloc(s, 100 * s.sampleRate);
			//
			//DEAL ALLOWS AUDIO TO BOOT
			//
			0.wait;
			"// operator speaks".postln;
			a = Pmono(\bufferplay, \bufnum, e.bufnum, \dur, 1).play;
			//wait until audio file is finished (speakoneword, 5.9sec)
			//should programatically determine the audio file length
			6.5.wait;
			"// beep1".postln;
			f = Pmono(\sinbeep, \dur, 1, \amp, 0.8, \attack, 0, \sustain, 1, \release, 0, \freq, 440).play;
			//wait until beep is finished
			1.5.wait;
			f.stop;
			0.5.wait;
			~recordvoice.play;
		};
	);
};
)
//r.play;
//b.play
//b.plot;
//u.play;

//~recordvoice.reset
//~recordvoice.play


