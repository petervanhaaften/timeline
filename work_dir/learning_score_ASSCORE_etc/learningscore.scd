//Very large SynthDefs will need to be written to disk and not rendered as OSC messages in the Score. The SuperCollider language client limits the size of a single OSC message to 65516 bytes. If a SynthDef exceeds this limit, creation of the Score object will fail with the error message ERROR: makeSynthMsgWithTags: buffer overflow. Resolve this error message as follows: -- see score manual
￼


SynthDef(\diracs, { |out = 0, duration = 60, amp = 0.1, freq = 100|
    Out.ar(out, SinOsc.ar(freq: freq, phase: 0.0, mul: 1.0, add: 0.0))
}).store;

p = Pbind(\instrument, \diracs, \duration, 0.5, \dur, Pn(1, 1), \amp, 0.3).play

e = Pbind(
    \degree, Pseq((0..12), inf),
    \dur, 0.2,
    \instrument, \cfstring1
).play; // returns an EventStream
)

////////

//To use Buffers and Buses, it is recommended to avoid conflicts with real-time server instances by creating a Server object just for the non-realtime process. It is not necessary to boot this server, only to use its allocators. After rendering, you may safely remove the server instance.

(
var server = Server(\nrt,
    options: ServerOptions.new
    .numOutputBusChannels_(2)
    .numInputBusChannels_(2)
),
def = SynthDef(\buf1, { |out, bufnum, rate = 1, time = 0.1, start = 0, amp = 0.1|
    var eg = EnvGen.kr(Env.perc(0.01, time), doneAction: 2),
    sig = PlayBuf.ar(1, bufnum, rate, startPos: start);
    Out.ar(out, (sig * (eg * amp)).dup);
}),
// the pattern needs a placeholder for the buffer
buf = Buffer.new(server, 0, 1);
​
def.add;  // the pattern needs the def in the SynthDescLib
​
x = Pbind(
    \instrument, \buf1,
    \bufnum, buf,
    \rate, Pexprand(0.5, 2, inf),
    \start, Pwhite(0, 50000, inf),
    \time, 0.1,
    \dur, Pexprand(0.05, 0.5, inf),
    \legato, 3,
).asScore(duration: 20, timeOffset: 0.001);
​
// the score also needs the def and buffer
x.add([0.0, [\d_recv, def.asBytes]]);
x.add([0.0, buf.allocReadMsg(Platform.resourceDir +/+ "sounds/a11wlk01.wav")]);
x.sort;
​
x.recordNRT(
    outputFilePath: "~/nrt.aiff".standardizePath,
    sampleRate: 44100,
    headerFormat: "AIFF",
    sampleFormat: "int16",
    options: server.options,
    duration: 20
);
​
server.remove;
)