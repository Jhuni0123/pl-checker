(* 28 *)

let
 rec sum = fn x =>
   if (x = 0) then
     0
   else
     (x + sum (x - 1))
 rec diag = fn x =>
   if (x = 0) then
     0
   else
     (sum x + diag (x - 1))
in
  write (diag (sum 5))
end
