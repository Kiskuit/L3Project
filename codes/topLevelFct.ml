(* -------------------------------
 * Recuperation of parameters
 * ------------------------------*)
(* At execution : asks user what is the document that should be read
 * Then, returns the string read *)
let get_filename =
    print_string "Please give the path to the file you want to hash : ";
    let filename = read_line () in
    print_string "\n------------------------------------------\n";
    print_string "------------------------------------------\n";
    filename;;

(* At execution : asks which function will be used 
 * Then, returns the function which will be used *)
let get_fct =
    let fct_to_use = ref (-1) and number_of_fct = 3 in
    while ( !fct_to_use < 0 || !fct_to_use >= number_of_fct ); do
        print_string "0 : myHash function \n";
        print_string "1 : xxHash function (currently unavailable) \n";
        print_string "2 : murmurhash function \n";
        print_string "Please chose the function you want to use : ";
        fct_to_use := read_int();
    done;
    print_string "\n------------------------------------------\n";
    print_string "------------------------------------------\n";
    print_string "------------------------------------------\n";
    (* DUMMY function serving as placeholder *)
    let dummy_fct m s = match(m,s) with |("dummy",0) -> 1 |_ -> 1 in
    match !fct_to_use with
    (*|0 -> myHash*)
    |0 -> MyHash.myhash
    |1 -> Ocaml_xxhash.xxhash
    |2 -> Ocaml_murmurhash.murmurhash
    |_ -> dummy_fct;;

(* At execution : asks user what is the size of the hashTable
 * we should use, in power of 2
 * Then, returns the actual size of the table *)
let get_size = 
    let size_of_hashtable = ref 0 in
    let ok_values = [8;16;30] in
    while ( not (List.mem !size_of_hashtable ok_values) ); do
        print_string "Please give the size of the hashTable in power of 2 (8,16,30) : 2^";
        size_of_hashtable := read_int ();
    done;
    print_string "\n------------------------------------------\n";
    print_string "------------------------------------------\n";
    !size_of_hashtable;;

let get_real_size () = 
    int_of_float(2. ** (float get_size));;
(* -------------------------------
 * Creation of the hashtable
 * And the tools we need to use it
 * ------------------------------*)
let hashtable = Hashtbl.create (get_real_size ());;
Hashtbl.add hashtable 0 "test";;
Hashtbl.remove hashtable 0;;

(* Checks if the hashtable contains a certain key *)
let contains ht k = 
    let list_k = Hashtbl.find_all ht (get_fct k get_size) in
    let rec helper = function
        |[] -> false
        |a::t -> if (a=k) then true else (helper t)
    in helper list_k;;

(* Adds a pair (key,hash(key) to the hashtable, if it's not inside already *)
let add_couple ht k = 
    let v = (get_fct k get_size) in
    if (contains ht k) then () else Hashtbl.add ht v k;;

let output_hashtable ht =
    let oc = open_out "output.out" and i = ref 0 in
    while (!i<(get_real_size ())); do
        let size_list = List.length (Hashtbl.find_all hashtable !i) in
        Printf.fprintf oc "%d\t%d\n" !i size_list;
        i:=!i+1;
    done;
    close_out oc;;

(* -------------------------------------------
 * Transforms a line into a list of words
------------------------------------------- *)
let line_to_words line =
    let rec helper l w =
        if (String.contains l ' ')
        then let i = (String.length l) and j = (String.index_from l 0 ' ') in
        helper (String.sub l (j+1) (i-j-1)) ((String.sub l 0 j)::w)
        else (l::w)
    in helper line [];;

(*---------------------------------------------------
 * Opens input file, reads through it
 * hashes every word, and stores it into the table
---------------------------------------------------*)
let hash_file filename = 
    (*Opens an input channel, and init. a reference to store the line*)
    let ic = open_in filename and line = ref "" in
    (*Recursively add every element of the list to hashtable*)
    let rec helper = function
        |[] -> ()
        |h::t -> add_couple hashtable h;
                helper t in
    try 
        (*Goes through every line until EOL*)
        while true; do
            line := input_line ic;
            helper (line_to_words !line);
        done;
    (*If EOL, just close file,
     * else, close file with error and raise it*)
    with
    |End_of_file -> close_in ic
    |e -> close_in_noerr ic;
            raise e;;

