(* Exercise 7. Zexpr *)
open Ex7
open Testlib

open Zexpr

module TestEx7: TestEx =
  struct
    let exnum = 7

    type testcase =
      | EVAL of expr * int

    let runner tc =
      match tc with
      | EVAL (e, v) -> eval(emptyEnv, e) = eval(emptyEnv, NUM v)
          (*
          let _ = print_endline "- two line below should be same" in
          let _ = print_string "output: "; print_value (eval(emptyEnv, e)); print_endline "" in
          let _ = print_string "answer: "; print_int v; print_endline "" in true
*)
    let testcases =
      [ EVAL (NUM 1, 1)
      ; EVAL (NUM (-10), -10)
      ; EVAL (PLUS (NUM 123, NUM 456), 579)
      ; EVAL (MINUS (NUM 456, NUM 123), 333)
      ; EVAL (MULT (NUM 25, NUM 16), 400)
      ; EVAL (DIVIDE (NUM (-3000), NUM 22), -136)
      ; EVAL (MAX [], 0)
      ; EVAL (MAX [NUM (-98765)], -98765)
      ; EVAL (MAX [NUM 10; NUM 20; NUM 30], 30)
      ; EVAL (LET ("x", NUM 15, VAR "x"), 15)
      ; EVAL (LET ("x", NUM 17, LET ("y", VAR "x", LET ("x", NUM 30, VAR "y"))), 17)
      ]
  end

open TestEx7
let _ = wrapper testcases runner exnum
