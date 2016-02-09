open myHash;;
open Printf;;

let hashTable = Hashtbl.create 65536;;


(* Checks if the hashtable contains a certain value *)
let contains ht s =
        let l = Hashtbl.find_all ht (myHash s) in
        let rec helper l = 
                match l with
                |[] -> false
                |a::t -> if (a=s) then true else (helper t);;


(* Adds an element to the hashtable, if it's not inside already *)
let add_element ht s =
        let v = myHash s in
        if (contains ht s) then () else Hashtbl.add ht v s;;


(* Opens file, and read it through, applying function to data *)
let reader filename =
        let ic = open_in filename and line = ref "" in
        try
                while true; do
                        line := input_line ic
                done; 
        with 
        End_of_file -> close_in ic
        |e -> close_in_noerr ic;
                raise e;;
