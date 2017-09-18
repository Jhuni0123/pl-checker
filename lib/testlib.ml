open Printf

let correct_symbol =
  "\x1b[32m✓\x1b[0m"

let wrong_symbol =
  "\x1b[31m✗\x1b[0m"

let test_testcase num tc runner string_of_tc =
  if runner tc then printf "%s Test %d\n" correct_symbol num
  else
    let (tc_s, ans_s, output_s) = string_of_tc tc in
    printf "%s Test %d: %s\n  Wrong... answer: %s, output: %s\n" wrong_symbol num tc_s ans_s output_s

let test_exercise exnum tcs runner string_of_tc =
  let _ = printf "# Test Exercise %d\n" exnum in
  let rec test_exercise_ tcnum tcs runner =
    match tcs with
    | [] -> ()
    | tc::tcs' ->
        let _ = test_testcase tcnum tc runner string_of_tc
        in test_exercise_ (tcnum+1) tcs' runner
  in test_exercise_ 1 tcs runner

let summary_exercise exnum tcs runner =
  let _ = printf "# Test Exercise %d\n" exnum in
  let total = List.length tcs in
  let passed = List.length (List.filter runner tcs) in
  printf "- Passed %d/%d Cases %s\n" passed total (if passed = total then correct_symbol else wrong_symbol)

let wrapper a1 a2 a3 a4 =
  if Array.length Sys.argv = 1 then
    test_exercise a1 a2 a3 a4
  else
    summary_exercise a1 a2 a3

module type TestEx =
  sig
    type testcase

    val exnum: int
    val testcases: testcase list
    val runner: testcase -> bool
    (* str_of_input: string * string_of_ans: string * string_of_output: string *)
    val string_of_tc: testcase -> string * string * string
  end

let char_list_of_string str =
  let rec char_list_of_string_ str idx lim l =
    if idx < lim then char_list_of_string_ str (idx+1) lim (str.[idx]::l)
    else l
  in char_list_of_string_ str 0 (String.length str) []

let string_of_list string_of_elem ls =
  "[" ^ (String.concat "; " (List.map string_of_elem ls)) ^ "]"
