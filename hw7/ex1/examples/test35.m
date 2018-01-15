(* Test 35 : Polymorphism with WRITE & EQ 1 *)

let val bar = fn p =>
  if p.1 = p.2 then
    (write (p.1 = p.2); p.2)
  else
    write (p.1)
in
  let val i = 1
      val s = "hello world"
      val b = true
  in
    bar (i, 2);
    bar (b, true);
    bar (s, "bye world")
  end
end
