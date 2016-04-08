external real_djb: string array -> int = "djb_ocaml"

let djb mot size = 
    match size with
    |8 -> real_djb [|mot;"8"|]
    |16 -> real_djb [|mot;"16"|]
    |_ -> real_djb [|mot;"30"|];;
