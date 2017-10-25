(* Exercise 1. eval formula *)
open Ex1
open Testlib
open Printf

module TestEx1: TestEx =
  struct
    type testcase =
      | EVAL of formula * bool

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
      ; EVAL (LESS (PLUS (NUM 3, NUM 4), MINUS (NUM 5, NUM 1)), false)
      ; EVAL (LESS (PLUS (NUM 10, NUM 12), MINUS (NUM 10, NUM (-13))), true)
      ; EVAL (NOT (ORELSE (IMPLY(TRUE, ANDALSO (TRUE, TRUE)), ANDALSO (TRUE, ANDALSO (TRUE, TRUE)))), false)
      ; EVAL (ORELSE (IMPLY(LESS (NUM (-10), NUM (-100)), ANDALSO (NOT TRUE, TRUE)), ANDALSO (TRUE, ANDALSO (LESS (NUM 10, PLUS (MINUS (NUM 10, NUM (-10)), NUM 30)), TRUE))), true)
      ]

    let rec string_of_expr e =
      match e with
      | NUM n ->
          if n < 0 then "(" ^ (string_of_int n) ^ ")"
          else string_of_int n
      | PLUS (e1, e2) -> sprintf "(%s + %s)" (string_of_expr e1) (string_of_expr e2)
      | MINUS (e1, e2) -> sprintf "(%s - %s)" (string_of_expr e1) (string_of_expr e2)

    let rec string_of_fomula f =
      match f with
      | TRUE -> "T"
      | FALSE -> "F"
      | NOT f' -> sprintf "(not %s)" (string_of_fomula f')
      | ANDALSO (f1, f2) -> sprintf "(%s && %s)" (string_of_fomula f1) (string_of_fomula f2)
      | ORELSE (f1, f2) -> sprintf "(%s || %s)" (string_of_fomula f1) (string_of_fomula f2)
      | IMPLY (f1, f2) -> sprintf "(%s -> %s)" (string_of_fomula f1) (string_of_fomula f2)
      | LESS (e1, e2) -> sprintf "(%s < %s)" (string_of_expr e1) (string_of_expr e2)

    let runner tc =
      match tc with
      | EVAL (f, ans) -> eval f = ans

    let string_of_tc tc =
      match tc with
      | EVAL (f, ans) -> (string_of_fomula f, string_of_bool ans, string_of_bool (eval f))
  end

open TestEx1
let _ = wrapper testcases runner string_of_tc
