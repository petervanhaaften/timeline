//
//first working voice2music composition for 'the timeline' project
//peter van haaften, january 2020
//
//~callflow.reset
//~callflow.play
//CmdPeriod.run
~playscore.play;
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
		// VOICE outro SYNTHDEF
		/////////////////////////

		(
			SynthDef("bufferplay",{ arg out = 0, bufnum;
				Out.ar( out,
					PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
				)
			}
			).add;
			z = Buffer.read(s, ~operatorclosewav);
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

		/////////////////////////
		// GOODBYE SYNTHDEF
		/////////////////////////

		(
			SynthDef("bufferplay",{ arg out = 0, bufnum;
				Out.ar( out,
					PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
				)
			}
			).add;
			g = Buffer.read(s, ~goodbyewav);
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
			//"kVALUEbegrec : ".post; k.postln;
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
			~playscore.reset;
			1.wait;
			~playscore.play;
			//~recordvoice.play;
		};);
	);

	///////////////////////
	// THE GLOBAL SCORE
	///////////////////////
	(
		~playscore = Routine {
			Require(~timescore);
			//play master score
			p = Pdef(\part, Pdef(\main,
				Pseq([
					//start score
					Pfindur(30, Pdef(\part1)),
					Pfindur(24, Pdef(\part2)),
					//PLAY GOODBYE
					Pfindur(2,Pmono(\bufferplay, \bufnum, g.bufnum, \dur, 1)),
					Pfunc({~net.sendMsg("/timeline/scene", 9999)}).collect;
					],1),
			)).play;
			"SCORE FINISHED".postln;
		};
	);


	///////////////////////
	// MASTER SCORE PLAYER
	///////////////////////
	(
		z = Routine {
			//the synthesizer for this score
			Require(~gransyn1);
			//voice rec synthdef
			Require(~simplerec);
			//voice rec logic, interacts with synthdef
			Require(~simplelogic);
			//score for scene
			//Require();

			//reset crap
			b.free;
			b = Buffer.alloc(s, 100 * s.sampleRate);
			//part
			//DEAL ALLOWS AUDIO TO BOOT
			//
			//wait for ringing to complete
			1.wait;
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
	).play;
};
)
//r.play;
//b.play
//b.plot;
//g.play

//b.play
//~playscore.play
//~playscore.reset