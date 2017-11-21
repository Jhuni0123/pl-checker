open Sm5.Sm5

let _ = gc_mode := true

let check_exception cmd =
  try let _ = run cmd in false with GC_Failure -> true

(* concat command n times *)
let append_n (n: int) (f: int -> command) (cmd: command) : command =
  let rec iter i =
    if i = n then []
    else (f i) @ iter (i + 1) in cmd @ (iter 0)

let append cmd' cmd = cmd @ cmd'


type testcase =
  | GC_FAIL of command
  | RUN of command * int list

let testcases : testcase list =
  [
    (* 1. Simple malloc & use : trigger gc and success *)
    RUN ( (* To be collected *)
      [
        PUSH (Val (Z 1));
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
        PUSH (Val (Z 10));
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
      [137]
    )
  ;
    (* 2. Simple malloc & use : gc fails *)
    GC_FAIL (
      []

      |> append_n 128 (fun _ -> [
        MALLOC;
        BIND "x";
        PUSH (Val (Z 200));
        PUSH (Id "x");
        STORE;
        ]
      )

      |> append [
        (* Trigger GC *)
        PUSH (Val (Z 400));
        MALLOC;
        STORE;
      ]

      (* Access all the allocated memory locations, ensuring they must not have been collected *)
      |> append_n 128 (fun _ -> [
        PUSH (Id "x");
        LOAD;
        POP;

        UNBIND;
        POP;
        ]
      )
    )
  ;
    (* 3. Gc must be able to track record : gc fail *)
    GC_FAIL (
      []

      |> append_n 126 (fun i ->
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
        BIND "loc";

        PUSH (Val (Z 1));
        PUSH (Id "loc");
        STORE;

        UNBIND;
        BOX 1
      ]

      |> append [
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
      |> append_n 126 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          PUSH (Id v);
          LOAD;
          POP;
        ]
      )

      |> append [
        PUSH (Id "box");
        LOAD;
        UNBOX "loc";
        LOAD
      ]
    )
  ;
    (* 4. GC must be able to track locations in the 'Continuation' : gc fails *)
    GC_FAIL (
      [
        PUSH (Fn ("x", [
          (* Trigger GC *)
          PUSH (Val (Z 1));
          MALLOC;
          STORE;

          (* Access argument location, ensuring it must not have been collected *)
          PUSH (Id "x");
          LOAD;
          POP;
        ]));
        BIND "f";
      ]

      |> append_n 127 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          MALLOC;
          BIND v;
          PUSH (Val (Z i));
          PUSH (Id v);
          STORE
        ]
      )

      |> append [
        PUSH (Id "f");
        PUSH (Val (Z 1));
        MALLOC;
        CALL;
      ]

      (* Access all the allocated memory locations, ensuring they must not have been collected *)
      |> append_n 127 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          PUSH (Id v);
          LOAD;
          POP;
        ]
      )
    )
  ;
    (* 5. Location allocated in function can be collected after return : gc success *)
    RUN (
      [
        PUSH (Fn ("x", [
          (* To be collected *)
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
          PUSH (Val (Z 5));
          PUSH (Id v);
          STORE;
        ]
      )

      |> append [
        PUSH (Id "f");
        PUSH (Val (Z 1));
        MALLOC;
        CALL;

        (* Trigger GC *)
        PUSH (Val (Z 10));
        MALLOC;
        STORE;
      ]

      |> append [PUSH (Val (Z 0))]

      (* Check if allocated memory location's values are not affected by GC() *)
      |> append_n 126 (fun i ->
        let v = Printf.sprintf "x%d" i in [
          PUSH (Id v);
          LOAD;
          ADD
        ]
      )

      |> append [PUT]
    , (* Output *)
      [630]
    )
  ]

let runner testcase =
  match testcase with
  | RUN (cmd, l) ->
      run cmd;
      List.iter (fun n -> print_endline (string_of_int n)) l
  | GC_FAIL cmd ->
      try run cmd
      with
      | GC_Failure -> print_endline (string_of_bool true)
      | _ -> print_endline "fail"

let _ = List.iter runner testcases


(* Deprecated in 2017 *)
(* GC must not miss a location with different offset *)
let cmds6 =
  (* Location to be collected *)
  [PUSH (Val (Z 1)); MALLOC; STORE]

  (* Allocate, bind and store 126 times *)
  |> append_n 126 (fun i ->
    let v = Printf.sprintf "x%d" i in [
      MALLOC;
      BIND v;
      PUSH (Val (Z 1));
      PUSH (Id v);
      STORE;
    ]
  )

  (* Another location with same base, different offset *)
  |> append [
    PUSH (Val (Z 500));
    PUSH (Id "x0");
    PUSH (Val (Z 10));
    ADD;
    STORE;   (* Env : "x0" ==> (a, 0) / Mem : (a, 10) ==> 500 *)
    ]

  (* Trigger GC *)
  |> append [
    MALLOC;
    BIND "foo";
    PUSH (Val (Z 1));
    PUSH (Id "foo");
    STORE
  ]

  |> append [
    PUSH (Id "x0");
    PUSH (Val (Z 10));
    ADD;
    LOAD;
    PUT
  ]

