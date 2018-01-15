(* Test 45 : Recursion test 1 *)

let rec f = fn x =>
  (if x = 0 then
    x
  else
    x + f (x - 1));
  f (malloc true);
  1
in
  f 10
end
