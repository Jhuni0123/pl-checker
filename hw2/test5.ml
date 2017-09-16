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
      [
      ]
  end

open TestEx5
let _ = wrapper testcases runner exnum
