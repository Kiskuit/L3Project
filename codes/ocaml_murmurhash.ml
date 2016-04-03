external real_murmurhash: string array -> int = "murmurhash_main"

let murmurhash mot size = real_murmurhash[|mot|];;
