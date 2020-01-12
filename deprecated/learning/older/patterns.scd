a = Routine {
    var    i = 0;
    loop {
        i.yield;
        i = i + 1;
    };
};

a.nextN(1);



p = Pseries(0, 3, 10);
p.next;    // always returns the Pseries, not actual numbers

q = p.asStream;
q.next;    // calling this repeatedly gets the desired increasing integers

r = p.asStream;
r.next;    // starts from zero, even though q already gave out some numbers

q.next;    // resumes where q left off, with no effect from getting values from r

[q.next, r.next]    // and so on...




