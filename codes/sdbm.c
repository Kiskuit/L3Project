#include <stdlib.h>

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
