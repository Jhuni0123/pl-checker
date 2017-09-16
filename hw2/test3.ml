(* Exercise 3. crazy2add *)
open Ex3
open Testlib

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

let obf c =
  let d i=i*2 in let p i=d(
  i)+1 in let m i=d(i)-1 in
  let rec t c= match c with
  NIL->0|ZERO c'->d(t c')|ONE
  c'->p(t c')|MONE c'->m(t c')
  in t c

module TestEx3: TestEx =
  struct
    let exnum = 3

    type testcase =
      | ADD of string * string * int

    let runner tc =
      match tc with
      | ADD (c1, c2, o) -> obf (crazy2add ((crazy2_of_string c1), (crazy2_of_string c2))) = o

    let testcases =
      [ ADD ("0", "0", 0)
      ; ADD ("+", "+", 2)
      ; ADD ("-", "-", -2)
      ; ADD ("++", "--", 0)
      ; ADD ("+-+-+-+", "-+-+-+-", 0)
      ; ADD ("000000", "-", -1)
      ]
  end

open TestEx3
let _ = wrapper testcases runner exnum
