(* pour compiler: ocamlopt -o test.opt ocaml_xxhash.ml xxhsum.c xxhash.c
*)

external real_murmurhash: string array -> int = "murmurhash_main"

(*let int =
	murmurhash Sys.argv*)
let murmurhash mot size = real_murmurhash[|mot|];;
