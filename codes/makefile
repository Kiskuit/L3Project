CAMLC=ocamlc
GCC=gcc
CFLAGS= -c -I 
MLFLAGS= -custom -o
LIBC= /usr/local/lib/ocaml

EXEC=hash.out

all: $(EXEC)

hash.out: murmurhash.o myHash.o xxhash.o xxhsum.o myHash.ml ocaml_murmurhash.ml ocaml_xxhash.ml topLevelFct.ml topLevel.ml
	$(CAMLC) $^ $(MLFLAGS) $(EXEC)

murmurhash.o: murmurhash.c
	$(GCC) $(CFLAGS) $(LIBC) $<

myHash.o: myHash.c
	$(GCC) $(CFLAGS) $(LIBC) $<

xxhash.o: xxhash.c
	$(GCC) $(CFLAGS) $(LIBC) $<

xxhsum.o: xxhsum.c
	$(GCC) $(CFLAGS) $(LIBC) $<

clean:
	rm -rf *.o *.cmi *.cmo
