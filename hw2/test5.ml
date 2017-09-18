(* Exercise 5. zipper *)
open Ex5
open Testlib
open Printf

let rec string_of_tree t =
  match t with
  | LEAF name -> name
  | NODE ts -> "NODE " ^ (string_of_list string_of_tree ts)

let rec string_of_zipper zip =
  match zip with
  | TOP -> "TOP"
  | HAND (left, up, right) ->
      let string_of_tree_list = string_of_list string_of_tree in
      sprintf "HAND(%s, %s, %s)" (string_of_tree_list left) (string_of_zipper up) (string_of_tree_list right)

let string_of_location loc =
  match loc with
  | LOC (t, zip) -> sprintf "LOC (%s, %s)" (string_of_tree t) (string_of_zipper zip)

module TestEx5: TestEx =
  struct
    let exnum = 5

    type testcase =
      | LEFT of location * location
      | RIGHT of location * location
      | UP of location * location
      | DOWN of location * location

    let runner tc =
      match tc with
      | LEFT (loc, ans) -> goLeft loc = ans
      | RIGHT (loc, ans) -> goRight loc = ans
      | UP (loc, ans) -> goUp loc = ans
      | DOWN (loc, ans) -> goDown loc = ans

    let string_of_tc tc =
      match tc with
      | LEFT (loc, ans) -> (sprintf "goLeft (%s)" (string_of_location loc), string_of_location ans, string_of_location (goLeft loc))
      | RIGHT (loc, ans) -> (sprintf "goRight (%s)" (string_of_location loc), string_of_location ans, string_of_location (goRight loc))
      | UP (loc, ans) -> (sprintf "goUp (%s)" (string_of_location loc), string_of_location ans, string_of_location (goUp loc))
      | DOWN (loc, ans) -> (sprintf "goDown (%s)" (string_of_location loc), string_of_location ans, string_of_location (goDown loc))

    let testcases =
      [ LEFT (
        LOC (
          LEAF "*",
          HAND (
            [LEAF "c"],
            HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, []),
            [LEAF "d"]
          )
        ),
        LOC (
          LEAF "c",
          HAND (
            [],
            HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, []),
            [LEAF "*"; LEAF "d"]
          )
        )
      )
      ; RIGHT (
        LOC (
          LEAF "*",
          HAND (
            [LEAF "c"],
            HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, []),
            [LEAF "d"]
          )
        ),
        LOC (
          LEAF "d",
          HAND (
            [LEAF "*"; LEAF "c";],
            HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, []),
            []
          )
        )
      )
      ; UP (
        LOC (
          LEAF "*",
          HAND (
            [LEAF "c"],
            HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, []),
            [LEAF "d"]
          )
        ),
        LOC (
          NODE [LEAF "c"; LEAF "*"; LEAF "d"],
          HAND (
            [LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]],
            TOP,
            []
          )
        )
      )
      ; DOWN (
        LOC (
          NODE [LEAF "c"; LEAF "*"; LEAF "d"],
          HAND (
            [LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]],
            TOP,
            []
          )
        ),
        LOC (
          LEAF "c",
          HAND (
            [],
            HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, []),
            [LEAF "*"; LEAF "d"]
          )
        )
      )
      ; LEFT (
        LOC (
          NODE [LEAF "c"; LEAF "*"; LEAF "d"],
          HAND (
            [LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]],
            HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]),
            [LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]]
          )
        ),
        LOC (
          LEAF "+",
          HAND (
            [NODE [LEAF "a"; LEAF "*"; LEAF "b"]],
            HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]),
            [NODE [LEAF "c"; LEAF "*"; LEAF "d"]; LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]]
          )
        )
      )
      ; RIGHT (
        LOC (
          NODE [LEAF "c"; LEAF "*"; LEAF "d"],
          HAND (
            [LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]],
            HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]),
            [LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]]
          )
        ),
        LOC (
          LEAF "-",
          HAND (
            [NODE [LEAF "c"; LEAF "*"; LEAF "d"]; LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]],
            HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]),
            [NODE [LEAF "e"; LEAF "/"; LEAF "f"]]
          )
        )
      )
      ; UP (
        LOC (
          NODE [LEAF "c"; LEAF "*"; LEAF "d"],
          HAND (
            [LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]],
            HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]),
            [LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]]
          )
        ),
        LOC (
          NODE [NODE [LEAF "a"; LEAF "*"; LEAF "b"]; LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]; LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]],
          HAND (
            [],
            TOP,
            [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]
          )
        )
      )
      ; DOWN (
        LOC (
          NODE [LEAF "c"; LEAF "*"; LEAF "d"],
          HAND (
            [LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]],
            HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]),
            [LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]]
          )
        ),
        LOC (
          LEAF "c",
          HAND (
            [],
            HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]), [LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]]),
            [LEAF "*"; LEAF "d"]
          )
        )
      )
      ]
  end

open TestEx5
let _ = wrapper exnum testcases runner string_of_tc
