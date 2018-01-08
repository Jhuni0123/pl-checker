(* 29 *)

let
  rec f = fn x => 2
  rec f = fn x =>
   (if (x = 0) then
    0
   else
    (x + (f (x - 1))))
  val foo = fn f => f (10)
in
  write (foo f)
end
