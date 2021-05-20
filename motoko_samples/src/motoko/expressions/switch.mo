switch(call()) {
    case _ {};
};

switch (a) {
  case (true) { a; };
  case (null) {
    b;
  };
};


switch (a) {
  case (null) {} // no trailing semi
};

// switch can be empty, taken from motoko-base: None.mo
switch (x) {};
