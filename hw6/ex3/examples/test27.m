(* 27 *)

let val k = malloc 2 in
 (fn y => fn z => (!y) z)
  (malloc (fn x => x := (!x + 1))) k;
 write ((!k))
end
