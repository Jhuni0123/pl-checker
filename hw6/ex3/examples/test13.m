(* testcase 13 : M.LET - VAL *)

let val i = ( let val i = 10 + 10 in i + i end ) in
  write i;
  let val i = ( let val i = i + i in i + i end ) in
    write i;
    write ( let val j = ( let val j = 5 in j + j + j end ) in j + 10 end )
  end
end
