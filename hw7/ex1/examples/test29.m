(* Test 29 : Polymorphism with pair & imperatives *)

let val swap_ref = fn pair =>
      let val tmp = !pair.1 in
            pair.1 := !pair.2;
            pair.2 := tmp
      end
    val swap_val = fn pair =>
      (pair.2, pair.1)
in
  let val ref1 = malloc "hello"
      val ref2 = malloc "world"
      val ref3 = malloc (2, true)
      val ref4 = malloc (3, false)
  in
    swap_ref (ref1, ref2);
    swap_ref (ref3, ref4);
    (!ref4, swap_val (malloc 3, true))
  end
end
