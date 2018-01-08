(* Exercise 2. shoppingList *)
open Ex2
open Testlib

module TestEx2: TestEx =
  struct
    type testcase =
      | SHOP of require list * (id * gift list) list

    let testcases: testcase list =
      [ SHOP
        ( [ (A, [Same B])
          ; (B, [Same A])
          ; (C, [Same B])
          ; (D, [])
          ; (E, [])
          ]
        , [ (A, [])
          ; (B, [])
          ; (C, [])
          ; (D, [])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (A, [Except (Same B, [1])])
          ; (B, [Except (Same A, [2])])
          ; (C, [Except (Same B, [3])])
          ; (D, [])
          ; (E, [])
          ]
        , [ (A, [])
          ; (B, [])
          ; (C, [])
          ; (D, [])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (A, [Same B; Same C])
          ; (B, [Same A; Same C])
          ; (C, [Same A; Same B])
          ; (D, [])
          ; (E, [])
          ]
        , [ (A, [])
          ; (B, [])
          ; (C, [])
          ; (D, [])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (A, [Items [1]])
          ; (B, [Items [2]])
          ; (C, [Items [3]])
          ; (D, [])
          ; (E, [])
          ]
        , [ (A, [1])
          ; (B, [2])
          ; (C, [3])
          ; (D, [])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (A, [Items [1;2]; Common (Same B, Same C)])
          ; (B, [Common (Same C, Items [2;3])])
          ; (C, [Items [1]; Except (Same A, [3])])
          ; (D, [])
          ; (E, [])
          ]
        , [ (A, [1; 2])
          ; (B, [2])
          ; (C, [1; 2])
          ; (D, [])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (A, [])
          ; (B, [])
          ; (C, [])
          ; (D, [])
          ; (E, [])
          ]
        , [ (A, [])
          ; (B, [])
          ; (C, [])
          ; (D, [])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (A, [Items [1;2;3]])
          ; (B, [Same A])
          ; (C, [Same A])
          ; (D, [Same A])
          ; (E, [Same A])
          ]
        , [ (A, [1;2;3])
          ; (B, [1;2;3])
          ; (C, [1;2;3])
          ; (D, [1;2;3])
          ; (E, [1;2;3])
          ]
        )
      ; SHOP
        ( [ (A, [Items [1;2;3;4]])
          ; (B, [Items [2;3;4;5]])
          ; (C, [Common (Same A, Same B)])
          ; (D, [Items [3;4;5;6]])
          ; (E, [Common (Same C, Same D)])
          ]
        , [ (A, [1;2;3;4])
          ; (B, [2;3;4;5])
          ; (C, [2;3;4])
          ; (D, [3;4;5;6])
          ; (E, [3;4])
          ]
        )
      ; SHOP
        ( [ (A, [Items [1;2;3;4;5;6;7]])
          ; (B, [Except (Same A, [1;4])])
          ; (C, [Except (Same B, [2;3])])
          ; (D, [Except (Same C, [5;6])])
          ; (E, [Except (Same D, [7])])
          ]
        , [ (A, [1;2;3;4;5;6;7])
          ; (B, [2;3;5;6;7])
          ; (C, [5;6;7])
          ; (D, [7])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (A, [Items [1; 2; 3]; Except (Items [5; 6; 7], [6]); Common (Same (D), Same (E))])
          ; (B, [Common (Same (A), Same (B)); Common (Same (B), Same (C)); Except (Same (D), [9])])
          ; (C, [Common (Same (B), Same (C)); Except (Same (E), [1; 6]); Common (Same (A), Same (D))])
          ; (D, [Items [4; 5; 6; 7; 8; 9; 10]; Same (B); Same (C)])
          ; (E, [Except (Same (A), [3]); Items [9; 10; 11]; Common (Common (Same (B), Same (D)), Items [1; 2; 3; 4; 5; 6; 7])])
          ]
        , [ (A, [1; 2; 3; 4; 5; 6; 7; 9; 10; 11])
          ; (B, [2; 4; 5; 6; 7; 8; 10; 11])
          ; (C, [2; 4; 5; 6; 7; 9; 10; 11])
          ; (D, [2; 4; 5; 6; 7; 8; 9; 10; 11])
          ; (E, [1; 2; 4; 5; 6; 7; 9; 10; 11])
          ]
        )
      ; SHOP
        ( [ (A, [Items [1;2;3]])
          ; (B, [Items [2;3;4]])
          ; (C, [Items [3;4;1]])
          ; (D, [Items [4;1;2]])
          ; (E, [Items [1;2;3;1;2;3]])
          ]
        , [ (A, [1; 2; 3])
          ; (B, [2; 3; 4])
          ; (C, [1; 3; 4])
          ; (D, [1; 2; 4])
          ; (E, [1; 2; 3])
          ]
        )
      ; SHOP
        ( [ (A, [Items [1;2;3]])
          ; (B, [Same A])
          ; (C, [Same A; Items[1;2]])
          ; (D, [Same A; Items[4]])
          ; (E, [Same D])
          ]
        , [ (A, [1; 2; 3])
          ; (B, [1; 2; 3])
          ; (C, [1; 2; 3])
          ; (D, [1; 2; 3; 4])
          ; (E, [1; 2; 3; 4])
          ]
        )
      ; SHOP
        ( [ (A, [Common (Items [1;2;3], Items [2;1;3])])
          ; (B, [Common (Items [2;1;3], Items [5;6;1;4;2;3])])
          ; (C, [Common (Items [1;2;3], Items [4;5;6])])
          ; (D, [Common (Items [3;2;1], Items [1])])
          ; (E, [Common (Items [1;2;3], Items [])])
          ]
        , [ (A, [1; 2; 3])
          ; (B, [1; 2; 3])
          ; (C, [])
          ; (D, [1])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (B, [Common (Items [2;1;3], Items [5;6;1;4;2;3])])
          ; (E, [Common (Items [], Items [])])
          ; (D, [Common (Items [1], Items [1])])
          ]
        , [ (A, [])
          ; (B, [1; 2; 3])
          ; (C, [])
          ; (D, [1])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (A, [Except (Items [3;2;1], [3;2;1])])
          ; (B, [Except (Items [2;1;3], [])])
          ; (C, [Except (Items [2;1;3], [1;2;3;4;5;6])])
          ; (D, [Except (Items [], [2;1;3])])
          ; (E, [Except (Items [], [])])
          ]
        , [ (A, [])
          ; (B, [1; 2; 3])
          ; (C, [])
          ; (D, [])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (A, [Common (Common (Same B, Same C), Common (Same D, Same E))])
          ; (B, [Common (Same C, Common (Same D, Except (Same E, [5])))])
          ; (C, [Same D; Items[7;8]])
          ; (D, [Except (Same E, [1;2;3])])
          ; (E, [Items [1;2;3;4;5]])
          ]
        , [ (A, [4])
          ; (B, [4])
          ; (C, [4; 5; 7; 8])
          ; (D, [4; 5])
          ; (E, [1; 2; 3; 4; 5])
          ]
        )
      ; SHOP
        ( [ (A, [Same B; Same C])
          ; (B, [Except (Same C, [1;2;3]); Same D])
          ; (C, [Items [1;2;3]; Items [3;4;5]; Common (Same A, Items [6;7])])
          ; (D, [Same E])
          ; (E, [Same D; Items[6;8]])
          ]
        , [ (A, [1; 2; 3; 4; 5; 6; 8])
          ; (B, [4; 5; 6; 8])
          ; (C, [1; 2; 3; 4; 5; 6])
          ; (D, [6; 8])
          ; (E, [6; 8])
          ]
        )
      ; SHOP
        ( [ (A, [Common (Same B, Common (Except (Items [1;2;3;4;5], [1;3;5]), Same C)); Items [2;4;8]])
          ; (B, [Except (Except (Except (Same A, [1]),[1;2]),[3]); Items [3;6;9]])
          ; (C, [Same A; Same B; Same D; Same E])
          ; (D, [Items [10]; Common (Same A, Same D); Items [5]])
          ; (E, [Common (Same C, Common (Same A, Common (Same D, Same B)))])
          ]
        , [ (A, [2; 4; 8])
          ; (B, [3; 4; 6; 8; 9])
          ; (C, [2; 3; 4; 5; 6; 8; 9; 10])
          ; (D, [5; 10])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (A, [Items [1;2;3;1;2;3]; Same D; Items [1;2;3;4]])
          ; (D, [Items [5;5;5;5;5]])
          ; (E, [Except (Items [1;2;3;1;2;3], [1;2;3])])
          ]
        , [ (A, [1; 2; 3; 4; 5])
          ; (B, [])
          ; (C, [])
          ; (D, [5])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (A, [Same B])
          ; (B, [Same C])
          ; (C, [Same D])
          ; (D, [Same E])
          ; (E, [Items [3;1;2]])
          ]
        , [ (A, [1;2;3])
          ; (B, [1;2;3])
          ; (C, [1;2;3])
          ; (D, [1;2;3])
          ; (E, [1;2;3])
          ]
        )
      ; SHOP
        ( [ (A, [Items [3;1;2]])
          ; (C, [Same B])
          ; (B, [Same A])
          ; (E, [Same D])
          ; (D, [Same C])
          ]
        , [ (A, [1;2;3])
          ; (B, [1;2;3])
          ; (C, [1;2;3])
          ; (D, [1;2;3])
          ; (E, [1;2;3])
          ]
        )
      ; SHOP
        ( [ (A, [Same B])
          ; (B, [Same A])
          ; (C, [])
          ; (D, [])
          ; (E, [])
          ]
        , [ (A, [])
          ; (B, [])
          ; (C, [])
          ; (D, [])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (A, [Items [1]; Same B])
          ; (B, [Items [1]; Same C])
          ; (C, [Items [1]; Same A])
          ]
        , [ (A, [1])
          ; (B, [1])
          ; (C, [1])
          ; (D, [])
          ; (E, [])
          ]
        )
      ; SHOP
        ( [ (A, [Items [1]; Same B])
          ; (B, [Same C])
          ; (C, [Same B])
          ; (D, [Same A; Common (Same B, Same C)])
          ; (E, [Same A; Same D])
          ]
        , [ (A, [1])
          ; (B, [])
          ; (C, [])
          ; (D, [1])
          ; (E, [1])
          ]
        )
      ; SHOP
        ( [ (A, [Items [1]; Except (Same B, [1])])
          ; (B, [Items [2]; Except (Same C, [2])])
          ; (C, [Items [3]; Except (Same D, [3])])
          ; (D, [Items [4]; Except (Same E, [4])])
          ; (E, [Items [5]; Except (Same A, [5])])
          ]
        , [ (A, [1;2;3;4;5])
          ; (B, [1;2;3;4;5])
          ; (C, [1;2;3;4;5])
          ; (D, [1;2;3;4;5])
          ; (E, [1;2;3;4;5])
          ]
        )
      ; SHOP
        ( [ (A, [Items [1; 2]; Common (Same B, Same C)])
          ; (B, [Common (Same C, Items [2;3])])
          ; (C, [Items [1]; Except (Same A, [3])])
          ; (D, [Common (Same A, Same B)])
          ; (E, [Common (Same A, Same C)])
          ]
        , [ (A, [1;2])
          ; (B, [2])
          ; (C, [1;2])
          ; (D, [2])
          ; (E, [1;2])
          ]
        )
      ]

    let string_of_id x =
      match x with
      A -> "A" | B -> "B" | C -> "C" | D -> "D" | E -> "E"

    let string_of_id_tuple string_of_e (x, e) =
      Printf.sprintf "%s: %s" (string_of_id x) (string_of_e e)

    let string_of_int_list = string_of_list string_of_int

    let string_of_sum_list string_of_elem l =
      l |> List.map string_of_elem |> String.concat " + "

    let string_of_id_tuple_list string_of_elem itl =
      "\n  " ^ (List.map (string_of_id_tuple string_of_elem) itl |> String.concat "\n  ") ^ "\n"

    let string_of_shoppingList =
      string_of_id_tuple_list string_of_int_list

    let rec string_of_cond c =
      match c with
      | Items gl -> string_of_int_list gl
      | Same x -> string_of_id x
      | Common (c1, c2) -> Printf.sprintf "(%s ∩ %s)" (string_of_cond c1) (string_of_cond c2)
      | Except (c, gl) -> Printf.sprintf "(%s - %s)" (string_of_cond c) (string_of_int_list gl)

    let string_of_reqs =
      string_of_list (string_of_id_tuple (string_of_list string_of_cond))

    let runner (tc: testcase): bool =
      match tc with
      | SHOP (reqs, ans) -> shoppingList reqs = ans

    let string_of_tc (tc: testcase): string * string * string =
      match tc with
      | SHOP (reqs, ans) ->
          let output = shoppingList reqs in
          ( Printf.sprintf "\n  shoppingList  %s" (string_of_id_tuple_list (string_of_sum_list string_of_cond) reqs)
          , string_of_shoppingList ans
          , string_of_shoppingList output
          )

  end

open TestEx2
let _ = wrapper testcases runner string_of_tc
