#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int MyHash(char* mot, int sizeTable){
}

/* This function receives a word *mot* in plain text (char*)
 * It codes every letter capital or not indistinctly onto a 
 * number between 1 and 26.
 * Digits are coded to numbers between 27 and 36 (TODO).
 * Every other caracters are ignored (coded to 0).
 * Transformation is such that in the end, every character
 * of *mot* can be encoded onto 6bits */
void Transform(char* mot){
    while(mot++){
        if( 65<=mot && mot<=90 )
            mot-=65;
        else if (97<=mot && mot<=122)
            mot-=97;
        else
            mot=0;
    }
}

/* This function receives a word *mot* that must already have been
 * transformed. *size* can point to any INT and WILL be modified.
 * Chunks a word into parts of (SIZECHUNK*6) bits long */
unsigned int *Chunks(char* mot, int* size){
    //TODO DEPEND ON PARAM SIZECHUNK INSTEAD OF 3
    char motBis = mot;//copy of the pointer
    int len = 0;
    while (motBis++)//Getting the length of the word
        len++;
    *size = (int) ceil(len/3);
    retVal = malloc(sizeof(unsigned int)*size);
    
    int shift = 0,i = 0;
    while(mot++){//Parcours du mot
        if(shift > 12)
            shift = 0;
        unsigned int tmp = *mot;
        tmp << shift;
        chunk |= tmp;
        i++;
        if(i==3){
            i = 0;
            retVal[0] = chunk;
            chunk = 0;
            retVal++;
        }
        shift += 6
    }
}

int Hash(int* chunks, int size){
    int hash = 0;
    for(int i=0; i<size; i++){
        hash ^= chunks[i];
    }
    return hash;
}
