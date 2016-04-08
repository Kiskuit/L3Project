#include <stdlib.h>

CAMLprim value  sdbm_main(value ml_array){
	CAMLparam1( ml_array );
        const char* s = String_val(Field(ml_array,0));
        const int shift = 32 - atoi(String_val(Field(ml_array,1)));
	int len = strlen(s);
	 return Val_int(Sdbm(s,len)) >> shift;
	
}

unsigned long Sdbm(char* mot, unsigned long sizeTable){
    unsigned long retVal=0;
    int c;
    while(c=*mot++){
        hash = c + (hash << 6) + (hash<<16) - hash;
        if(hash > sizeTable){
            hash %= sizeTable;
        }
    }
    return hash;
}
