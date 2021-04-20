all: a.out
	
	./a.out < ass5_18CS10011_18CS10063_test1.c > ass5_18CS10011_18CS10063_quads1.out
	@echo "Test File 1 Successfully Translated !\n"
	./a.out < ass5_18CS10011_18CS10063_test2.c > ass5_18CS10011_18CS10063_quads2.out
	@echo "Test File 2 Successfully Translated !\n"
	./a.out < ass5_18CS10011_18CS10063_test3.c > ass5_18CS10011_18CS10063_quads3.out
	@echo "Test File 3 Successfully Translated !\n"
	./a.out < ass5_18CS10011_18CS10063_test4.c > ass5_18CS10011_18CS10063_quads4.out
	@echo "Test File 4 Successfully Translated !\n"
	./a.out < ass5_18CS10011_18CS10063_test5.c > ass5_18CS10011_18CS10063_quads5.out
	@echo "Test File 5 Successfully Translated !\n"
	./a.out < ass5_18CS10011_18CS10063_test6.c > ass5_18CS10011_18CS10063_quads6.out
	@echo "Test File 6 Successfully Translated !\n"
	./a.out < ass5_18CS10011_18CS10063_test7.c > ass5_18CS10011_18CS10063_quads7.out
	@echo "Test File 7 Successfully Translated !\n"
	./a.out < ass5_18CS10011_18CS10063_test8.c > ass5_18CS10011_18CS10063_quads8.out
	@echo "Test File 8 Successfully Translated !\n"

	@echo "\nAll Test Case Successfully Translated !!\n"

a.out: lex.yy.o y.tab.o ass5_18CS10011_18CS10063_translator.o
	g++ lex.yy.o y.tab.o ass5_18CS10011_18CS10063_translator.o -lfl

ass5_18CS10011_18CS10063_translator.o: ass5_18CS10011_18CS10063_translator.cxx ass5_18CS10011_18CS10063_translator.h
	g++ -c ass5_18CS10011_18CS10063_translator.h
	g++ -w -c ass5_18CS10011_18CS10063_translator.cxx

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

y.tab.o: y.tab.c
	g++ -c y.tab.c

lex.yy.c: ass5_18CS10011_18CS10063.l y.tab.h ass5_18CS10011_18CS10063_translator.h
	flex ass5_18CS10011_18CS10063.l

y.tab.c: ass5_18CS10011_18CS10063.y
	yacc -Wno -dtv ass5_18CS10011_18CS10063.y 

y.tab.h: ass5_18CS10011_18CS10063.y
	yacc -Wno -dtv ass5_18CS10011_18CS10063.y 

clean:
	rm lex.yy.c y.tab.c y.tab.h lex.yy.o y.tab.o ass5_18CS10011_18CS10063_translator.o y.output a.out ass5_18CS10011_18CS10063_translator.h.gch
