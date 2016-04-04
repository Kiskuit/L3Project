external real_murmurhash: string array -> int = "murmurhash_mask"

let murmurhash mot size = real_murmurhash[|mot|];;
