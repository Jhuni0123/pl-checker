(* testcase 15 : M.IF *)

let val i = (malloc 0) in
  (if (i := 0) = 0 then
    write (i := 100)
  else
    write (i := 200)
  );
  if (write !i) = 200 then
    write 1
  else
    write 2
end
