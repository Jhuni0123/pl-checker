(* Exercise 4. nat *)
open Ex4
open Testlib

let rec nat_of_int (n: int): nat =
  match n with
  | 0 -> ZERO
  | n' -> SUCC (nat_of_int (n'-1))

let rec int_of_nat (n: nat): int =
  match n with
  | ZERO -> 0
  | SUCC n' -> (int_of_nat n') + 1

module TestEx4: TestEx =
  struct
    type testcase =
      | ADD of int * int * int
      | MUL of int * int * int

    let testcases: testcase list =
      [ ADD (0,0,0)
      ; ADD (1,1,2)
      ; ADD (10,20,30)
      ; ADD (0,100,100)
      ; ADD (17,31,48)
      ; MUL (0,0,0)
      ; MUL (0,1,0)
      ; MUL (1,0,0)
      ; MUL (2,0,0)
      ; MUL (1,1,1)
      ; MUL (10,2,20)
      ; MUL (17,31,527)
      ; MUL (2,16,32)
      ]

    let runner (tc: testcase): bool =
      match tc with
      | ADD (n1, n2, ans) -> natadd ((nat_of_int n1), (nat_of_int n2)) = (nat_of_int ans)
      | MUL (n1, n2, ans) -> natmul ((nat_of_int n1), (nat_of_int n2)) = (nat_of_int ans)

    let string_of_tc (tc: testcase): string * string * string =
      match tc with
      | ADD (n1, n2, ans) ->
          let output = int_of_nat (natadd ((nat_of_int n1), (nat_of_int n2))) in
          (Printf.sprintf "natadd(%d, %d)" n1 n2, string_of_int ans, string_of_int output)
      | MUL (n1, n2, ans) ->
          let output = int_of_nat (natmul ((nat_of_int n1), (nat_of_int n2))) in
          (Printf.sprintf "natmul(%d, %d)" n1 n2, string_of_int ans, string_of_int output)
  end

open TestEx4
let _ = wrapper testcases runner string_of_tc
