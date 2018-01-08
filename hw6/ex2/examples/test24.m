(* 24. Partial application *)

(fn f => f 10) ((fn x => (fn y => x + y)) 5)
