
(
// register to receive a trigger message
o = OSCFunc({ arg msg,time,address,receivedPort;
	//var b, a = 5;
	//b = if (\val == 5, { "test1".postln }, { "test2".postln });
		"received trigger!".postln;

		Post << msg <<nl;
}, '/tr', s.addr
);


//send a trigger message whenever the impulse fires (once every 2 seconds)

{SendTrig.ar(in: Impulse.ar(0.5), id: 0, value: 5)}.play;

)


//keep it running and now run these lines:

(
p= OSCFunc({ arg time,responder,msg;
	var b, a = 4;
	b = if (msg[1] == 5, { "test1".postln }, { "test2".postln }); // true -- false
	//msg[1].postln;
	"new reaction!".postln;
	Post << time <<nl;
},'/tr',s.addr);
)

(
var a = 1, b;
b = if (a < 2, { q.set(\trig, 1) },{ q.set(\trig, 0) });
b.postln;
)