(* 23 *)

let val x = malloc (1, true) in
  if (x.2 and (x.1 = 1)) then
    write (x.1 + x.2)
  else
    write x.1
end
