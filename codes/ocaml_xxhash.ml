(* pour compiler: ocamlopt -o test.opt ocaml_xxhash.ml xxhsum.c xxhash.c
*)

external real_xxhash: string array -> int = "xx32sum_main"

(*let int =
	(*xxhash Sys.argv*)
        xxhash [|"./test.opt";"-H0";"bonjour"|]*)
let xxhash mot size = 
    match size with
    |8 -> real_xxhash [|"./a.out";"-H0";mot|]
    |16 -> real_xxhash [|"./a.out";"-H1";mot|]
    |_ -> real_xxhash [|"./a.out";"-H2";mot|];;
