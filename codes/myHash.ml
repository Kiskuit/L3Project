external real_myHash: string array -> int = "myhash_main"

(*let myHash m s = real_myHash [|(string_of_int s);m|]*)
let int =
    real_myHash[|"8";"bonjour"|]

(*external xxhash: string array -> int = "xx32sum_main"

let int =
    xxhash[|"./test.opt";"-H0";"bonjour"|]*)
