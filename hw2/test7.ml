(* Exercise 7. Zexpr *)
open Ex7
open Testlib
open Printf

open Zexpr

let rec string_of_expr e =
  match e with
  | NUM n -> string_of_int n
  | PLUS (e1, e2) -> sprintf "(%s + %s)" (string_of_expr e1) (string_of_expr e2)
  | MINUS (e1, e2) -> sprintf "(%s - %s)" (string_of_expr e1) (string_of_expr e2)
  | MULT (e1, e2) -> sprintf "(%s / %s)" (string_of_expr e1) (string_of_expr e2)
  | DIVIDE (e1, e2) -> sprintf "(%s * %s)" (string_of_expr e1) (string_of_expr e2)
  | MAX es -> sprintf "max(%s)" (String.concat ", " (List.map string_of_expr es))
  | VAR name -> name
  | LET (name, e1, e2) -> sprintf "(LET [%s := %s] in %s)" name (string_of_expr e1) (string_of_expr e2)

module TestEx7 =
  struct
    type testcase =
      | EVAL of expr * int
      | ERROR of expr

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
      ; EVAL (MAX [NUM 30; NUM 20; NUM 10], 30)
      ; EVAL (MAX [NUM 1; NUM 1; NUM 2; NUM 1; NUM 1], 2)
      ; EVAL (LET ("x", NUM 15, VAR "x"), 15)
      ; EVAL (LET ("x", NUM 17, LET ("y", VAR "x", LET ("x", NUM 30, VAR "y"))), 17)
      ; EVAL (LET ("x", NUM 20, LET ("y", MULT (VAR "x", VAR "x"), LET ("x", VAR "x", PLUS (VAR "x", VAR "y")))), 420)
      ; EVAL (LET ("x", NUM 30, LET ("y", VAR "x", LET ("x", VAR "y", LET ("y", VAR "x", VAR "y")))), 30)
      ; EVAL (LET ("var", NUM 1000, LET ("let", PLUS (VAR "var", VAR "var"), MULT (VAR "let", VAR "let"))), 4000000)
      ; EVAL (LET ("x", NUM 1000, PLUS (LET ("x", NUM 1234, VAR "x"), PLUS (VAR "x", LET ("x", NUM 1357, VAR "x")))), 3591)
      ; ERROR (VAR "x")
      ; ERROR (LET ("x", VAR "x", VAR "x"))
      ; ERROR (LET ("x", NUM 10, LET ("y", VAR "x", VAR "z")))
      ]

    let runner tc =
      match tc with
      | EVAL (e, ans) -> eval(emptyEnv, e) = eval(emptyEnv, NUM ans)
      | ERROR e ->
          let out =
            try Some (eval(emptyEnv, e))
            with Error str -> None
          in out = None

    let string_of_tc tc =
      match tc with
      | EVAL (e, ans) ->
          ( sprintf "eval(emptyEnv, %s)" (string_of_expr e)
          , string_of_expr (NUM ans)
          , "" (* string_of_expr (NUM (eval(emptyEnv, e))) *)
          )
      | ERROR e ->
          ( sprintf "eval(emptyEnv, %s)" (string_of_expr e)
          , "exception Error"
          , ""
          )

    let result_of_tc tc =
      let (tc_s, a, b) = string_of_tc tc in
      match tc with
      | EVAL (e, ans) ->
          let out =
            try Some (eval(emptyEnv, e))
            with Error msg -> None
          in (tc_s, Some (eval(emptyEnv, NUM ans)), out)
      | ERROR e ->
          let out =
            try Some (eval(emptyEnv, e))
            with Error msg -> None
          in (tc_s, None, out)

    let print_res res =
      match res with
      | None -> print_string "exception Error FreeVariable"
      | Some v -> print_value v
  end


open TestEx7
let _ = wrapper2 testcases runner result_of_tc print_res
