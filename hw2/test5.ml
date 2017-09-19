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
      | TREE of tree * seq list
    and seq =
      | GOLEFT of location
      | GORIGHT of location
      | GOUP of location
      | GODOWN of location
      | NOMOVE_LEFT
      | NOMOVE_RIGHT
      | NOMOVE_UP
      | NOMOVE_DOWN

    let runner tc =
      let rec runner_ seqs curr =
        match seqs with
        | [] -> true
        | h::seqs' ->
            let (go, ans) =
              match h with
              | GOLEFT ans -> (goLeft, Some ans)
              | GORIGHT ans -> (goRight, Some ans)
              | GOUP ans -> (goUp, Some ans)
              | GODOWN ans -> (goDown, Some ans)
              | NOMOVE_LEFT -> (goLeft, None)
              | NOMOVE_RIGHT -> (goRight, None)
              | NOMOVE_UP -> (goUp, None)
              | NOMOVE_DOWN -> (goDown, None)
            in
              let output =
                try Some (go curr)
                with NOMOVE msg -> None
            in if output = ans then
              match ans with
              | Some loc -> runner_ seqs' loc
              | None -> runner_ seqs' curr
            else false
      in
        match tc with
        | TREE (t, seqs) -> runner_ seqs (LOC (t, TOP))

    let string_of_tc (tc: testcase) = ("", "", "")
      (* match tc with
      | LEFT (loc, ans) -> (sprintf "goLeft (%s)" (string_of_location loc), string_of_location ans, string_of_location (goLeft loc))
      | RIGHT (loc, ans) -> (sprintf "goRight (%s)" (string_of_location loc), string_of_location ans, string_of_location (goRight loc))
      | UP (loc, ans) -> (sprintf "goUp (%s)" (string_of_location loc), string_of_location ans, string_of_location (goUp loc))
      | DOWN (loc, ans) -> (sprintf "goDown (%s)" (string_of_location loc), string_of_location ans, string_of_location (goDown loc))
*)
    let testcases =
      [ TREE
      ( NODE [NODE [LEAF "a"; LEAF "*"; LEAF "b"]; LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]],
        [ GODOWN (LOC (NODE [LEAF "a"; LEAF "*"; LEAF "b"], HAND ([], TOP, [LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]])))
        ; GORIGHT (LOC (LEAF "+", HAND ([NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, [NODE [LEAF "c"; LEAF "*"; LEAF "d"]])))
        ; NOMOVE_DOWN
        ]
      )
      ]
  end

open TestEx5
let _ = wrapper exnum testcases runner string_of_tc
