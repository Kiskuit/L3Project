CFLAGS= -g -Wall -std=c99 -Wunused-value
EXEC=myHashC

all: $(EXEC)

myHashC: myHashC.o
	gcc -o $@ $^ -lm

myHashC.o: myHash.c
	gcc -o $@ -c $< $(CFLAGS)

clean:
	rm -rf *.o *~
