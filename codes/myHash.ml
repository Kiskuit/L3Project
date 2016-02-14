(*------------------------------------------------
 * PARAMETERS OF THE PROGRAM
 * -----------------------------------------------
 *)
(* At execution : asks user what will bethe size of the hashtable 
 * Then, returns this value *)
let get_size = 
    let size_of_hashtable = ref 0 in
    while ( not (!size_of_hashtable = 16 || !size_of_hashtable = 32) ); do
        print_string "Please give the size of the hashTable in power of 2 (16 or 32) : 2^";
        size_of_hashtable := read_int ();
    done;
    print_string "\n------------------------------------------\n";
    print_string "------------------------------------------\n";
    !size_of_hashtable;;
let get_real_size () = 
    int_of_float(2. ** (float get_size));;
let size_of_table = get_size

let theta = 0.6180339887










(* Transforms a string into a list of char*)
let explode s =
  let rec exp i l =
    if i < 0 then l else exp (i - 1) (s.[i] :: l) in
  exp (String.length s - 1) [];;


(* Transforms a char into an integer
 * If it's a letter, the value is its place in the alphabet
 * 0 otherwise *)
let int_to_char c =
        let val_ascii = (Char.code c) in
        match val_ascii with
        | x when (x >= 65 && x <= 90) -> (x - 64)
        | x when (x >= 97 && x <= 122) -> (x - 96)
        | _ -> 0;;


(* Transforms a decimal integer into an array of bool
 * representing its binary *)
let dec_to_binList x =
        let rec helper y lst = 
                match y with
                | 0 -> let resizeList lst_bis = 
                        match lst_bis with
                        | [] -> false::false::false::false::false::[]
                        | _::[] -> false::false::false::false::lst_bis
                        | _::_::[] -> false::false::false::lst_bis
                        | _::_::_::[] -> false::false::lst_bis
                        | _::_::_::_::[] -> false::lst_bis
                        | _ -> lst_bis in
                resizeList lst
                | _ -> helper (y/2) ( (1 =(y mod 2))::lst) in
        helper x [];;


(* Resize a list to a size which is a multiple of SIZE_OF_TABLE*)
let resize_list_16 lst =
        let false_list = Array.to_list (Array.make (size_of_table - ((List.length lst) mod size_of_table)) false) in
        List.append false_list lst;;


(* Chunks a list into list of length size_of_table *)
let chunk_16 lst = 
        let rec cut l c =
                match l with
                |[] -> let t = Array.of_list c in
                Array.to_list (Array.sub t 1 (Array.length t -1))
                |_::_ -> let t = (Array.of_list l) and atl = Array.to_list in
                cut (atl (Array.sub t size_of_table (Array.length t -size_of_table)))
                (List.append c ((atl (Array.sub t 0 size_of_table))::[])) in
        cut (resize_list_16 lst) [[]];;


(* Folds XOR to a list of list*)
let fold_xor lst =
        let xor = function
                |(a,b) when (a=b) -> false
                |_ -> true in
        let rxor l1 l2 =
                let rec helper l1 l2 result =
                        match l1 with
                        |[] -> List.rev result
                        |a::_ -> let h1 = (List.hd l1) and h2 = (List.hd l2)
                                and t1 = (List.tl l1) and t2 = (List.tl l2) in
                        helper t1 t2 ((xor (h1,h2))::result) in
                helper l1 l2 [] in
        List.fold_left rxor (resize_list_16 (false::[])) lst;;


(* Transforms an array of bool into a float
 * where the array represents the binary *)
let binList_to_dec lst =
        let rec helper l x n =
                match l with
                |[] -> x
                |true::t -> helper t (2.**n +. x) (n+. 1.)
                |false::t -> helper t x (n+. 1.)
        in helper (List.rev lst) 0. 0.;;


(* Last step of the calculation of the hash value
 * multiplication by theta (theoeretical calculations give best value)
 * and re-scaled to the size of the hashtable *)
let multiply e = int_of_float ( (e*.theta -. floor(e*.theta)) *. 2.**(float)size_of_table);;


(* HASH FUNCTION *)
let myHash str = 
        let value_string s =
                let rec helper l n =
                        match l with
                        |[] -> n
                        |h::t -> helper t (n+ (int_to_char h))
                in helper (explode s) 0
        in multiply (binList_to_dec (fold_xor (chunk_16 (dec_to_binList (value_string str)))));;
