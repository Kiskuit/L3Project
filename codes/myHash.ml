external real_myHash: string array -> int = "MyHash"

let myhash  mot size = real_myHash[|size;mot|]
