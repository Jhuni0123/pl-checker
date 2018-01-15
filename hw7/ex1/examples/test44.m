(* Test 44 : Polymorphic trap 2
  Type generalization must exclude type variables in current type
  environment.
*)

let val x = malloc (fn x => (write (x = x); (malloc x, x)))
    val y = x in (* This y should not be generalized, since x is in type env *)
  y := (fn x => (write x; (true, x)));
  !y (malloc 10)
end
