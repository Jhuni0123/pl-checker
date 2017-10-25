(* Exercise 3. crazy2add *)
open Ex3
open Testlib

module TestEx3: TestEx =
  struct
    type testcase =
      | ADD of string * string * int

    let testcases =
      [ ADD ("0", "0", 0)
      ; ADD ("0", "+", 1)
      ; ADD ("0", "-", -1)
      ; ADD ("+", "0", 1)
      ; ADD ("+", "+", 2)
      ; ADD ("+", "-", 0)
      ; ADD ("-", "0", -1)
      ; ADD ("-", "+", 0)
      ; ADD ("-", "-", -2)
      ; ADD ("00", "0", 0)
      ; ADD ("00", "+", 1)
      ; ADD ("00", "-", -1)
      ; ADD ("0+", "0", 2)
      ; ADD ("0+", "+", 3)
      ; ADD ("0+", "-", 1)
      ; ADD ("0-", "0", -2)
      ; ADD ("0-", "+", -1)
      ; ADD ("0-", "-", -3)
      ; ADD ("-+", "0", 1)
      ; ADD ("-+", "+", 2)
      ; ADD ("-+", "-", 0)
      ; ADD ("+-", "0", -1)
      ; ADD ("+-", "+", 0)
      ; ADD ("+-", "-", -2)
      ; ADD ("+++", "-++", 12)
      ; ADD ("0++", "---", -1)
      ; ADD ("0+-", "0+-", -4)
      ; ADD ("000000", "-", -1)
      ; ADD ("+-+-+-+", "-+-+-+-", 0)
      ; ADD ("+-+-+-+-+-+-+-+", "-+-+-+-+-+-+-+-", 0)
      ; ADD ("++++++++++++++++++++", "++++++++++++++++++++", 2097150)
      ; ADD ("--------------------", "--------------------", -2097150)
      ; ADD ("-++--00+0--+0+++-+0-", "++-0+00+---0++-++-0+", 84988)
      ; ADD ("0000000000", "0000000000+", 1024)
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

    let magic c =
      let d i=i*2 in let p i=d(
      i)+1 in let m i=d(i)-1 in
      let rec t c= match c with
      NIL->0|ZERO c'->d(t c')|ONE
      c'->p(t c')|MONE c'->m(t c')
      in t c

    let runner tc =
      match tc with
      | ADD (c1, c2, ans) -> magic (crazy2add ((crazy2_of_string c1), (crazy2_of_string c2))) = ans

    let string_of_tc tc =
      match tc with
      | ADD (c1, c2, ans) ->
          ( Printf.sprintf "crazy2add(%s, %s)" c1 c2
          , string_of_int ans
          , string_of_int (magic (crazy2add ((crazy2_of_string c1), (crazy2_of_string c2))))
          )
  end

open TestEx3
let _ = wrapper testcases runner string_of_tc
