open Printf

let correctSymbol =
    "\x1b[32m✓\x1b[0m"

let wrongSymbol =
    "\x1b[31m✗\x1b[0m"

let string_of_case (n: int) =
    "Case " ^ (string_of_int n)

let string_of_frac (a, b) =
    (string_of_int a) ^ " / " ^ (string_of_int b)

let res_string (cor: bool) (n: int) =
    let sym = if cor then correctSymbol else wrongSymbol in
        sym ^ " " ^ (string_of_case n)

let rate_of_result res =
    (List.length (List.filter (fun x -> x) res), List.length res)

let print_correct num =
    printf "- Test %d Correct! %s\n" num correctSymbol

let print_wrong num =
    printf "- Test %d Wrong.. %s\n" num wrongSymbol

let test_testcase tc runner num =
    if runner tc then print_correct num
    else print_wrong num

let test_exercise tcs runner exnum =
    let _ = printf "# Test Exercise %d\n" exnum in
    let rec test_exercise_ tcs runner tcnum =
        match tcs with
        | [] -> ()
        | tc::tcs' ->
                let _ = test_testcase tc runner tcnum
                in test_exercise_ tcs' runner (tcnum+1)
    in test_exercise_ tcs runner 1

let summary_exercise tcs runner exnum =
    let _ = printf "# Test Exercise %d\n" exnum in
    let total = List.length tcs in
    let passed = List.length (List.filter runner tcs) in
    printf "- Passed %d/%d Cases %s\n" passed total (if passed = total then correctSymbol else wrongSymbol)

let wrapper =
    if Array.length Sys.argv = 1 then
        test_exercise
    else
        summary_exercise
