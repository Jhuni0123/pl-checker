(* Exercise 2. crazy2val *)
open Ex2
open Testlib

module TestEx2: TestEx =
  struct
    type testcase =
      | CRAZY2 of string * int

    let testcases =
      [ CRAZY2 ("0", 0)
      ; CRAZY2 ("+", 1)
      ; CRAZY2 ("-", -1)
      ; CRAZY2 ("00", 0)
      ; CRAZY2 ("0+", 2)
      ; CRAZY2 ("0-", -2)
      ; CRAZY2 ("+0", 1)
      ; CRAZY2 ("++", 3)
      ; CRAZY2 ("+-", -1)
      ; CRAZY2 ("-0", -1)
      ; CRAZY2 ("-+", 1)
      ; CRAZY2 ("--", -3)
      ; CRAZY2 ("+0+", 5)
      ; CRAZY2 ("+0-0", -3)
      ; CRAZY2 ("+--++", 19)
      ; CRAZY2 ("++-+-", -9)
      ; CRAZY2 ("00000", 0)
      ; CRAZY2 ("+++++", 31)
      ; CRAZY2 ("-----", -31)
      ; CRAZY2 ("+-++-", -5)
      ; CRAZY2 ("0+0+", 10)
      ; CRAZY2 ("0-++", 10)
      ; CRAZY2 ("0--0+", 10)
      ; CRAZY2 ("0+0-+", 10)
      ; CRAZY2 ("0-+-+", 10)
      ; CRAZY2 ("++++++++++++++++++++", 1048575)
      ; CRAZY2 ("--------------------", -1048575)
      ; CRAZY2 ("+++++++++0++++++++++", 1048063)
      ; CRAZY2 ("----------0---------", -1047551)
      ; CRAZY2 ("++++-++++0++++++++++", 1048031)
      ; CRAZY2 ("---------+0---------", -1046527)
      ]

    let crazy2_of_string str =
      let rec crazy2_of_char_list l =
        match l with
        | [] -> NIL
        | h::t ->
            if h = '+' then ONE (crazy2_of_char_list t)
            else if h = '-' then MONE (crazy2_of_char_list t)
            else if h = '0' then ZERO (crazy2_of_char_list t)
            else failwith "only '+-0' are allowed"
      in crazy2_of_char_list (List.rev (char_list_of_string str))

    let runner tc =
      match tc with
      | CRAZY2 (str, ans) -> crazy2val (crazy2_of_string str) = ans

    let string_of_tc tc =
      match tc with
      | CRAZY2 (str, ans) -> ("crazy2val " ^ str, string_of_int ans, string_of_int (crazy2val (crazy2_of_string str)))
  end

open TestEx2
let _ = wrapper testcases runner string_of_tc
