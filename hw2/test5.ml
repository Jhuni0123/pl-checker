(* Exercise 5. zipper *)
open Ex5
open Testlib
open Printf

module TestEx5: TestEx =
  struct
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
        ; GOUP (LOC (NODE [LEAF "c"; LEAF "*"; LEAF "d"], HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, [])))
        ; GOLEFT (LOC (LEAF "+", HAND ([NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, [NODE [LEAF "c"; LEAF "*"; LEAF "d"]])))
        ; GOLEFT (LOC (NODE [LEAF "a"; LEAF "*"; LEAF "b"], HAND ([], TOP, [LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]])))
        ; NOMOVE_LEFT
        ; GOUP (LOC (NODE [NODE [LEAF "a"; LEAF "*"; LEAF "b"]; LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]], TOP))
        ; GODOWN (LOC (NODE [LEAF "a"; LEAF "*"; LEAF "b"], HAND ([], TOP, [LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]])))
        ; GORIGHT (LOC (LEAF "+", HAND ([NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, [NODE [LEAF "c"; LEAF "*"; LEAF "d"]])))
        ; GORIGHT (LOC (NODE [LEAF "c"; LEAF "*"; LEAF "d"], HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], TOP, [])))
        ; GOUP (LOC (NODE [NODE [LEAF "a"; LEAF "*"; LEAF "b"]; LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]], TOP))
        ]
      )
      ; TREE
      ( NODE [NODE [NODE [LEAF "a"; LEAF "*"; LEAF "b"]; LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]; LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]];LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]],
        [ NOMOVE_UP
        ; NOMOVE_LEFT
        ; NOMOVE_RIGHT
        ; GODOWN (LOC (NODE [NODE [LEAF "a"; LEAF "*"; LEAF "b"]; LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]; LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]], HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]])))
        ; NOMOVE_LEFT
        ; GODOWN (LOC (NODE [LEAF "a"; LEAF "*"; LEAF "b"], HAND ([], HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]), [LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]; LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]])))
        ; GORIGHT (LOC (LEAF "+", HAND ([NODE [LEAF "a"; LEAF "*"; LEAF "b"]], HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]), [NODE [LEAF "c"; LEAF "*"; LEAF "d"]; LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]])))
        ; GORIGHT (LOC (NODE [LEAF "c"; LEAF "*"; LEAF "d"], HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]), [LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]])))
        ; GORIGHT (LOC (LEAF "-", HAND ([NODE [LEAF "c"; LEAF "*"; LEAF "d"]; LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]), [NODE [LEAF "e"; LEAF "/"; LEAF "f"]])))
        ; GORIGHT (LOC (NODE [LEAF "e"; LEAF "/"; LEAF "f"], HAND ([LEAF "-"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]; LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]), [])))
        ; NOMOVE_RIGHT
        ; GOLEFT (LOC (LEAF "-", HAND ([NODE [LEAF "c"; LEAF "*"; LEAF "d"]; LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]), [NODE [LEAF "e"; LEAF "/"; LEAF "f"]])))
        ; GOLEFT (LOC (NODE [LEAF "c"; LEAF "*"; LEAF "d"], HAND ([LEAF "+"; NODE [LEAF "a"; LEAF "*"; LEAF "b"]], HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]]), [LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]])))
        ; GOUP (LOC (NODE [NODE [LEAF "a"; LEAF "*"; LEAF "b"]; LEAF "+"; NODE [LEAF "c"; LEAF "*"; LEAF "d"]; LEAF "-"; NODE [LEAF "e"; LEAF "/"; LEAF "f"]], HAND ([], TOP, [LEAF "*"; NODE [LEAF "g"; LEAF "+"; LEAF "h"]])))
        ]
      )
      ]

    let rec height_of_tree t =
      match t with
      | LEAF name -> 0
      | NODE [] -> 0
      | NODE l -> (List.fold_left max 0 (List.map height_of_tree l)) + 1

    let string_of_tree t t' =
      let height = (height_of_tree t)*2+1 in
      let base = Array.make height "  " in
      let string_repeat s n =
        Array.fold_left (^) "" (Array.make n s) in
      let sa_append_string line str n =
        base.(line) <- base.(line) ^ (string_repeat str n) in
      let sa_replace_last line str =
        let orig = base.(line) in
        base.(line) <- (String.sub orig 0 ((String.length orig)-1)) ^ str in
      let rec sa_fill line n =
        if line < height then
          let _ = sa_append_string line " " n
          in sa_fill (line+1) n
        else ()
      in
      let rec append_tree t line t' =
        let node_str = if t == t' then "★" else "○" in
        let len =
          match t with
          | LEAF name ->
              let _ = sa_append_string line (node_str ^ (sprintf "[%s] " name)) 1
              in (String.length name) + 4
          | NODE l ->
              let _ = sa_append_string line node_str 1 in
              match l with
              | [] -> 1
              | h::ns ->
                  let _ = sa_append_string (line+1) "│" 1 in
                  let child_len = append_tree h (line+2) t' in
                  let rec append_nodes ns line prev_len sum =
                    match ns with
                    | [] -> (prev_len, sum)
                    | h::ns' ->
                        let _ = sa_append_string line "─" (prev_len-1) in
                        let _ = sa_append_string line "┬" 1 in
                        let _ = sa_append_string (line+1) " " (prev_len-1) in
                        let _ = sa_append_string (line+1) "│" 1 in
                        let newlen = append_tree h (line+2) t' in
                        append_nodes ns' line newlen (sum + newlen)
                  in
                  let (last, sum) = append_nodes ns line child_len child_len in
                  let _ = sa_replace_last line "\144" in
                  let _ = sa_append_string (line+1) " " (last-1) in
                  let _ = sa_append_string (line) " " (last-1) in
                  sum
        in
        let _ = sa_fill (line + (height_of_tree t)*2+1) len in
        len
      in
      let _ = append_tree t 0 t'
      in String.concat "\n" (Array.to_list base)

    let rec tree_of_zipper t zip =
      match zip with
      | TOP -> t
      | HAND (left, up, right) -> tree_of_zipper (NODE ((List.rev left) @ [t] @ right)) up

    let tree_of_location loc =
      match loc with
      | LOC (t, zip) -> tree_of_zipper t zip

    let string_of_location loc =
      match loc with
      | LOC (t, zip) -> string_of_tree (tree_of_zipper t zip) t

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
            else
              let ans_s =
                match ans with
                | Some loc -> string_of_location loc
                | None -> "  NOMOVE"
              in
              let out_s =
                match output with
                | Some loc -> string_of_location loc
                | None -> "  NOMOVE"
              in ("\n  " ^ wrong_symbol ^ " " ^ str, "\n" ^ ans_s ^ "\n", "\n" ^ out_s ^ "\n")

      in
        match tc with
        | TREE (t, seqs) ->
            let (s, ans_s, out_s) = string_of_tc_ seqs (LOC (t, TOP))
            in ("\n  start from top of tree\n" ^ (string_of_tree t t) ^ s, ans_s, out_s)
  end

open TestEx5
let _ = wrapper testcases runner string_of_tc
