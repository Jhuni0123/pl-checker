(* Exercise 4. checkmetro *)
open Ex4
open Testlib

module TestEx4: TestEx =
  struct
    let exnum = 4

    type testcase =
      | CHECK of metro * bool

    let runner tc =
      match tc with
      | CHECK (m, b) -> checkMetro m = b

    let testcases =
      [
      ]
  end

open TestEx4
let _ = wrapper testcases runner exnum
