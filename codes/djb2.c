CAMLprim value djb_ocaml(value ml_array){

CAMLparam1( ml_array );
        const char* s = String_val(Field(ml_array,0));
        const int shift = 32 - atoi(String_val(Field(ml_array,1)));
	 return Val_int(hash(s)) >> shift;

}




unsigned long
hash(unsigned char *str)
{
    uint16_t hash = 5381;
    int c;

    while (c = *str++)
        hash = ((hash << 5) + hash) + c; /* hash * 33 + c */

    return hash;
}
