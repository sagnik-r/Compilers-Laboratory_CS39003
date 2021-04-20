output.txt: a.out ass3_18CS10063_test.c
	./a.out < ass3_18CS10063_test.c > output.txt

a.out:	lex.yy.c
		cc lex.yy.c -lfl

lex.yy.c: ass3_18CS10063.l 
		flex ass3_18CS10063.l ass3_18CS10063.c



clean:
		rm a.out lex.yy.c
