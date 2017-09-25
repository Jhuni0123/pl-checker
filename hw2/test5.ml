(* Exercise 5. zipper *)
open Ex5
open Testlib
open Printf

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

    let string_of_tc tc =
      let rec string_of_tc_ seqs curr =
        match seqs with
        | [] -> ("", "", "")
        | h::seqs' ->
            let go, ans, str =
              match h with
              | GOLEFT ans -> (goLeft, Some ans, "goLeft")
              | GORIGHT ans -> (goRight, Some ans, "goRight")
              | GOUP ans -> (goUp, Some ans, "goUp")
              | GODOWN ans -> (goDown, Some ans, "goDown")
              | NOMOVE_LEFT -> (goLeft, None, "NOMOVE on left")
              | NOMOVE_RIGHT -> (goRight, None, "NOMOVE on right")
              | NOMOVE_UP -> (goUp, None, "NOMOVE on up")
              | NOMOVE_DOWN -> (goDown, None, "NOMOVE on down")
            in
              let output =
                try Some (go curr)
                with NOMOVE msg -> None
            in if output = ans then
              let (s, ans_s, out_s) =
                match ans with
                | Some loc -> string_of_tc_ seqs' loc
                | None -> string_of_tc_ seqs' curr
              in ("\n  " ^ correct_symbol ^ " " ^ str ^ s, ans_s, out_s)
            else ("\n  " ^ wrong_symbol ^ " " ^ str, "", "")

      in
        match tc with
        | TREE (t, seqs) ->
            let (s, ans_s, out_s) = string_of_tc_ seqs (LOC (t, TOP))
            in ("\n  start from top of tree" ^ s, ans_s, out_s)

    let testcases =
      [ TREE
      ( NODE [NODE [LEAF "a"; LEAF "*"; LEAF "b"]; LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]],
        [ NOMOVE_UP
        ; NOMOVE_LEFT
        ; NOMOVE_RIGHT
        ; GODOWN (LOC (NODE [LEAF "a"; LEAF "*"; LEAF "b"], HAND ([], TOP, [LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]])))
        ; NOMOVE_LEFT
        ; GORIGHT (LOC (LEAF "+", HAND ([NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, [NODE [LEAF "c"; LEAF "*"; LEAF "d"]])))
        ; NOMOVE_DOWN
        ; GORIGHT (LOC (NODE [LEAF "c"; LEAF "*"; LEAF "d"], HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, [])))
        ; NOMOVE_RIGHT
        ; GODOWN (LOC (LEAF "c", HAND ([], HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, []), [LEAF "*"; LEAF "d"])))
        ; NOMOVE_LEFT
        ; NOMOVE_DOWN
        ; GORIGHT (LOC (LEAF "*", HAND ([LEAF "c"], HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, []), [LEAF "d"])))
        ; NOMOVE_DOWN
        ; GORIGHT (LOC (LEAF "d", HAND ([LEAF "*"; LEAF "c"], HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, []), [])))
        ; NOMOVE_RIGHT
        ; GOLEFT (LOC (LEAF "*", HAND ([LEAF "c"], HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, []), [LEAF "d"])))
        ; GOLEFT (LOC (LEAF "c", HAND ([], HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, []), [LEAF "*"; LEAF "d"])))
        ]
      )
      ; TREE
      ( NODE [NODE [NODE [LEAF "a"; LEAF "*"; LEAF "b"]; LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]; LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]];LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]],
        [ NOMOVE_UP
        ; NOMOVE_LEFT
        ; NOMOVE_RIGHT
        ; GODOWN (LOC (NODE [NODE [LEAF "a"; LEAF "*"; LEAF "b"]; LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]; LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]], HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]])))
        ; NOMOVE_LEFT
        ]
      )
      ]
  end

open TestEx5
let _ = wrapper exnum testcases runner string_of_tc
