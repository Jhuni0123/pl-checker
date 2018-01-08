(* 25 *)

let val p = malloc (2, (malloc 3, 4)) in
  write (!p).1 + !((!p).2.1)
end
