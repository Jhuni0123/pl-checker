(* testcase 11 : M.ID *)

let val i = 10 in
  write i;
  let val j = 20 in
    write j;
    let val i = 30 in
      write i;
      write j
    end
  end
end
