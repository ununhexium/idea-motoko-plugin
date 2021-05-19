switch (a) {
  case (true) { a; };
  case (null) {
    b;
  };
};

func includes(x: UserId, xs: [UserId]): Bool {
  func isX(y: UserId): Bool { x == y };
  switch ( Array.find<UserId>(xs, isX) ) {
    case (null) { false };
    case (_) { true };
  };
};
