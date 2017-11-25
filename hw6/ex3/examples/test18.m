(* testcase 18 : M.ASSIGN *)

let val x = malloc 0 in
  let val y = malloc 10 in
    write (x := 5; y) := 20;
    write !x;
    write (x := (y := 10));
    write !y
  end
end


