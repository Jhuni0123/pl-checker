(* Test 34 : Polymorphic type toy : fold list with 3 elems *)

let val list = fn x => fn y => fn z => (x, (y, z))
    val fst = fn x => x.1
    val snd = fn x => x.2.1
    val thd = fn x => x.2.2
    rec fold3 = fn f => fn lst => fn init_v =>
      let val v1 = f (fst lst) init_v
          val v2 = f (snd lst) v1
          val v3 = f (thd lst) v2
      in
        v3
      end
in
  (
    fold3 (fn v => fn acc_v => v + acc_v) (list 1 2 3) 10,
    fold3
      (fn l => fn acc_p => (l := "done"; if !l = "abc" then (true, acc_p.2 + 1) else acc_p))
      (list (malloc "aaa") (malloc "abc") (malloc "def"))
      (false, 0)
  )
end
