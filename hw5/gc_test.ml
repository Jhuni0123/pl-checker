open Testlib
open Sm5.Sm5

(* Set the Sm5.gc_mode flag *)

let _ = gc_mode := true

let stdout_redirect_f = "stdout_redirect.txt"

let read_all filename =
  let chan = open_in filename in
  let res = really_input_string chan (in_channel_length chan) in
  let _ = close_in chan in
  res


let check_exception cmd =
  try let _ = run cmd in false with GC_Failure -> true

(* concat command n times *)
let append_n (n: int) (f: int -> command) (cmd: command) : command =
  let rec iter i =
    if i = n then []
    else (f i) @ iter (i + 1) in cmd @ (iter 0)

let append cmd' cmd = cmd @ cmd'

type testcase =
  | GCFAIL of command
  | RUN of command * int list


let testcases : testcase list =
  [
    (* 1. Simple malloc & use : trigger gc and fail *)
    GCFAIL (
      []

      |> append_n 129 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          MALLOC;
          BIND v;
          PUSH (Val (Z i));
          PUSH (Id v);
          STORE;
        ]
      )

      (* Access all the allocated memory locations, ensuring they must not have been collected *)
      |> append_n 128 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          PUSH (Id v);
          LOAD;
          POP;
        ]
      )
    )

    (* 2. Simple malloc & use : trigger gc and success *)
  ; RUN (
      (* To be collected *)
      [ PUSH (Val (Z 1));
        MALLOC;
        STORE;
      ]

      |> append_n 127 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          MALLOC;
          BIND v;
          PUSH (Val (Z 1));
          PUSH (Id v);
          STORE;
        ]
      )

      (* Trigger GC *)
      |> append [
        MALLOC;
        BIND "x_new";
        PUSH (Val (Z 100));
        PUSH (Id "x_new");
        STORE;

        PUSH (Id "x_new");
        LOAD;
      ]

      (* Check if allocated memory location's values are not affected by GC() *)
      |> append_n 127 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          PUSH (Id v);
          LOAD;
          ADD;
        ]
      )

      |> append [PUT]

    , (* Output *)
      [227]
    )

  (* 3. GC must be able to track the location chain : gc fail *)
  ; GCFAIL (
      [ MALLOC;
        BIND "start";
        PUSH (Id "start");
        BIND "cur";
      ]

      |> append_n 127 (fun _ ->
        [ MALLOC;
          PUSH (Id "cur");
          STORE;

          PUSH (Id "cur");
          LOAD;

          UNBIND;
          POP;

          BIND "cur";
        ]
      )

      |> append [PUSH (Val (Z 100)); PUSH (Id "cur"); STORE]

      (* Trigger GC *)
      |> append [
        MALLOC;
        BIND "foo";
        PUSH (Val (Z 1));
        PUSH (Id "foo");
        STORE
      ]

      |> append [
        PUSH (Val (Z 1));
        PUSH (Id "start")
      ]

      (* Access all the allocated memory locations, ensuring they must not have been collected *)
      |> append_n 127 (fun _ ->
        [LOAD]
      )

      |> append [STORE]
    )

  (* 4. Gc must be able to track the location chain : gc success *)
  ; RUN (
      (* To be collected *)
      [ PUSH (Val (Z 1));
        MALLOC;
        STORE;
      ]

      |> append [
        MALLOC;
        BIND "start";
        PUSH (Id "start");
        BIND "cur";
      ]

      (* 126 times instead of 127 *)
      |> append_n 126 (fun _ ->
        [ MALLOC;
          PUSH (Id "cur");
          STORE;

          PUSH (Id "cur");
          LOAD;

          UNBIND;
          POP;

          BIND "cur";
        ]
      )

      |> append [
        PUSH (Val (Z 99));
        PUSH (Id "cur");
        STORE;
      ]

      (* Trigger GC *)
      |> append [
        MALLOC;
        BIND "foo";
        PUSH (Val (Z 1));
        PUSH (Id "foo");
        STORE;
      ]

      |> append [PUSH (Id "start")]

      (* Access all the allocated memory locations, ensuring they must not have been collected *)
      |> append_n 126 (fun _ ->
        [LOAD;]
      )

      |> append [LOAD; PUT]

    , (* Output *)
      [99]
    )

  (* 5. Alternatedly : gc success *)
  ; RUN (
      (* Trigger GC *)
      []
      |> append_n 128 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          (* To be collected *)
          PUSH (Val (Z 1));
          MALLOC;
          STORE;

          (* Not to be collected *)
          MALLOC;
          BIND v;
          PUSH (Val (Z 10));
          PUSH (Id v);
          STORE
        ]
      )

    (* Check if allocated memory location's values are not affected by GC() *)
      |> append [PUSH (Val (Z 0))]
      |> append_n 128 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          PUSH (Id v);
          LOAD;
          ADD;
          ]
      )

      |> append [PUT]
    , (* Output *)
      [1280]
    )

  (* 6. Alternatedly : gc fail *)
  ; GCFAIL (
      (* Trigger GC *)
      []
      |> append_n 128 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          (* Not to be collected *)
          MALLOC;
          BIND v;
          PUSH (Val (Z 1));
          PUSH (Id v);
          STORE;

          (* To be collected *)
          PUSH (Val (Z 1));
          MALLOC;
          STORE
        ]
      )

    (* Check if allocated memory location's values are not affected by GC() *)
      |> append [PUSH (Val (Z 0))]
      |> append_n 128 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          PUSH (Id v);
          LOAD;
          ADD;
        ]
      )

      |> append [PUT]
    )

  (* 7. Gc must be able to track record : gc fail *)
  ; GCFAIL (
      []
      |> append_n 124 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          MALLOC;
          BIND v;
          PUSH (Val (Z i));
          PUSH (Id v);
          STORE;
        ]
      )

      |> append [
        MALLOC;
        BIND "x";
        PUSH (Val (Z 100));
        PUSH (Id "x");
        STORE;

        MALLOC;
        BIND "loc_field";
        PUSH (Id "x");
        PUSH (Id "loc_field");
        STORE;
        UNBIND;

        MALLOC;
        BIND "z_field";
        PUSH (Val (Z 200));
        PUSH (Id "z_field");
        STORE;

        UNBIND;
        BOX 2;

        MALLOC;
        BIND "box";

        PUSH (Id "box");
        STORE;

        (* Trigger GC *)
        PUSH (Val (Z 1));
        MALLOC;
        STORE;
      ]

      (* Access all the allocated memory locations, ensuring they must not have been collected *)
      |> append_n 124 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          PUSH (Id v);
          LOAD;
          POP;
        ]
      )

      |> append [
        PUSH (Id "box");
        LOAD;
        UNBOX "z_field";
        LOAD;
        PUT;
      ]

      |> append [
        PUSH (Id "box");
        LOAD;
        UNBOX "loc_field";
        LOAD;
        LOAD;
        PUT;
      ]
    )

  (* 8. Gc must be able to track record : gc success *)
  ; RUN (
      []
      |> append_n 123 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          MALLOC;
          BIND v;
          PUSH (Val (Z i));
          PUSH (Id v);
          STORE;
        ]
      )

      |> append [
        MALLOC;
        BIND "x";
        PUSH (Val (Z 100));
        PUSH (Id "x");
        STORE;

        MALLOC;
        BIND "loc_field";
        PUSH (Id "x");
        PUSH (Id "loc_field");
        STORE;
        UNBIND;

        MALLOC;
        BIND "z_field";
        PUSH (Val (Z 200));
        PUSH (Id "z_field");
        STORE;

        UNBIND;
        BOX 2;

        MALLOC;
        BIND "box";

        PUSH (Id "box");
        STORE;

        (* Trigger GC *)
        PUSH (Val (Z 1));
        MALLOC;
        STORE;
      ]

  (* Access all the allocated memory locations, ensuring they must not have been collected *)
      |> append_n 123 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          PUSH (Id v);
          LOAD;
          POP;
        ]
      )

      |> append [
        PUSH (Id "box");
        LOAD;
        UNBOX "loc_field";
        LOAD;
        LOAD;
        PUT;
      ]

      |> append [
        PUSH (Id "box");
        LOAD;
        UNBOX "z_field";
        LOAD;
        PUT;
      ]

    , (* Output *)
      [100; 200]
    )

  (* 9. Location allocated in function can be collected in 2nd call : gc success *)
  ; RUN (
      [ PUSH (Fn ("x", [
          (* Trigger GC / At the same time, to be collected in the second call *)
          MALLOC;
          BIND "local";
          PUSH (Val (Z 1));
          PUSH (Id "local");
          STORE;

          (* Access argument location, ensuring it must not have been collected *)
          PUSH (Id "x");
          LOAD;
          POP;
        ]));

        BIND "f";
      ]

      |> append_n 126 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          MALLOC;
          BIND v;
          PUSH (Val (Z 2));
          PUSH (Id v);
          STORE;
        ]
      )

      |> append [
        MALLOC;
        BIND "arg";

        (* First Call *)
        PUSH (Id "f");
        PUSH (Val (Z 1));
        PUSH (Id "arg");
        CALL;

        (* Second Call *)
        PUSH (Id "f");
        PUSH (Val (Z 2));
        PUSH (Id "arg");
        CALL;
      ]

    (* Check if allocated memory location's values are not affected by GC() *)
      |> append [PUSH (Val (Z 0));]
      |> append_n 126 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          PUSH (Id v);
          LOAD;
          ADD
        ]
      )

      |> append [PUT]
    , (* Output *)
      [252]
    )

  (* 10. Location allocated in function can be collected in 2nd call : gc fail *)
  ; GCFAIL (
      [ PUSH (Fn ("x", [
          (* Trigger GC / At the same time, to be collected in the second call *)
          MALLOC;
          BIND "local";
          PUSH (Val (Z 1));
          PUSH (Id "local");
          STORE;

          (* Access argument location, ensuring it must not have been collected *)
          PUSH (Id "x");
          LOAD;
          POP;
        ]));

        BIND "f";
      ]

      |> append_n 126 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          MALLOC;
          BIND v;
          PUSH (Val (Z 2));
          PUSH (Id v);
          STORE;
        ]
      )

      |> append [
        MALLOC;
        BIND "arg";

        (* First Call *)
        PUSH (Id "f");
        PUSH (Val (Z 1));
        PUSH (Id "arg");
        CALL;

        (* Allocate and bind new loc *)
        MALLOC;
        BIND "tmp";
        PUSH (Val (Z 3));
        PUSH (Id "tmp");
        STORE;

        (* Second Call *)
        PUSH (Id "f");
        PUSH (Val (Z 2));
        PUSH (Id "arg");
        CALL;
      ]

    (* Check if allocated memory location's values are not affected by GC() *)
      |> append [PUSH (Val (Z 0));]
      |> append_n 126 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          PUSH (Id v);
          LOAD;
          ADD
        ]
      )

      |> append [
        PUSH (Id "tmp");
        LOAD;
        ADD;
        PUT
      ]
    )
  ]


let print_to_fd fd str =
  let out_chan = Unix.out_channel_of_descr fd in
  let _ = output out_chan (str^"\n") 0 ((String.length str) + 1) in
  let _ = flush out_chan in
  ()


let run_in_string cmd =
  (* Redirect standard output *)
  let save_stdout = Unix.dup Unix.stdout in
  let new_stdout = open_out stdout_redirect_f in
  let _ = Unix.dup2 (Unix.descr_of_out_channel new_stdout) Unix.stdout in
  let _ = close_out new_stdout in
  let res =
    try run cmd; Some (read_all stdout_redirect_f)
    with GC_Failure -> None
  in
  let _ = Unix.dup2 save_stdout Unix.stdout in
  let _ = Unix.close save_stdout in
  res


let runner tc =
  match tc with
  | RUN (cmd, l) ->
      let res = run_in_string cmd in
      let ans =
        List.fold_left (fun str n -> str ^ (string_of_int n) ^ "\n") "" l
      in
      res = Some ans
  | GCFAIL cmd ->
      let res = run_in_string cmd
      in res = None

let string_of_tc tc =
  let gc_fail_msg = "exception GC_Failure" in
  match tc with
  | RUN (cmd, l) ->
      let res = run_in_string cmd in
      let ans =
        List.fold_left (fun str n -> str ^ (string_of_int n) ^ "\n") "" l
      in
      let out =
        match res with
        | Some str -> str
        | None -> gc_fail_msg
      in
      ("", "\n" ^ out ^ "\n", "\n" ^ ans)
  | GCFAIL cmd ->
      let res = run_in_string cmd in
      let out =
        match res with
        | Some str -> str
        | None -> gc_fail_msg
      in
      ("", "\n" ^ out ^ "\n", "\n" ^gc_fail_msg)

let _ = wrapper testcases runner string_of_tc
