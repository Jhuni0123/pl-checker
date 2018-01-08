(* 22. recursion with pair *)

(rec f x =>
  ifzero (x + (-1)) then
    1
  else (
    (rec g y =>
      (ifzero y.2 then
        0
      else
        ((g (y.1, (y.2 + (-1)))) + (y.1)))
    ) (x, f (x + (-1)))
  )
) 3
