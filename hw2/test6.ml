(* Exercise 6. IntListQ *)
open Ex6
open Testlib

open IntListQ

module ValidIntListQ = (IntListQ: Queue)

module TestEx6: TestEx =
  struct
    type testcase =
      | SEQ of seq list
    and seq =
      | ENQ of int list
      | DEQ of int list
      | DEQ_EMPTYQ

    let testcases =
      [ SEQ
        [ ENQ [1;2;3]
        ; DEQ [1;2;3]
        ]
      ; SEQ
        [ DEQ_EMPTYQ ]
      ; SEQ
        [ ENQ [1]
        ; DEQ [1]
        ; DEQ_EMPTYQ
        ]
      ; SEQ
        [ ENQ [3;2;1]
        ; ENQ [4;5;6]
        ; DEQ [3;2;1]
        ; ENQ [9;8;7;6]
        ; DEQ [4;5;6]
        ; DEQ [9;8;7;6]
        ; DEQ_EMPTYQ
        ]
      ; SEQ
        [ ENQ [3;2;1]
        ; ENQ [-1;-2;-3]
        ; DEQ [3;2;1]
        ; DEQ [-1;-2;-3]
        ; DEQ_EMPTYQ
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
        ; DEQ_EMPTYQ
        ]
      ; SEQ
        [ ENQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; ENQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; ENQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; ENQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; ENQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; ENQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; ENQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; DEQ_EMPTYQ
        ]
      ; SEQ
        [ ENQ [1;2;3;4;5]
        ; ENQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; ENQ [1;2;3;4;5]
        ; ENQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; ENQ [1;2;3;4;5]
        ; ENQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; ENQ [1;2;3;4;5]
        ; DEQ [1;2;3;4;5]
        ; DEQ_EMPTYQ
        ]
      ; SEQ
        [ ENQ [1]
        ; DEQ [1]
        ]
      ; SEQ
        [ ENQ [1]
        ; ENQ [2]
        ; DEQ [1]
        ; DEQ [2]
        ]
      ; SEQ
        [ ENQ [1]
        ; ENQ [2]
        ; DEQ [1]
        ; ENQ [3]
        ; ENQ [4]
        ; DEQ [2]
        ; DEQ [3]
        ]
      ; SEQ
        [ ENQ [1]
        ; DEQ [1]
        ; ENQ [2]
        ; ENQ [3]
        ; DEQ [2]
        ; ENQ [4]
        ; DEQ [3]
        ; DEQ [4]
        ]
      ]

    let runner tc =
      let rec runner_ l q =
        match l with
        | [] -> true
        | (h::tc') ->
            match h with
            | ENQ l -> runner_ tc' (enQ (q, l))
            | DEQ l ->
                let (l', q') = deQ q in
                if l' = l then runner_ tc' q'
                else false
            | DEQ_EMPTYQ ->
                let res =
                  try Some (deQ q)
                  with EMPTY_Q -> None
                in res = None
      in
      match tc with
      | SEQ l -> runner_ l emptyQ

    let string_of_tc tc =
      let rec string_of_seqs seqs q =
        match seqs with
        | [] -> ("", "", "")
        | (h::seqs') ->
            let string_of_int_list = string_of_list string_of_int in
            match h with
            | ENQ l ->
                let (s, ans, out) = string_of_seqs seqs' (enQ (q, l)) in
                ("\n  enQ (q, " ^ (string_of_int_list l) ^ ")" ^ s, ans, out)
            | DEQ l ->
                let (l', q') = deQ q in
                if l' = l then
                  let (s, ans, out) = string_of_seqs seqs' q' in
                  ("\n  " ^ correct_symbol ^ " deQ (q) = " ^ (string_of_int_list l) ^ s, ans, out)
                else ("\n  " ^ wrong_symbol ^ " deQ (q)", string_of_int_list l, string_of_int_list l')
            | DEQ_EMPTYQ ->
                let res =
                  try Some (deQ q)
                  with EMPTY_Q -> None
                in match res with
                | Some (l', q') -> ("\n  " ^ wrong_symbol ^ " deQ (q)", "Exception EMPTY_Q", string_of_int_list l')
                | None ->
                    let (s, ans, out) = string_of_seqs seqs' q
                    in ("\n  " ^ correct_symbol ^ " deQ (q) = Exception EMPTY_Q" ^ s, ans, out)

      in
      match tc with
      | SEQ seqs -> string_of_seqs seqs emptyQ
  end

open TestEx6
let _ = wrapper testcases runner string_of_tc
