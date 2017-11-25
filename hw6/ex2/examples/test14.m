(* testcase 14 : cps of (cps Num) *)

(fn x => x (123)) (fn a => a)
