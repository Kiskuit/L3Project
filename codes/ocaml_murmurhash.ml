external real_murmurhash: string array -> int = "murmurhash_main"

let murmurhash mot size = 
    match size with
    |8 -> real_murmurhash [|mot;"8"|]
    |16 -> real_murmurhash [|mot;"16"|]
    |_ -> real_murmurhash [|mot;"30"|];;
