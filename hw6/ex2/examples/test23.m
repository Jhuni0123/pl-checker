(* 23. recursion with high order function *)

(fn f => f (f 5))
(rec sum x => (ifzero x then 0 else (sum (x + (-1)) + x)))
