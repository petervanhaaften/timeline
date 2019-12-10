
(

// register to receive a trigger message

o = OSCFunc({ arg msg,time,address,receivedPort;
var b;
	b = if (\val == 5, { "test1".postln }, { "test2".postln }

"received trigger!".postln;

Post << msg <<nl;

}, //Function

'/tr',	//OSC message address name,

s.addr //NetAddr (where the message will arrive from). Leave this nil if you want to allow it to come from anywhere (for example, if another application is sending from a variable or unknown port)

);


//send a trigger message whenever the impulse fires (once every 2 seconds)

{SendTrig.ar(in: Impulse.ar(0.5), id: 0.0, value: 5.0)}.play;

)




//keep it running and now run these lines:

(

p= OSCFunc({ arg time,responder,msg;

"new reaction!".postln;

Post << time <<nl;


},'/tr',s.addr);

)

(
var a = 1, b;
b = if (a < 2, { q.set(\trig, 1) },{ q.set(\trig, 0) });
b.postln;
)