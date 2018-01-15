(* test 48 : not expansive example *)

let val f =
  let rec f =
    fn x => if true then f x else x
  in
    f
  end
in
  (f 1, f true)
end
