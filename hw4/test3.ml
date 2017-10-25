(* Exercise 3. getReady *)
open Ex3
open Testlib

module TestEx3: TestEx =
  struct
    type testcase =
      | GETREADY of map * key list
      | FAIL of map

    let testcases: testcase list =
      [ GETREADY (End StarBox, [Bar])
      ; GETREADY (End (NameBox "x"), [Bar])
      ; GETREADY (Guide ("x", End (NameBox "x")), [Bar])
      ; GETREADY (Branch (Guide ("x", End (NameBox "x")), End StarBox), [Bar])
      ; FAIL (Branch (Guide ("x", Branch (End (NameBox "x"), End (NameBox "x"))), End StarBox))
      ; GETREADY (Branch (Guide ("x", End (NameBox "x")), Guide ("y", End (NameBox "y"))), [Bar; Node (Bar, Bar)])
      ; GETREADY (Branch (End (NameBox "x"), End StarBox), [Bar; Node (Bar, Bar)])
      ; GETREADY (Branch (Guide ("x", End (NameBox "x")), End StarBox), [Bar])
      ; GETREADY (Guide ("x", Branch (End (NameBox "x"), End StarBox)), [Bar; Node (Bar, Bar)])
      ; GETREADY (Branch (Guide ("y", End (NameBox "y")), End (NameBox "x")), [Bar])
      ; GETREADY (Branch (Guide ("y", End (NameBox "y")), Guide ("x", Guide ("x", End (NameBox "x")))), [Bar; Node (Bar, Node (Bar, Bar))])
      ; GETREADY (Guide ("y", Guide ("x", Branch (End (NameBox "x"), End (NameBox "y")))), [Bar; Node (Bar, Bar)])
      ]

    let string_of_treasure t =
      match t with
      | StarBox -> "*"
      | NameBox name -> name

    let rec string_of_map m =
      match m with
      | End t -> string_of_treasure t
      | Branch (m1, m2) -> Printf.sprintf "(%s | %s)" (string_of_map m1) (string_of_map m2)
      | Guide (id, m) -> Printf.sprintf "([%s]%s)" id (string_of_map m)

    let rec string_of_key k =
      match k with
      | Bar -> "-"
      | Node (k1, k2) -> Printf.sprintf "(%s, %s)" (string_of_key k1) (string_of_key k2)

    let string_of_key_list =
      string_of_list string_of_key

    let rec compare_key k1 k2 =
      match (k1, k2) with
      | (k1, k2) when k1 = k2 -> 0
      | (Bar, k) -> -1
      | (k, Bar) -> 1
      | (Node (k11, k12), Node (k21, k22)) ->
          let fstc = compare k11 k21 in
          if fstc = 0 then compare k12 k22
          else fstc

    let runner (tc: testcase): bool =
      match tc with
      | GETREADY (m, ans) -> (getReady m |> List.sort compare_key) = (ans |> List.sort compare_key)
      | FAIL m ->
          let res =
            try Some (getReady m)
            with _ -> None
          in res = None

    let string_of_tc (tc: testcase): string * string * string =
      match tc with
      | GETREADY (m, ans) ->
          let output = getReady m in
          ( Printf.sprintf "\n  getReady  %s" (string_of_map m)
          , string_of_key_list ans
          , string_of_key_list output
          )
      | FAIL m ->
          let output =
            try Some (getReady m)
            with _ -> None
          in
          let str out =
            match out with
            | Some res -> string_of_key_list res
            | None -> "exception IMPOSSIBLE"
          in
          ( Printf.sprintf "\n  getReady  %s" (string_of_map m)
          , str None
          , str output
          )
  end

open TestEx3
let _ = wrapper testcases runner string_of_tc
