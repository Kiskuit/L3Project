external real_myHash: string array -> int = "MyHash"

let myhash  mot size = real_myHash[|(string_of_int size);mot|];;
