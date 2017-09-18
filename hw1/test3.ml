(* Exercise 3. iter *)
open Ex3
open Testlib

module TestEx3: TestEx =
  struct
    let exnum = 3

    type testcase =
      | INT of int * (int -> int) * string * int * int
      | STRING of int * (string -> string) * string * string * string
      | FLOAT of int * (float -> float) * string * float * float
      | BOOL of int * (bool -> bool) * string * bool * bool

    let runner (tc: testcase): bool =
      match tc with
      | INT(n, f, fs, x, ans) -> iter (n,f) x = ans
      | STRING(n, f, fs, x, ans) -> iter (n,f) x = ans
      | FLOAT(n, f, fs, x, ans) -> iter (n,f) x = ans
      | BOOL(n, f, fs, x, ans) -> iter (n,f) x = ans

    let string_of_tc (tc: testcase): string * string * string =
      let base = Printf.sprintf "iter (%d, %s) %s" in
      match tc with
      | INT(n, f, fs, x, ans) -> (base n fs (string_of_int x), string_of_int (iter(n,f) x), string_of_int ans)
      | STRING(n, f, fs, x, ans) -> (base n fs x, iter(n,f) x, ans)
      | FLOAT(n, f, fs, x, ans) -> (base n fs (string_of_float x), string_of_float (iter(n,f) x), string_of_float ans)
      | BOOL(n, f, fs, x, ans) -> (base n fs (string_of_bool x), string_of_bool (iter(n,f) x), string_of_bool ans)

    let testcases: testcase list =
      [ INT (10, (fun x -> x+1), "x -> x+1", 0, 10)
      ; STRING (10, (fun x -> x ^ "a"), "x -> x ^ \"a\"", "", "aaaaaaaaaa")
      ; INT (10, (fun x -> x*2), "x -> 2*x", 1, 1024)
      ; INT (0, (fun x -> x*x+x), "x -> x*x + x", 1234, 1234)
      ; BOOL (123, (fun x -> not x), "x -> not x", true, false)
      ]
  end

open TestEx3
let _ = wrapper exnum testcases runner string_of_tc
