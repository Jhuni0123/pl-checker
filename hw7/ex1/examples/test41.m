(* Test 41 : Non-terminating program must pass type checking too *)

let val id = fn x => x
    rec f = fn x =>
      write "Entering loop";
      write !x;
      x := id (!x);
      f x
in
  if (id true) then
    1 + (f (malloc 10))
  else
    0 - (f (malloc true))
end
