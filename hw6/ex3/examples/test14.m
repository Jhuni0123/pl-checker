(* testcase 14 : M.LET - REC *)

let val x = 10 in
let rec f = fn x =>
  x + 10
in
  write f 20;
  let rec f = fn x =>
    let val i = 5 in
      x + x - i
    end
  in
    write f 20;
    let rec g = fn x =>
      if x = 0 then 0 else g (x-1) + x
    in
      let rec g = fn x =>
        if x = 0 then 0 else if x = 1 then 0 else g (x-2) + 1
      in
        write g 11;
        write g 30
      end;
      write ( let rec g = fn x => (if x = 0 then 100 else g(x-1) + 1) in g(10) end )
    end
  end
end
end
