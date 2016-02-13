open MyHash;;
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

(* At execution : asks which function will be used 
 * Then, returns the function which will be used *)
let get_fct =
    let fct_to_use = ref (-1) and number_of_fct = 2 in
    while ( !fct_to_use < 0 || !fct_to_use >= number_of_fct ); do
        print_string "0 : myHash function \n";
        print_string "1 : xxHash function (size of the hashtable is set to 2^32)\n";
        print_string "Please chose the function you want to use : ";
        fct_to_use := read_int();
    done;
    print_string "\n------------------------------------------\n";
    print_string "------------------------------------------\n";
    print_string "------------------------------------------\n";
    (* DUMMY function serving as placeholder *)
    let dummy_fct i = i+2 in 
    match !fct_to_use with
    |0 -> dummy_fct
    |1 -> dummy_fct
    |_ -> dummy_fct;;

(* -------------------------------
 * Creation of the hashtable
 * And the tools we need to use it
 * ------------------------------*)
let hashtable = Hashtbl.create (int_of_float (2. ** (float get_size)));;
Hashtbl.add hashtable 1 22;;

(* Checks if the hashtable contains a certain key *)
let contains ht k = 
    let list_k = Hashtbl.find_all ht (get_fct k) in
    let rec helper = function
        |[] -> false
        |a::t -> if (a=k) then true else (helper t)
    in helper list_k;;

(* Adds a pair (key,hash(key) to the hashtable, if it's not inside already *)
let add_couple ht k = 
    let v = get_fct k in
    if (contains ht k) then () else Hashtbl.add ht v k;;
