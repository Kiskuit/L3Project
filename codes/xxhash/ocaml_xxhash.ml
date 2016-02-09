(* pour compiler: ocamlopt -o test.opt ocaml_xxhash.ml xxhsum.c xxhash.c
*)

external xxhash: string array -> int = "xx32sum_main"

let int =
	xxhash Sys.argv
