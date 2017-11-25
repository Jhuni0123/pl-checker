(* testcase 11 : ifzero *)

ifzero ((fn x => x + 1) (-1)) then ((fn y => y + 3) 0) else 0
