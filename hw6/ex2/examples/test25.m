(* 25. Pairwise Addition *)

(fn p => p.1) ((fn p1 => (fn p2 => ((p1.1) + (p2.1), (p1.2) + (p2.2))) (10, 20)) (30, 40))
