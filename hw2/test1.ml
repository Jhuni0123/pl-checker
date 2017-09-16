(* Exercise 1. eval formula *)
open Ex1
open Testlib

module TestEx1: TestEx =
  struct
    let exnum = 1

    type testcase =
      | EVAL of formula * bool

    let runner tc =
      match tc with
      | EVAL (f, b) -> eval f = b

    let testcases =
      [ EVAL (TRUE, true)
      ; EVAL (FALSE, false)
      ; EVAL (NOT TRUE, false)
      ; EVAL (NOT FALSE, true)
      ; EVAL (ANDALSO (TRUE, TRUE), true)
      ; EVAL (ANDALSO (TRUE, FALSE), false)
      ; EVAL (ANDALSO (FALSE, TRUE), false)
      ; EVAL (ANDALSO (FALSE, FALSE), false)
      ; EVAL (ORELSE (TRUE, TRUE), true)
      ; EVAL (ORELSE (TRUE, FALSE), true)
      ; EVAL (ORELSE (FALSE, TRUE), true)
      ; EVAL (ORELSE (FALSE, FALSE), false)
      ; EVAL (IMPLY (TRUE, TRUE), true)
      ; EVAL (IMPLY (TRUE, FALSE), false)
      ; EVAL (IMPLY (FALSE, TRUE), true)
      ; EVAL (IMPLY (FALSE, FALSE), true)
      ; EVAL (LESS (NUM 1, NUM 2), true)
      ; EVAL (LESS (NUM 2, NUM 1), false)
      ; EVAL (LESS (NUM (-100), NUM (-200)), false)
      ; EVAL (LESS (NUM (-200), NUM (-100)), true)
      ; EVAL (LESS (NUM (-10000), NUM 10000), true)
      ; EVAL (LESS (NUM 10000, NUM (-10000)), false)
      ; EVAL (LESS (PLUS (NUM 1, NUM 2), NUM 3), false)
      ; EVAL (LESS (PLUS (NUM 1, NUM 2), NUM 4), true)
      ; EVAL (LESS (MINUS (NUM 10, NUM 5), NUM 5), false)
      ; EVAL (LESS (MINUS (NUM 10, NUM 5), NUM 6), true)
      ; EVAL (LESS (PLUS (NUM (-12345), NUM 23456), NUM 11111), false)
      ; EVAL (LESS (PLUS (NUM (-12345), NUM 23456), NUM 11112), true)
      ; EVAL (LESS (MINUS (NUM 12345, NUM 23456), NUM (-11111)), false)
      ; EVAL (LESS (MINUS (NUM 12345, NUM 23456), NUM (-11110)), true)
      ]
  end

open TestEx1
let _ = wrapper testcases runner exnum
