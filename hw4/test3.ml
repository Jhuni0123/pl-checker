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
      ; FAIL (Guide("x",Branch(End(StarBox),End(NameBox"x"))))
      ; FAIL (Branch(Guide("x",Branch(End(NameBox"x"),End(NameBox"x"))),End(StarBox)))
      ; FAIL (Branch(Guide ("x", Branch (End (NameBox "x"), End (NameBox "x"))),Guide ("y", Branch (End (NameBox "y"), End (NameBox "y")))))
      ; FAIL (Branch(Guide ("z", End (NameBox "z")), Branch(Guide ("x", Branch (End (NameBox "x"), End (NameBox "x"))),Guide ("y", Branch (End (NameBox "y"), End (NameBox "y"))))))
      ; FAIL (Branch(Branch(End(NameBox"q"),End(NameBox"p")),Guide("q",Branch(End(NameBox"p"),End(NameBox"q")))))
      ; FAIL (Branch(Guide("b",Branch(End (NameBox "a"), End(NameBox "b"))), Guide("a", Branch(End (NameBox "b"), End(NameBox "a")))))
      ; FAIL (Branch(Guide("x",Branch(End(NameBox"y"), End(NameBox"x"))),Guide("y",Branch(Branch(End(NameBox"z"),Branch(End(NameBox"y"),End(NameBox"w"))),End(NameBox"u")))))
      ; FAIL (Branch (Branch (Branch (Branch (End(NameBox"a"), End(NameBox"b")), End(NameBox"c")), Branch (Branch(End(NameBox"d"),End(NameBox"e")), End(NameBox"f"))), Branch(End(NameBox"a"),End(StarBox))))
      ; FAIL (Branch(Guide("x",(Guide("y",Guide("z",Guide ("w",Branch(Branch(End(NameBox"x"),End(NameBox"y")),Branch(End(NameBox"z"),End(NameBox"w")))))))),End StarBox))
      ; FAIL (Guide("x",Guide("z",Guide("y", Branch(Branch(Branch(End(NameBox"x"),End(NameBox"y")),Branch(End(NameBox"z"),End(NameBox"y"))),Branch(Branch(End(NameBox"x"),End(NameBox"y")),Branch(End(NameBox"z"),End(NameBox"y"))))))))
      ; GETREADY (Guide("a",Guide("b",Branch(End(NameBox"b"),End(NameBox"a")))), [Bar; Node (Bar, Bar)])
      ; GETREADY (Branch(Branch(End(NameBox"a"),End(StarBox)),End(NameBox"b")), [Bar; Node (Bar, Node (Bar, Bar))])
      ; GETREADY (Guide("x",Branch(End(NameBox"y"),Branch(End(NameBox"x"),End(StarBox)))), [Bar; Node (Bar, Bar)])
      ; GETREADY (Branch(Guide("y", End(NameBox"y")), Guide("x", Branch(End(NameBox"x"), End StarBox))), [Bar;Node(Bar,Bar);Node(Node(Bar,Bar),Bar)])
      ; GETREADY (Branch (End(NameBox"x"), Branch(End(NameBox"y"),Branch(End(NameBox"z"),End(StarBox)))), [Bar; Node (Bar, Bar)])
      ; GETREADY (Guide("x", Guide("y", Branch(End(NameBox"x"),Branch(End(NameBox"y"),End(NameBox"x"))))), [Node (Bar, Bar); Node (Node (Bar, Bar), Bar)])
      ; GETREADY (Guide ("x", Guide ("y", Branch(End(NameBox"y"), Branch (End(NameBox "x"), End StarBox)))), [Bar; Node (Bar, Bar)])
      ; GETREADY (Guide ("a", Branch (Branch (End (NameBox "a"), End (StarBox)), Guide ("b", End (NameBox "b")))), [Bar; Node (Bar, Node (Node (Bar, Bar), Bar))])
      ; GETREADY (Branch(Branch(End(NameBox"p"),Branch(End(NameBox"q"),End(StarBox))),Guide("r",End(NameBox"r"))), [Bar; Node (Bar, Bar); Node (Bar, Node (Node (Bar, Bar), Bar))])
      ; GETREADY (Branch(Branch(Guide("x",End(NameBox"x")),Guide("y",End(NameBox"y"))),Branch(End(NameBox"z"),End(StarBox))), [Bar; Node (Bar, Bar)])
      ; GETREADY (Guide ("x", Guide ("y", Guide ("z", Branch (Branch (End (NameBox "x"), End (NameBox "y")), End (NameBox "z"))))), [Bar; Node (Bar, Node (Bar, Bar))])
      ; GETREADY (Branch(Guide("z",End(NameBox"z")),Guide("x",Guide("y",Branch(End(NameBox"x"),Branch(End(NameBox"y"),End(StarBox)))))), [Bar; Node (Bar, Bar); Node (Node (Bar, Bar), Node (Node (Bar, Bar), Bar))])
      ; GETREADY (Branch (Branch (Branch (Guide("t",Guide("o",Branch(End(NameBox"o"),End(NameBox"t")))), Guide("h",End(NameBox"h"))), Guide("f",End(NameBox"f"))), End(NameBox"v")), [Bar; Node (Bar, Bar); Node (Node (Bar, Bar), Node (Bar, Bar))])
      ; GETREADY (Branch (Branch (End (NameBox "x"), End (NameBox "y")), Guide ("y", Branch (End (NameBox "y"), End StarBox))), [Bar; Node (Bar, Bar); Node (Node (Bar, Bar), Node (Node (Node (Bar, Bar), Bar), Bar))])
      ; GETREADY (Branch(Guide("a",Guide("b",Branch(End(NameBox"a"),End(NameBox"b")))),Guide("c",Guide("d",Branch(End(NameBox"d"),End(NameBox"c"))))), [Bar; Node (Bar, Bar); Node (Bar, Node (Node (Bar, Bar), Bar))])
      ; GETREADY (Branch(Branch(Branch(Guide("x",Guide("y",Guide("z",Branch(Branch (End (NameBox "x"),End (NameBox "y")),End (NameBox "z"))))),End (NameBox "a")),End (NameBox "b")),End (NameBox "c")), [Bar; Node(Bar,Node(Bar,Bar))])
      ; GETREADY (Branch (Branch (Branch (Branch (End(NameBox"a"), End(NameBox"b")), End(NameBox"c")), Branch (Branch(End(NameBox"d"),End(NameBox"e")), End(NameBox"f"))), Branch(End(NameBox"b"),End(StarBox))), [Bar; Node (Bar, Bar); Node (Bar, Node (Bar, Bar)); Node (Node (Bar, Bar), Node (Bar, Node (Bar, Node (Bar, Bar))))])
      ; GETREADY (Branch (Branch (Branch (Branch (End(NameBox"a"), End(NameBox"b")), End(NameBox"c")), Branch (Branch(End(NameBox"d"),End(NameBox"e")), End(NameBox"f"))), Branch(End(NameBox"c"),End(StarBox))), [Bar; Node (Bar, Bar); Node (Bar, Node (Bar, Bar)); Node (Bar, Node (Node (Bar, Bar), Node (Bar, Node (Bar, Bar))))])
      ; GETREADY (Branch (Branch (Branch (Branch (End(NameBox"a"), End(NameBox"b")), End(NameBox"c")), Branch (Branch(End(NameBox"d"),End(NameBox"e")), End(NameBox"f"))), Branch(End(NameBox"d"),End(StarBox))), [Bar; Node (Bar, Node (Bar,Bar)); Node (Bar, Node (Bar, Node (Bar, Node (Node (Bar,Bar), Bar))))])
      ; GETREADY (Branch (Branch (Branch (Branch (End(NameBox"a"), End(NameBox"b")), End(NameBox"c")), Branch (Branch(End(NameBox"d"),End(NameBox"e")), End(NameBox"f"))), Branch(End(NameBox"e"),End(StarBox))), [Bar; Node(Bar,Bar); Node(Node(Bar,Bar),Node(Bar,Bar)); Node(Bar,Node(Bar,Node(Bar,Node(Bar,Bar))))])
      ; GETREADY (Branch (Branch (Branch (Branch (End(NameBox"a"), End(NameBox"b")), End(NameBox"c")), Branch (Branch(End(NameBox"d"),End(NameBox"e")), End(NameBox"f"))), Branch(End(NameBox"f"),End(StarBox))), [Bar; Node (Bar, Bar); Node (Bar, Node (Node (Bar, Bar), Bar)); Node (Bar, Node (Bar, Node (Bar, Node (Bar, Bar))))])
      ; GETREADY (Branch(Guide ("x", (Guide ("y", Guide ("z", Guide ("w", Branch (Branch (End (NameBox "x"), End (NameBox "y")), Branch (End (NameBox "z"), End (NameBox "w")))))))), Guide ("a", Branch (End (NameBox "a"),End (NameBox "b")))), [Bar; Node(Bar,Bar); Node(Bar,Node(Bar,Bar)); Node(Node(Bar,Node(Bar,Bar)),Node(Bar,Bar))])
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
