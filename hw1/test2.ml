(* Exercise 2. sigma *)
open Ex2
open Testlib

module TestEx2: TestEx =
  struct
    type testcase =
      | SIGMA of int * int * (int -> int) * string * int

    let testcases: testcase list =
      [ SIGMA (1, 10, (fun x -> x), "x -> x", 55)
      ; SIGMA (10, 10, (fun x -> x*x), "x -> x*x", 100)
      ; SIGMA (5, 5, (fun x -> x+x*x*2), "x -> 2*x*x + x", 55)
      ; SIGMA (2, 1, (fun x -> x + 1 + x*x), "x -> x*x + x + 1", 0)
      ; SIGMA (-1000, 1000, (fun x -> x*x*x), "x -> x*x*x", 0)
      ; SIGMA (-100, -1000, (fun _ -> 1), "x -> 1", 0)
      ; SIGMA (-10000, 0, (fun x -> abs x), "x -> abs x", 50005000)
      ]

    let runner (tc: testcase): bool =
      match tc with
      | SIGMA (a, b, f, fs, ans) -> sigma(a,b,f) = ans

    let string_of_tc (tc: testcase): string * string * string =
      match tc with
      | SIGMA (a, b, f, fs, ans) ->
          ( Printf.sprintf "sigma(%d, %d, %s)" a b fs
          , string_of_int ans
          , string_of_int (sigma(a,b,f))
          )
  end

open TestEx2
let _ = wrapper testcases runner string_of_tc
