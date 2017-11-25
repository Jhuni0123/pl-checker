(* testcase 12 : M.FN, M.APP *)

write (fn x => (fn y => x + y)) 10 20;

let rec fib = fn x =>
  if x = 0 then 0
  else if x = 1 then 1
  else (fib (x-1) + fib (x-2))
in
  write fib 8;
  write (fn f => (fn x => f x)) fib 9
end
