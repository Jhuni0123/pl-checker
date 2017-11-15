(*
 * SNU 4190.310 Programming Languages 
 *
 * SM5
 *)

open Translate
open Pp
open Sm5
open K

let main () =
  let pk = ref false in
  let psm5 = ref false in
  let k = ref false in
  let src = ref "" in
  let filename = Filename.basename Sys.argv.(0) in
  let _ =
    Arg.parse
      [("-pk", Arg.Set pk, "display K- parse tree");
      ("-psm5", Arg.Set psm5, "print translated sm5 code");
      ("-k", Arg.Set k, "run using K interpreter");
      ("-gc", Arg.Set Sm5.gc_mode, "run with garbage collection");
      ("-debug", Arg.Set Sm5.debug_mode, "prints machine state every step")]
      (fun x -> src := x)
      ("Usage: " ^ filename ^ " [-pk | -psm5 | -k] [-gc] [-debug] [file]")
  in
  let lexbuf = Lexing.from_channel (if !src = "" then stdin else open_in !src) in
  let pgm = Parser.program Lexer.start lexbuf in
   
  if !pk then 
    KParseTreePrinter.print pgm
  else if !psm5 then 
    print_endline (Sm5.command_to_str "" (Translator.trans pgm))
  else if !k then 
    ignore (K.run pgm)
  else 
    Sm5.run (Translator.trans pgm)

let _ = main ()
