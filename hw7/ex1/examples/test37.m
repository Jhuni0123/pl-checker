(* Test 37 : Polymorphism with WRITE & EQ 2  *)

let val f = fn p =>
  (* p : ((writable a) loc, writable a -> comparable b) *)
  (
    write !(p.1);
    (
      if (p.2 !(p.1)) = (p.2 !(p.1)) then
        (p.1 := (!(p.1)); 1)
      else
        (write (!(p.1) = !(p.1)); 2),
      (p.2 !(p.1))
    )
  )
in
  (
    (f (malloc true, fn i => (write i; true))).1,
    (f (malloc 3, fn i => (write i; malloc "test"))).2
  )
end
