(* pour compiler: ocamlopt -o test.opt ocaml_xxhash.ml xxhsum.c xxhash.c
*)

external murmurhash: string array -> int = "murmurhash_main"

let int =
	murmurhash Sys.argv
