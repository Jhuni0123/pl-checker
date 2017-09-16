(* Exercise 7. Zexpr *)
open Ex7
open Testlib

open Zexpr

module TestEx7: TestEx =
  struct
    let exnum = 7

    type testcase =
      | EVAL of expr * value

    let runner tc =
      match tc with
      | EVAL (e, v) -> eval(emptyEnv, e) = v

    let testcases =
      []
  end

open TestEx7
let _ = wrapper testcases runner exnum
