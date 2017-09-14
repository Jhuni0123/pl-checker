(* Exercise 4. nat *)
open Ex4
open Testlib

let rec nat_of_int (n: int): nat =
    match n with
    | 0 -> ZERO
    | n' -> SUCC (nat_of_int (n'-1))

type testcase =
    | ADD of int * int * int
    | MUL of int * int * int

let runner (tc: testcase): bool =
    match tc with
    | ADD (i1, i2, o) -> natadd ((nat_of_int i1), (nat_of_int i2)) = (nat_of_int o)
    | MUL (i1, i2, o) -> natmul ((nat_of_int i1), (nat_of_int i1)) = (nat_of_int o)

let rec run tcs correct total =
    match tcs with
    | [] -> print_endline (string_of_frac correct total)
    | tc::tcs' ->
            let cor = runner tc in
            let () = print_endline (res_string cor (total+1))
            in if cor then run tcs' (correct+1) (total+1)
                else run tcs' correct (total+1)

let testcases: testcase list =
    [
    ]

let () = print_endline "# Test Exercise 4"
let () = run testcases 0 0
