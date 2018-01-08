(* 22 *)

let val x = malloc 1 in
  x := (5, 6);
  write ((!x).2)
end
