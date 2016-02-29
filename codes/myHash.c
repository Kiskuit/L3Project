#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
//#include "myHash.h"

#define MYHASHTHETA 0.6180339887
static unsigned int XorChunks(unsigned int *chunks, int size){
    int retVal = 0;
    int i = 0;
    for(i=0; i<size; i++){
        retVal ^= chunks[i];
    }
    return retVal;
}
static unsigned int HashMult(unsigned int e, unsigned int sizeTable){
    double theta = MYHASHTHETA, retVal;
    double dummy;
    retVal = modf(e * theta, &dummy);
    retVal *= sizeTable;
    return (int) retVal;
}
static unsigned int *Chunks(char* mot, int* size){
    //TODO DEPEND ON PARAM SIZECHUNK INSTEAD OF 3
    char *motBis = mot;//copy of the pointer
    //Getting the length of the word
    int len = 0;
    while (*motBis++)
        len++;
    //Computing the size of the returned array
    // + dynamically allocating it
    *size = (int) ceil(len/3.);
    unsigned int *retVal = malloc(sizeof(unsigned int) * *size);
    
    int shift = 12, i = 0, chunk = 0;
    int j=0;
    unsigned int tmp;
    while((tmp = *mot++)){//Parcours du mot
        if(shift < 0)
            shift = 12;
        tmp <<= shift;
        chunk |= tmp;
        i++;
        if(i==3){
            i = 0;
            retVal[j] = chunk;
            j++;
            chunk = 0;
        }
        shift -= 6;
    }
    if(i!=0)
        retVal[j] = chunk;
    return retVal;
}
static void Transform(char* mot){
    while(*mot){
        if( 65<=*mot && *mot<=90 )
            *mot-=54;//Mapped to 11-36
        else if (97<=*mot && *mot<=122)
            *mot-=86;//Mapped to 11-36
        else if (48<=*mot && *mot<=57)
            *mot-=47;//Mapped to 1-10
        else
            *mot=0;
        *mot++;
    }
}

/*int MyHash(char* mot, int sizeTable){
}*/
CAMLprim value MyHash(value ml_array){
    CAMLparam1( ml_array );
    const char** argv = ml_array;
    int argc = Wosize_val(ml_array);
    
    if(argc != 2)
        return Val_int(0);
    //Recup param
    const char* sizePowString = String_val(Field(ml_array,0));
    const char* motOriginal = String_val(Field(ml_array,1));
    //Process params
    char* mot = malloc(sizeof(char)*(strlen(motOriginal)+1));
    strcpy(mot,motOriginal);
    const int sizePow = atoi(sizePowString);
    const int real_size = (int) pow(2.,(double)sizePow);
    //Hashing
    Transform(mot);
    int sizeChunks = -1;
    unsigned int *chunks = Chunks(mot, &sizeChunks);
    int hash = HashMult(XorChunks(chunks,sizeChunks),real_size);
    return Val_int(hash);
}




/*int main(int argc, char** argv){
    char test1[5];
    char test2[6];
    scanf("%s",test1);
    scanf("%s",test2);
    Transform(test1);
    printf("(%d)(%d)(%d)(%d)\n",test1[0],test1[1],test1[2],test1[3]);
    Transform(test2);
    printf("(%d)(%d)(%d)(%d)(%d)\n",test2[0],test2[1],test2[2],test2[3],test2[4]);
    int size1  = -1, size2 = -1;
    unsigned int *c1 = Chunks(test1, &size1);
    unsigned int *c2 = Chunks(test2, &size2);
    printf("1 : %u\n",XorChunks(c1,size1));
    printf("2 : %u\n",XorChunks(c2,size2));
    printf("1 : %u\n",HashMult(XorChunks(c1,size1),256));
    printf("2 : %u\n",HashMult(XorChunks(c2,size2),256));
    return 0;
}*/

/* This function receives a word *mot* in plain text (char*)
 * It codes every letter capital or not indistinctly onto a 
 * number between 1 and 26.
 * Digits are coded to numbers between 27 and 36.
 * Every other caracters are ignored (coded to 0).
 * Transformation is such that in the end, every character
 * of *mot* can be encoded onto 6bits */

/* This function receives a word *mot* that must already have been
 * transformed. *size* can point to any INT and WILL be modified.
 * Chunks a word into parts of (SIZECHUNK*6) bits long */

/* Applies XOR binary function reccursively to every chunks
 * between themselves, and return the final result as an int */

