external real_sdbm: string array -> int = "sdbm_main"

let sdbm mot size = 
    match size with
    |8 -> real_sdbm [|mot;"8"|]
    |16 -> real_sdbm [|mot;"16"|]
    |_ -> real_sdbm [|mot;"30"|];;
