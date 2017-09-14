(* Exercise 2. sigma *)
open Ex2
open Testlib

type testcase =
    | SIGMA of int * int * (int -> int) * int

let runner (tc: testcase): bool =
    match tc with
    | SIGMA (a, b, f, o) -> sigma(a,b,f) = o

let rec run tcs correct total =
    match tcs with
    | [] -> print_endline (string_of_frac correct total)
    | tc::tcs' ->
            let cor = runner tc in
            let () = print_endline (res_string cor (total+1))
            in if cor then run tcs' (correct+1) (total+1)
                else run tcs' correct (total+1)

let testcases: testcase list =
    [ SIGMA (1, 10, (fun x -> x), 55)
    ; SIGMA (10, 10, (fun x -> x*x), 100)
    ; SIGMA (5, 5, (fun x -> x+x*x*2), 55)
    ; SIGMA (2, 1, (fun x -> x + 1 + x*x), 0)
    ; SIGMA (-1000, 1000, (fun x -> x*x*x), 0)
    ; SIGMA (-100, -1000, (fun _ -> 1), 0)
    ; SIGMA (-10000, 0, (fun x -> abs x), 50005000)
    ]

let () = print_endline "# Test Exercise 2"
let () = run testcases 0 0
