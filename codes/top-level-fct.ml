(* PARAMETERS THAT WILL BE SET *)
let filename = ref "";;
let size_of_hashtable = ref 0;;
let fct_to_use = ref (-1);;
let number_of_fct = 2;;



(* Asks user what is the document that should be read *)
let get_filename =
    print_string "Please give the path to the file you want to hash : ";
    filename := read_line ();
    print_string "\n------------------------------------------\n";
    print_string "------------------------------------------\n";;

(* Asks user what will bethe size of the hashtable *)
let get_size = 
    while ( not (!size_of_hashtable = 16 || !size_of_hashtable = 32) ); do
        print_string "Please give the size of the hashTable in power of 2 (16 or 32) : 2^";
        size_of_hashtable := read_int ();
    done;
    print_string "\n------------------------------------------\n";
    print_string "------------------------------------------\n";;

(* TODO
 * DUMMY function serving as placeholder *)
let dummy_fct = ();;
(* Asks which function will be used *)
let get_fct =
    while ( !fct_to_use < 0 || !fct_to_use >= number_of_fct ); do
        print_string "0 : myHash function \n";
        print_string "1 : xxHash function (size of the hashtable is set to 2^32)\n";
        print_string "Please chose the function you want to use : ";
        fct_to_use := read_int();
    done;
    print_string "\n------------------------------------------\n";
    print_string "------------------------------------------\n";
    print_string "------------------------------------------\n";
    match !fct_to_use with
    |0 -> dummy_fct
    |1 -> dummy_fct
    |_ -> dummy_fct;;

get_filename;;
get_size;;
number_of_fct;;
