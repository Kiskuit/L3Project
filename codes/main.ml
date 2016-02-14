open MyHash
open Printf

let hashTable = Hashtbl.create 65536;;


(* Checks if the hashtable contains a certain value *)
let contains ht s =
        let k = Hashtbl.find_all ht (myHash s) in
        let rec helper l = 
                match l with
                |[] -> false
                |a::t -> if (a=s) then true else (helper t)
        in helper k;;


(* Adds an element to the hashtable, if it's not inside already *)
let add_element ht s =
        let v = myHash s in
        if (contains ht s) then () else Hashtbl.add ht v s;;

(* Transforms a line into a list of words *)
let line_to_words l = 
    let rec helper k w =
        if (String.contains k ' ')
        then let i = (String.length k) and j = (String.index_from k 0 ' ') in
        helper (String.sub k (j+1) (i-j-1)) ((String.sub k 0 j)::w)
        else (k::w)
    in helper l [];;


(* Opens file, and read it through, applying function to data *)
let reader filename =
        let ic = open_in filename and line = ref "" in
        let rec helper = function
                        |[] -> ()
                        |h::t -> add_element hashTable h;
                        helper t in
        try
            while true; do
                line := input_line ic;
                helper (line_to_words !line);
            done; 
        with 
        End_of_file -> close_in ic
        |e -> close_in_noerr ic;
                raise e;;


reader "../../texts/bible_en.txt"
