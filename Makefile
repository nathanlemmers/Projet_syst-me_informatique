
all: run

build : 
	gcc -c -Wall -g Table_symboles/ts.c

all_lex: lex

lex.tab.c lex.tab.h: Lex_et_Yacc/lex.y
	bison -t -v -d Lex_et_Yacc/lex.y 

lex.yy.c: Lex_et_Yacc/lex.l lex.tab.h
	flex Lex_et_Yacc/lex.l

lex: build lex.yy.c lex.tab.c lex.tab.h
	gcc -o lex lex.tab.c lex.yy.c ts.o

clean:
	rm lex lex.tab.c lex.yy.c lex.tab.h lex.output

test: all_lex
	cat samples/ok05.c | ./lex