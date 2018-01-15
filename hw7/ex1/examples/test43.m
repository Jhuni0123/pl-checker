(* Test 43 : Polymorphic trap 1 (type error)
  malloc expression must be checked before generalization
*)

let val xmalloc = fn x => malloc x
    val f = if 1 = 1 then xmalloc (fn x => (write "true"; x)) else xmalloc xmalloc (fn x => malloc x := x)
in
  f := (fn x => x or false); malloc 0 := ((!f 10)); (!f) true
end
