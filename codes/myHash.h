#include <stdlib.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>

#ifndef MYHASH
#define MYHASH

#define MYHASHTHETA 0.6180339887

void Transform(char* mot);
unsigned int *Chunks(char* mot, int* size);
unsigned int XorChunks(unsigned int *chunks, int size);
unsigned int HashMult(unsigned int e, unsigned int sizeTable);

#endif
