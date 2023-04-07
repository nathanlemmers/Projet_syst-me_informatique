
all: ts

build : 
	gcc -c -Wall -g Table_symboles/ts.c
	gcc -c -Wall -g Table_symboles/test.c
	gcc -Wall -g -o test ts.o test.o

run : 
	./test