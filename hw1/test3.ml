(* Exercise 3. iter *)
open Ex3
open Testlib

module TestEx3: TestEx =
  struct
    type testcase =
      | INT of int * (int -> int) * string * int * int
      | STRING of int * (string -> string) * string * string * string
      | FLOAT of int * (float -> float) * string * float * float
      | BOOL of int * (bool -> bool) * string * bool * bool

    let testcases: testcase list =
      [ INT (10, (fun x -> x+1), "x -> x+1", 0, 10)
      ; STRING (10, (fun x -> x ^ "a"), "x -> x ^ \"a\"", "", "aaaaaaaaaa")
      ; INT (10, (fun x -> x*2), "x -> 2*x", 1, 1024)
      ; INT (0, (fun x -> x*x+x), "x -> x*x + x", 1234, 1234)
      ; BOOL (123, (fun x -> not x), "x -> not x", true, false)
      ]

    let runner (tc: testcase): bool =
      match tc with
      | INT(n, f, fs, x, ans) -> iter (n,f) x = ans
      | STRING(n, f, fs, x, ans) -> iter (n,f) x = ans
      | FLOAT(n, f, fs, x, ans) -> iter (n,f) x = ans
      | BOOL(n, f, fs, x, ans) -> iter (n,f) x = ans

    let string_of_tc (tc: testcase): string * string * string =
      let base = Printf.sprintf "iter (%d, %s) %s" in
      match tc with
      | INT(n, f, fs, x, ans) -> (base n fs (string_of_int x), string_of_int ans, string_of_int (iter(n,f) x))
      | STRING(n, f, fs, x, ans) -> (base n fs x, ans, iter(n,f) x)
      | FLOAT(n, f, fs, x, ans) -> (base n fs (string_of_float x), string_of_float ans, string_of_float (iter(n,f) x))
      | BOOL(n, f, fs, x, ans) -> (base n fs (string_of_bool x), string_of_bool ans, string_of_bool (iter(n,f) x))
  end

open TestEx3
let _ = wrapper testcases runner string_of_tc
