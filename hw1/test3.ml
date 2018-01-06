(* Exercise 3. iter *)
open Ex3
open Testlib

module TestEx3: TestEx =
  struct
    type 'a tc = int * ('a -> 'a) * string * 'a * 'a
    and testcase =
      | INT of int tc
      | STRING of string tc
      | FLOAT of float tc
      | BOOL of bool tc
      | INT_LIST of int list tc
      | INT_QUADRAPLE of (int * int * int * int) tc

    let testcases: testcase list =
      [ INT (10, (fun x -> x + 1), "x -> x + 1", 0, 10)
      ; INT (10, (fun x -> x + 4), "x -> x + 4", 100, 140)
      ; INT (0, (fun x -> x + 3), "x -> x + 3", 300, 300)
      ; STRING (10, (fun x -> x ^ "a"), "x -> x ^ \"a\"", "", "aaaaaaaaaa")
      ; STRING (3, (fun x -> x ^ x), "x -> x ^ x", "a", "aaaaaaaa")
      ; INT (10, (fun x -> x*2), "x -> 2*x", 1, 1024)
      ; INT (0, (fun x -> x*x+x), "x -> x*x + x", 1234, 1234)
      ; BOOL (123, (fun x -> not x), "x -> not x", true, false)
      ; INT_LIST (3, List.tl, "List.tl", [2;3;4;5;6;7], [5;6;7])
      ; INT_QUADRAPLE (5, (fun (x,y,z,w) -> (w,x,y,z)), "(x,y,z,w) -> (w,x,y,z)", (1,2,3,4), (4,1,2,3))
      ]

    let runner (tc: testcase): bool =
      match tc with
      | INT(n, f, fs, x, ans) -> iter (n,f) x = ans
      | STRING(n, f, fs, x, ans) -> iter (n,f) x = ans
      | FLOAT(n, f, fs, x, ans) -> iter (n,f) x = ans
      | BOOL(n, f, fs, x, ans) -> iter (n,f) x = ans
      | INT_LIST(n, f, fs, x, ans) -> iter (n,f) x = ans
      | INT_QUADRAPLE (n, f, fs, x, ans) -> iter (n,f) x = ans

    let string_of_iqp (a,b,c,d) =
      Printf.sprintf "(%d, %d, %d, %d)" a b c d

    let string_of_tc (tc: testcase): string * string * string =
      let base = Printf.sprintf "iter (%d, %s) %s" in
      let string_of_il = string_of_list string_of_int in
      match tc with
      | INT(n, f, fs, x, ans) -> (base n fs (string_of_int x), string_of_int ans, string_of_int (iter(n,f) x))
      | STRING(n, f, fs, x, ans) -> (base n fs x, ans, iter(n,f) x)
      | FLOAT(n, f, fs, x, ans) -> (base n fs (string_of_float x), string_of_float ans, string_of_float (iter(n,f) x))
      | BOOL(n, f, fs, x, ans) -> (base n fs (string_of_bool x), string_of_bool ans, string_of_bool (iter(n,f) x))
      | INT_LIST(n, f, fs, x, ans) -> (base n fs (string_of_il x), string_of_il ans, string_of_il (iter(n,f) x))
      | INT_QUADRAPLE(n, f, fs, x, ans) -> (base n fs (string_of_iqp x), string_of_iqp ans, string_of_iqp (iter(n,f) x))
  end

open TestEx3
let _ = wrapper testcases runner string_of_tc
