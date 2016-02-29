external real_myHash: string array -> int = "MyHash"

let myHash m s = real_myHash [|(string_of_int s);m|]

(*external xxhash: string array -> int = "xx32sum_main"

let int =
    xxhash[|"./test.opt";"-H0";"bonjour"|]*)
