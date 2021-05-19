actor {
};

module {
    public class Class(){};
};

object {
};

object Object {
};

object Named = {
};

object WithFields {
    public stable let f0 = null;
    private stable let f1 = null;
    system stable let f2 = null;
};

// object body

actor CanHaveSeveralSemis{
    func f(){};;;;;;;;;;;
};

actor LastSemiOptional {
    func f(){}
};
