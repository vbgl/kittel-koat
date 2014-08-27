model main {
  var A, B, C, D, E, F;
  states f10, f16, f25, f27, f30, f0;
  transition t0 := {
    from   := f10;
    to     := f16;
    guard  := 0 >= A && F > 0;
    action := B' = 0, C' = F, F' = ?;
  };
  transition t1 := {
    from   := f16;
    to     := f16;
    guard  := C > 0;
    action := F' = ?;
  };
  transition t2 := {
    from   := f25;
    to     := f25;
    guard  := true;
    action := F' = ?;
  };
  transition t3 := {
    from   := f27;
    to     := f30;
    guard  := true;
    action := F' = ?;
  };
  transition t4 := {
    from   := f16;
    to     := f10;
    guard  := 0 >= C;
    action := D' = 0, E' = F, A' = F, F' = ?;
  };
  transition t5 := {
    from   := f10;
    to     := f25;
    guard  := A > 0;
    action := F' = ?;
  };
  transition t6 := {
    from   := f0;
    to     := f10;
    guard  := true;
    action := B' = 0, D' = 0, E' = F, A' = F, F' = ?;
  };
}
strategy dumb {
  Region init := { state = f0 };
}
