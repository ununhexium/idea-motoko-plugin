func smallest() {};
func f(p0: Type0, p1: Type1): ReturnType { null };

shared query func sharedQuery(p0: Type0, p1: Type1): ReturnType { null };

func withNamedTypeParams<id0 <: Type0, id1 <: Type1>() { };
func withAnonymousTypeParams<Type0, Type1>() { };

func singleStatement() = "A";

actor Holder {
  public shared query func f() {};
  public query func f() {};
  public func f() {};
};

func f() = object {};
