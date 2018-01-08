(* 21. high-order function *)

(fn f => (fn g => g (f (3, 4)))) (fn x => x.1 + 2) (fn x => x + 1)
