output.txt : a.out
		./a.out < asgn4_18CS10063_test.c > output.txt

a.out : lex.yy.o y.tab.o asgn4_18CS10063.o
		gcc lex.yy.o y.tab.o asgn4_18CS10063.o -lfl
		
lex.yy.c : asgn4_18CS10063.l y.tab.h
		flex asgn4_18CS10063.l
		
y.tab.c : asgn4_18CS10063.y
		bison -dty asgn4_18CS10063.y --report=solved 
		
asgn4_18CS10063.o : asgn4_18CS10063.c
		gcc -c asgn4_18CS10063.c
		
y.tab.h : asgn4_18CS10063.y
		bison -dty asgn4_18CS10063.y --report=solved   
		
lex.yy.o : lex.yy.c
	gcc -c lex.yy.c
	
y.tab.o : y.tab.c
		gcc -c y.tab.c
		
clean : 
	rm lex.yy.c y.tab.c lex.yy.o y.tab.o asgn4_18CS10063.o y.output a.out output.txt
