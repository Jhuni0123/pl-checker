(*
 * SNU 4190.310 Programming Languages
 * Main driver of homework "Continuation Passing Style"
 *)

let print_m0_value v =
  match v with
  |M0.N n -> print_endline (string_of_int n)
  | _ -> failwith "Program is not evaluated to a number"

let rec check_cps cps_pgm =
  let check_const exp =
    match exp with
    | M0.Num _
    | M0.Var _
    | M0.App (M0.Var _, M0.Var _)
    | M0.Add (M0.Var _, M0.Var _)
    | M0.Pair (M0.Var _, M0.Var _)
    | M0.Fst (M0.Var _)
    | M0.Snd (M0.Var _) -> true
    | M0.Fn (_, e)
    | M0.Rec (_, _, e) -> check_cps e
    | _ -> false
  in
  let rec check_cps' exp k =
    match exp with
    | M0.App (M0.Var v1, e2) when v1 = k -> check_const e2
    | M0.App (e1, M0.Var v2) when v2 = k -> check_const e1 || check_cps e1
    | M0.App (e1, M0.Fn (v, e2)) -> check_cps e1 && check_cps' e2 k
    | M0.Ifz (M0.Var v1, e2, e3) -> check_cps' e2 k && check_cps' e3 k
    | _ -> false
  in
  match cps_pgm with
  | M0.Fn (k, exp) -> check_cps' exp k
  | _ -> false

let main () =
  let print_m = ref false in
  let print_cps = ref false in
  let check_val = ref false in
  let check_conv = ref false in
  let src = ref "" in
  let _ =
    Arg.parse
      [("-pp", Arg.Set print_m, "Print M0 program");
      ("-pcps", Arg.Set print_cps, "Print CPS-converted  program");
      ("-checkval", Arg.Set check_val, "value check-only with exit code");
      ("-checkcps", Arg.Set check_conv, "cps check-only with exit code");
      ]
      (fun x -> src := x)
      "Usage: ./run [<options>] <M0 file>"
  in

  let lexbuf =
    Lexing.from_channel (if !src = "" then stdin else open_in !src)
  in
  let pgm = Parser.program Lexer.start lexbuf in

  (* let _ = print_newline() in *)
  if !print_m then (
    let _ = print_endline "== Input Program ==" in
    let _ = M0.print pgm in
    print_newline()
  );

  let cps_pgm = Cps.cps pgm in
  if !print_cps then (
    let _ = print_endline "== CPS-converted Program ==" in
    let _ = M0.print cps_pgm in
    print_newline()
  );

  if !check_conv then (
    exit (if check_cps cps_pgm then 0 else 1)
  );

  let orig_result = M0.run pgm in
  let cps_result = M0.run (M0.App (cps_pgm, M0.Fn ("v", M0.Var "v"))) in

  if !check_val then (
    match orig_result, cps_result with
    | (M0.N n1, M0.N n2) -> exit (if n1 = n2 then 0 else 1)
    | _ -> failwith "Program is not evaluated to a number"
  );

  let _ = print_endline "== Running Input Program with M0 Interpreter ==" in
  let _ = print_m0_value orig_result in

  let _ = print_endline "== Running converted program with M0 Interpreter ==" in
  let _ = print_m0_value cps_result in
  ()

let _ = main ()
