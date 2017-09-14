let correctSymbol =
    "\x1b[32m✓\x1b[37m"

let wrongSymbol =
    "\x1b[31m✗\x1b[37m"

let string_of_case (n: int) =
    "Case " ^ (string_of_int n)

let string_of_frac a b =
    (string_of_int a) ^ " / " ^ (string_of_int b)

let res_string (cor: bool) (n: int) =
    let sym = if cor then correctSymbol else wrongSymbol in
        sym ^ " " ^ (string_of_case n)
