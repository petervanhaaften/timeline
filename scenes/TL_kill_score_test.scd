(
Pdef(\part, Pdef(\part3,
	d = NetAddr("127.0.0.1", NetAddr.langPort);
	d.sendMsg("/timeline/scene", 9999);
	d.free;
    ));
);

a = Pfunc({
	d = NetAddr("127.0.0.1", NetAddr.langPort);
	d.sendMsg("/timeline/scene", 9999);
	d.free;
})

a.next;
a.reset

Pbindef(\timeline, \scene, 9999).play;

Pfindur(1, Pdef(\part3));