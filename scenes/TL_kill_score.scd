(
Pdef(\part, Pdef(\part3,
	d = NetAddr("127.0.0.1", NetAddr.langPort);
	d.sendMsg("/timeline/scene", 9999);
	d.free;
    ));
);
