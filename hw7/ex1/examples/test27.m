(* Test 27 : Heavy test on function application *)

let val I = fn x => x
    val K = fn x => fn y => x
    val S = fn x => fn y => fn z => (x z) (y z)
in
  (S (S (K S) (S (K K) I)) (S (S (K S) (S (K K) I)) (K I)))
  (fn x => x + 1)
  10
end
