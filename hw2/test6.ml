(* Exercise 6. IntListQ *)
open Ex6
open Testlib

module TestEx6: TestEx =
  struct
    let exnum = 6

    type testcase =
      | SEQ of seq list
    and seq =
      | ENQ of IntListQ.element
      | DEQ of IntListQ.element

    let runner tc =
      let rec runner_ tc q =
        match tc with
        | SEQ [] -> true
        | SEQ (h::tc') ->
            match h with
            | ENQ l -> runner_ (SEQ tc') (IntListQ.enQ (q, l))
            | DEQ l ->
                let (l', q') = IntListQ.deQ q in
                if l' = l then runner_ (SEQ tc') q'
                else false
      in runner_ tc IntListQ.emptyQ

    let testcases =
      (* cannot add testcases *)
      []
  end

open TestEx6
let _ = wrapper testcases runner exnum
