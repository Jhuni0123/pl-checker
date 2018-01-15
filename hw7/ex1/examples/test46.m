(* Test 46 : Recursion test 2 *)

let rec f = fn x =>
  (
    malloc x := x,
    if x = 2 then (3, true) else f (malloc "wrong")
  )
in
  f 5
end
