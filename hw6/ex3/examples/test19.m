(* testcase 19 : M.MALLOC *)

let val x = malloc 0 in
  let val y = malloc (x := 10) in
    write !x;
    write !y
  end
end
