class Smallest() {};

shared query class SharedQuery<A,B>(): Interface {};

class WithFields() {
    public stable let f0 = null;
    private stable let f1 = null;
    system stable let f2 = null;
};

class WithEquals() = {
    let x = null;
};


class WithEquals() = Id {
    let x = null;
};
