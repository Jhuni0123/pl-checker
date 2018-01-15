(* Test 31 : Polymorphism with recursion *)

let rec iter = fn f => fn cond => fn v =>
  if cond v then
    iter f cond (f v)
  else
    v
in
  (
    iter (fn x => x + 1) (fn i => i = 100) 100,
    iter (fn p => (p.1 + 1, p.2 or (p.1 = 10))) (fn p => p.2) (10, true)
  )
end
