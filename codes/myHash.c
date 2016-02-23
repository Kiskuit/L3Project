#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int MyHash(char* mot, int sizeTable){
}

void Transform(char* mot){
    //TODO TAKE INTO ACCOUNT 0-9
    while(mot++){
        if( 65<=mot && mot<=90 )
            mot-=65;
        else if (97<=mot && mot<=122)
            mot-=97;
        else
            mot=0;
    }
}

void Chunks(char* mot, int* retour, int* size){
    //TODO DEPEND ON PARAM SIZECHUNK INSTEAD OF 3
    char motBis = mot;//copy of the pointer
    int len = 0;
    while (motBis++)//Getting the length of the word
        len++;
    *size = (int) ceil(len/3);
    retour = malloc(sizeof(int)*size);
    
    int shift = 0,i = 0;
    while(mot++){//Parcours du mot
        if(shift > 12)
            shift = 0;
        int tmp = *mot;
        tmp << shift;
        chunk |= tmp;
        i++;
        if(i==3){
            i = 0;
            retour[0] = chunk;
            chunk = 0;
            retour++;
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
