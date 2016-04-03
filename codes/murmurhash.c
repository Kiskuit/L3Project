
/**
 * `murmurhash.h' - murmurhash
 *
 * copyright (c) 2014 joseph werle <joseph.werle@gmail.com>
 */

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "murmurhash.h"
#include <caml/mlvalues.h> /*val*/
#include <caml/alloc.h>
#include <caml/memory.h>

/*CAMLprim value murmurhash_main(value ml_array){

CAMLparam1( ml_array );
  int readsize;
    FILE* inFile;
    FILE* outFile;
    char* fileName = malloc(sizeof( String_val(Field(ml_array,1))));
    size_t const buffSize = 64;
    char* buffer = malloc(buffSize);
    fileName = String_val(Field(ml_array,1));
	
   inFile = fopen( fileName, "r" );
   outFile = fopen( "Result.txt", "w");
	readsize = fscanf(inFile,"%s",buffer);

  while(readsize != EOF){
		fprintf(outFile,"%x ",murmurhash(buffer,strlen(buffer),10));
		readsize = fscanf(inFile,"%s",buffer);
	}
return Val_int(0);
}*/

#define MASK 0

CAMLprim value murmurhash_mask(value v){
	
	char* s = String_val(v);
	int len = strlen(s);
        switch(MASK){
            case 0 :
                return Val_int(murmurhash(s,len,0)>>24);
                //mask : 11111111000000000000000000000000
            case 1:
                return Val_int((murmurhash(s,len,0) >> 16) & 255);
                //mask : 111111110000000000000000
            case 2:
                return Val_int((murmurhash(s,len,0) >> 8) & 255);
                //mask : 1111111100000000
            case 3 :
                return Val_int(murmurhash(s,len,0) & 255);
                //mask : 11111111
            case 4 :
                return Val_int((murmurhash(s,len,0) >> 22) & 255);
                //mask : 111111110000000000000000000000
            case 5 :
                return Val_int((murmurhash(s,len,0) >> 20) & 255);
                //mask : 1111111100000000000000000000
            case 6 :
                return Val_int((murmurhash(s,len,0) >> 18) & 255);
                //mask : 11111111000000000000000000
            case 7 :
                return Val_int((murmurhash(s,len,0) >> 14) & 255);
                //mask : 1111111100000000000000
            case 8 :
                return Val_int((murmurhash(s,len,0) >> 12) & 255);
                //mask : 11111111000000000000
            default :
                return Val_int((murmurhash(s,len,0) >> 10) & 255);
                //mask : 111111110000000000
        }
                
	return Val_int(murmurhash(s,len,0)>>24);
	
}

uint32_t
murmurhash (const char *key, uint32_t len, uint32_t seed) {
  uint32_t c1 = 0xcc9e2d51;
  uint32_t c2 = 0x1b873593;
  uint32_t r1 = 15;
  uint32_t r2 = 13;
  uint32_t m = 5;
  uint32_t n = 0xe6546b64;
  uint32_t h = 0;
  uint32_t k = 0;
  uint8_t *d = (uint8_t *) key; // 32 bit extract from `key'
  const uint32_t *chunks = NULL;
  const uint8_t *tail = NULL; // tail - last 8 bytes
  int i = 0;
  int l = len / 4; // chunk length

  h = seed;

  chunks = (const uint32_t *) (d + l * 4); // body
  tail = (const uint8_t *) (d + l * 4); // last 8 byte chunk of `key'

  // for each 4 byte chunk of `key'
  for (i = -l; i != 0; ++i) {
    // next 4 byte chunk of `key'
    k = chunks[i];

    // encode next 4 byte chunk of `key'
    k *= c1;
    k = (k << r1) | (k >> (32 - r1));
    k *= c2;

    // append to hash
    h ^= k;
    h = (h << r2) | (h >> (32 - r2));
    h = h * m + n;
  }

  k = 0;

  // remainder
  switch (len & 3) { // `len % 4'
    case 3: k ^= (tail[2] << 16);
    case 2: k ^= (tail[1] << 8);

    case 1:
      k ^= tail[0];
      k *= c1;
      k = (k << r1) | (k >> (32 - r1));
      k *= c2;
      h ^= k;
  }

  h ^= len;

  h ^= (h >> 16);
  h *= 0x85ebca6b;
  h ^= (h >> 13);
  h *= 0xc2b2ae35;
  h ^= (h >> 16);
 
  return h;
}
