(* Exercise 2. sigma *)
open Ex2
open Testlib

let exnum = 2

type testcase =
    | SIGMA of int * int * (int -> int) * int

let runner (tc: testcase): bool =
    match tc with
    | SIGMA (a, b, f, o) -> sigma(a,b,f) = o

let testcases: testcase list =
    [ SIGMA (1, 10, (fun x -> x), 55)
    ; SIGMA (10, 10, (fun x -> x*x), 100)
    ; SIGMA (5, 5, (fun x -> x+x*x*2), 55)
    ; SIGMA (2, 1, (fun x -> x + 1 + x*x), 0)
    ; SIGMA (-1000, 1000, (fun x -> x*x*x), 0)
    ; SIGMA (-100, -1000, (fun _ -> 1), 0)
    ; SIGMA (-10000, 0, (fun x -> abs x), 50005000)
    ]

let _ = wrapper testcases runner exnum
