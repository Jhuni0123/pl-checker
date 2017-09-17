(* Exercise 6. IntListQ *)
open Ex6
open Testlib

open IntListQ

module ValidIntListQ = (IntListQ: Queue)

module TestEx6: TestEx =
  struct
    let exnum = 6

    type testcase =
      | SEQ of seq list
    and seq =
      | ENQ of int list
      | DEQ of int list

    let runner tc =
      let rec runner_ tc q =
        match tc with
        | SEQ [] -> true
        | SEQ (h::tc') ->
            match h with
            | ENQ l -> runner_ (SEQ tc') (enQ (q, elem l))
            | DEQ l ->
                let (l', q') = deQ q in
                if l' = elem l then runner_ (SEQ tc') q'
                else false
      in runner_ tc emptyQ

    let testcases =
      [ SEQ
        [ ENQ [1;2;3]
        ; DEQ [1;2;3]
        ]
      ; SEQ
        [ ENQ []
        ; ENQ [1;2;3]
        ; ENQ [4;5;6]
        ; ENQ [1;2;3]
        ; DEQ []
        ; DEQ [1;2;3]
        ; ENQ [1]
        ; ENQ [-10;1;-9]
        ; DEQ [4;5;6]
        ; DEQ [1;2;3]
        ; DEQ [1]
        ; DEQ [-10;1;-9]
        ; ENQ [222;333]
        ; DEQ [222;333]
        ]
      ]
  end

open TestEx6
let _ = wrapper testcases runner exnum
