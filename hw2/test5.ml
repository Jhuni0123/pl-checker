(* Exercise 5. zipper *)
open Ex5
open Testlib

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
      | LEFT (loc1, loc2) -> goLeft loc1 = loc2
      | RIGHT (loc1, loc2) -> goRight loc1 = loc2
      | UP (loc1, loc2) -> goUp loc1 = loc2
      | DOWN (loc1, loc2) -> goDown loc1 = loc2

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
let _ = wrapper testcases runner exnum
