type Type = Other;
type GenericType<A,B> = Other;
type GenericTypeWithConstraints<a <: A, b <: B> = Other;

type ErrorCode = {
  // Fatal error.
  #system_fatal;
  // Transient error.
  #system_transient;
  // Destination invalid.
  #destination_invalid;
  // Explicit reject by canister code.
  #canister_reject;
  // Canister trapped.
  #canister_error;
  // Future error code (with unrecognized numeric code)
  #future : Nat32;
};

type Person = { first : Text; last : Text };

type List<T> = ?(T, List<T>);

type Fst<T, U> = T;

type Ok<T> = Fst<Any, Ok<T>>;
