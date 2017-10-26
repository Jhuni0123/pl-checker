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
      ; FAIL (Branch (End StarBox, End StarBox))
      ; FAIL (Branch (End (NameBox "x"), End (NameBox "x")))
      ; GETREADY (Branch (Guide ("x", End (NameBox "x")), End (NameBox "x")), [Bar])
      ; GETREADY (Branch (Branch (End (NameBox "x"), End StarBox), Branch (End (NameBox "y"), End (NameBox "x"))), [Bar; Node (Bar, Node (Bar, Bar)); Node (Node (Bar, Node (Bar, Bar)), Bar)])
      ; GETREADY (Branch (Branch (End (NameBox "x"), End (NameBox "y")), End (NameBox "y")), [Bar; Node (Bar, Node (Bar, Bar))])
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

    let sort = List.sort compare

    let runner (tc: testcase): bool =
      match tc with
      | GETREADY (m, ans) ->
          let output =
            try Some (getReady m |> sort)
            with IMPOSSIBLE -> None
          in output = Some (ans |> sort)
      | FAIL m ->
          let output =
            try Some (getReady m)
            with IMPOSSIBLE -> None
          in output = None

    let string_of_output out =
      match out with
      | Some res -> string_of_key_list res
      | None -> "exception IMPOSSIBLE"

    let string_of_tc (tc: testcase): string * string * string =
      match tc with
      | GETREADY (m, ans) ->
          let output =
            try Some (getReady m |> sort)
            with IMPOSSIBLE -> None
          in
          ( Printf.sprintf "\n  getReady  %s" (string_of_map m)
          , string_of_output (Some (ans |> sort))
          , string_of_output output
          )
      | FAIL m ->
          let output =
            try Some (getReady m |> sort)
            with IMPOSSIBLE -> None
          in
          ( Printf.sprintf "\n  getReady  %s" (string_of_map m)
          , string_of_output None
          , string_of_output output
          )
  end

open TestEx3
let _ = wrapper testcases runner string_of_tc
