(* testcase 16 : Ops *)

write "-- integer --";
write 0-1 = 0-1;
write (10 = (10 + 10));

write "-- string --";
write "string" = "string";
write "s1" = "s2";

write "-- location --";
let val x = malloc 0 in
let val y = malloc 0 in
  write x = x;
  write x = y;
  write !x = !y
end
end;
write malloc 1 = malloc 1;
write malloc 2 = malloc 3;

write "-- boolean --";
write true = true;
write false = false;
write true = false;
write false = true;
write "-- associativity --";
write 1 = 2 = false;
write true = ("1" = "1")
