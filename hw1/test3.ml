(* Exercise 3. iter *)
open Ex3
open Testlib

module ExTest3 =
  struct
    let exnum = 3

    type testcase =
      | INT of int * (int -> int) * int * int
      | STRING of int * (string -> string) * string * string
      | FLOAT of int * (float -> float) * float * float
      | BOOL of int * (bool -> bool) * bool * bool

    let runner (tc: testcase): bool =
      match tc with
      | INT(n, f, x, o) -> iter (n,f) x = o
      | STRING(n, f, x, o) -> iter (n,f) x = o
      | FLOAT(n, f, x, o) -> iter (n,f) x = o
      | BOOL(n, f, x, o) -> iter (n,f) x = o

    let testcases: testcase list =
      [ INT (10, (fun x -> x+1), 0, 10)
      ; STRING (10, (fun x -> x ^ "a"), "", "aaaaaaaaaa")
      ; INT (10, (fun x -> x*2), 1, 1024)
      ; INT (0, (fun x -> x*x+x), 1234, 1234)
      ; BOOL (123, (fun x -> not x), true, false)
      ]
  end

open ExTest3
let _ = wrapper testcases runner exnum
