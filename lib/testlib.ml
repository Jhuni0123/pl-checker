open Printf

let correct_symbol =
  "\x1b[32m✓\x1b[0m"

let wrong_symbol =
  "\x1b[31m✗\x1b[0m"

let test_testcase num tc runner string_of_tc =
  if runner tc then printf "%s Test %d\n%!" correct_symbol num
  else
    let (tc_s, ans_s, output_s) = string_of_tc tc in
    printf "%s Test %d: %s\n  answer: %s, output: %s\n%!" wrong_symbol num tc_s ans_s output_s

let test_testcase2 num tc runner result_of_tc print_res =
  if runner tc then printf "%s Test %d\n%!" correct_symbol num
  else
    let (tc_s, ans, out) = result_of_tc tc in
    let _ = printf "%s Test %d: %s\n  answer: %!" wrong_symbol num tc_s in
    let _ = print_res ans in
    let _ = print_string ", output: " in
    let _ = print_res out in
    print_newline ()

let test_exercise tcs runner string_of_tc =
  let rec test_exercise_ tcnum tcs runner =
    match tcs with
    | [] -> ()
    | tc::tcs' ->
        let _ = test_testcase tcnum tc runner string_of_tc
        in test_exercise_ (tcnum+1) tcs' runner
  in test_exercise_ 1 tcs runner

let test_exercise2 tcs runner result_of_tc print_res =
  let rec test_exercise_ tcnum tcs runner =
    match tcs with
    | [] -> ()
    | tc::tcs' ->
        let _ = test_testcase2 tcnum tc runner result_of_tc print_res
        in test_exercise_ (tcnum+1) tcs' runner
  in test_exercise_ 1 tcs runner

let summary_exercise tcs runner =
  let total = List.length tcs in
  let passed = List.length (List.filter runner tcs) in
  printf "%s Passed %d/%d Cases\n" (if passed = total then correct_symbol else wrong_symbol) passed total

let wrapper a1 a2 a3 =
  if Array.length Sys.argv = 1 then
    test_exercise a1 a2 a3
  else
    summary_exercise a1 a2

let wrapper2 a1 a2 a3 a4 =
  if Array.length Sys.argv = 1 then
    test_exercise2 a1 a2 a3 a4
  else
    summary_exercise a1 a2

module type TestEx =
  sig
    type testcase

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
