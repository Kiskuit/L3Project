open myHash;;


(* Checks if the hashtable contains a certain value *)
let contains ht s =
        let l = Hashtbl.find_all ht (myHash s) in
        let rec helper l = 
                match l with
                |[] -> false
                |a::t -> if (a=s) then true else (helper t);;


(* Adds an element to the hashtable, if it's not inside already *)
let add ht s =
        let v = myHash s in
        if (contains ht s) then () else Hashtbl.add ht v s;;
