(*
 * SNU 4190.310 Programming Languages
 *
 * Main Interface for M
 *)

open M
open Pp

let handle_exn_simple v =
  match v with
  | Error.Lex_err (s, i) ->
      Printf.eprintf ">> lexical error at line %d: %s\n" i s
  | Parsing.Parse_error ->
      Printf.eprintf ">> syntax error at line %d\n" !Error.linenum
  | Arg.Bad s ->
      Printf.eprintf ">> file format error: %s\n" s
  | M.RunError s ->
      Printf.printf "runtime error\n"
  | M.TypeError s ->
      Printf.printf "type error\n"
  | _ -> raise v

let run () =
  let print_m = ref false in
  let result_only = ref false in
  let src = ref "" in
  let _ =
    Arg.parse
      [("-pp", Arg.Set print_m, "Print M program");
      ("-resonly", Arg.Set result_only, "Print clean result only");
      ]
      (fun x -> src := x)
      "Usage: ./run [<options>] <M file>"
  in
  if !result_only then (
    (try
      let _ = Error.init () in
      let lexbuf =
        Lexing.from_channel (if !src = "" then stdin else open_in !src)
      in
      let pgm = Parser.program Lexer.start lexbuf in
      M.run pgm
    with v -> handle_exn_simple v
    );
    exit 0
  );
  try
    let _ = Error.init () in
    let lexbuf =
      Lexing.from_channel (if !src = "" then stdin else open_in !src)
    in
    let pgm = Parser.program Lexer.start lexbuf in
    if !print_m then (
      let _ = print_string "== Input Program ==\n" in
      let _ = M_Printer.print pgm in
      print_newline()
    );
    let _ = print_string "== Running with M Interpreter ==\n" in
    M.run pgm
  with v -> Error.handle_exn v

let _ = Printexc.catch run ()
