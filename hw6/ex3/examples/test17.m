(* testcase 17 : M.BANG *)

write !(malloc 10);
write !(let val x = malloc 20 in x end);
let val a = malloc 0 in
  write !(a := 20; a);
  write !a
end
