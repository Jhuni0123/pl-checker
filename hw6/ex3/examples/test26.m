(* 26 *)

let
  val x = (malloc (1, 2), 3)
in
 x.1 := (4, 5);
 write ((!(x.1)).2)
end
