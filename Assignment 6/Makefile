tinyc: y.tab.o lex.yy.o ass6_18CS10011_18CS10063_translator.o ass6_18CS10011_18CS10063_target_translator.o 
	@g++ -g ass6_18CS10011_18CS10063_translator.o ass6_18CS10011_18CS10063_target_translator.o lex.yy.o y.tab.o -lfl -o tinyc
	@echo "type 'make run' to execute all the test files at once"
lex.yy.c: ass6_18CS10011_18CS10063.l
	@flex ass6_18CS10011_18CS10063.l
y.tab.c: ass6_18CS10011_18CS10063.y
	@yacc -Wno -dtv ass6_18CS10011_18CS10063.y
ass6_18CS10011_18CS10063_target_translator.o: ass6_18CS10011_18CS10063_target_translator.cxx
	@g++ -g -c ass6_18CS10011_18CS10063_target_translator.cxx
ass6_18CS10011_18CS10063_translator.o: ass6_18CS10011_18CS10063_translator.cxx
	@g++ -w -g -c ass6_18CS10011_18CS10063_translator.cxx
lex.yy.o: lex.yy.c
	@g++ -g -c lex.yy.c
y.tab.o:    y.tab.c
	@g++ -g -DYYDEBUG -c y.tab.c
libass2_18CS10011_18CS10063.a: ass2_18CS10011_18CS10063.o
	@ar -rcs libass2_18CS10011_18CS10063.a ass2_18CS10011_18CS10063.o

ass2_18CS10011_18CS10063.o: ass2_18CS10011_18CS10063.c myl.h
	@gcc -Wall  -c ass2_18CS10011_18CS10063.c
clean:
	@rm ass6_18CS10011_18CS10063_test1.s ass6_18CS10011_18CS10063_test2.s ass6_18CS10011_18CS10063_test3.s ass6_18CS10011_18CS10063_test4.s ass6_18CS10011_18CS10063_test5.s test1 test2 test3 test4 test5 lex.yy.c y.tab.h y.output y.tab.c lex.yy.o y.tab.o ass6_18CS10011_18CS10063_translator.o ass6_18CS10011_18CS10063_target_translator.o ass6_18CS10011_18CS10063_test1.o ass6_18CS10011_18CS10063_test2.o ass6_18CS10011_18CS10063_test3.o ass6_18CS10011_18CS10063_test4.o ass6_18CS10011_18CS10063_test5.o libass2_18CS10011_18CS10063.a ass2_18CS10011_18CS10063.o tinyc


test1: ass6_18CS10011_18CS10063_test1.o libass2_18CS10011_18CS10063.a
	@gcc -no-pie -g ass6_18CS10011_18CS10063_test1.o -o test1 -L. -lass2_18CS10011_18CS10063
ass6_18CS10011_18CS10063_test1.o: ass6_18CS10011_18CS10063_test1.s myl.h
	@gcc -g -Wall  -c ass6_18CS10011_18CS10063_test1.s -o ass6_18CS10011_18CS10063_test1.o

test2: ass6_18CS10011_18CS10063_test2.o libass2_18CS10011_18CS10063.a
	@gcc -no-pie -g  ass6_18CS10011_18CS10063_test2.o -o test2 -L. -lass2_18CS10011_18CS10063
ass6_18CS10011_18CS10063_test2.o: ass6_18CS10011_18CS10063_test2.s myl.h
	@gcc -g -Wall -c ass6_18CS10011_18CS10063_test2.s

test3: ass6_18CS10011_18CS10063_test3.o libass2_18CS10011_18CS10063.a
	@gcc -no-pie -g  ass6_18CS10011_18CS10063_test3.o -o test3 -L. -lass2_18CS10011_18CS10063
ass6_18CS10011_18CS10063_test3.o: ass6_18CS10011_18CS10063_test3.s myl.h
	@gcc -g -Wall  -c ass6_18CS10011_18CS10063_test3.s

test4: ass6_18CS10011_18CS10063_test4.o libass2_18CS10011_18CS10063.a
	@gcc -no-pie -g  ass6_18CS10011_18CS10063_test4.o -o test4 -L. -lass2_18CS10011_18CS10063
ass6_18CS10011_18CS10063_test4.o: ass6_18CS10011_18CS10063_test4.s myl.h
	@gcc -g -Wall  -c ass6_18CS10011_18CS10063_test4.s

test5: ass6_18CS10011_18CS10063_test5.o libass2_18CS10011_18CS10063.a
	@gcc -no-pie -g  ass6_18CS10011_18CS10063_test5.o -o test5 -L. -lass2_18CS10011_18CS10063
ass6_18CS10011_18CS10063_test5.o: ass6_18CS10011_18CS10063_test5.s myl.h
	@gcc -g -Wall -c ass6_18CS10011_18CS10063_test5.s

#output: output.o
output: output.o libass2_18CS10011_18CS10063.a
	@gcc -no-pie -g  output.o -o output -L. -lass2_18CS10011_18CS10063
output.o: output.s myl.h
	@gcc -g -Wall -c output.s

run: 
		
	@./tinyc < ass6_18CS10011_18CS10063_test1.c > ass6_18CS10011_18CS10063_quad1.out
	
	@mv output.s ass6_18CS10011_18CS10063_test1.s
	
	@./tinyc < ass6_18CS10011_18CS10063_test1.c > ass6_18CS10011_18CS10063_quad1.out
	
	@mv output.s ass6_18CS10011_18CS10063_test1.asm

	@make test1
	
	@./tinyc < ass6_18CS10011_18CS10063_test2.c > ass6_18CS10011_18CS10063_quad2.out

	@mv output.s ass6_18CS10011_18CS10063_test2.s
	
	@./tinyc < ass6_18CS10011_18CS10063_test2.c > ass6_18CS10011_18CS10063_quad2.out

	@mv output.s ass6_18CS10011_18CS10063_test2.asm	

	@make test2

	@./tinyc < ass6_18CS10011_18CS10063_test3.c > ass6_18CS10011_18CS10063_quad3.out

	@mv output.s ass6_18CS10011_18CS10063_test3.s
	
	@./tinyc < ass6_18CS10011_18CS10063_test3.c > ass6_18CS10011_18CS10063_quad3.out

	@mv output.s ass6_18CS10011_18CS10063_test3.asm

	@make test3

	@./tinyc < ass6_18CS10011_18CS10063_test4.c > ass6_18CS10011_18CS10063_quad4.out
	
	@mv output.s ass6_18CS10011_18CS10063_test4.s
	
	@./tinyc < ass6_18CS10011_18CS10063_test4.c > ass6_18CS10011_18CS10063_quad4.out
	
	@mv output.s ass6_18CS10011_18CS10063_test4.asm

	@make test4

	@./tinyc < ass6_18CS10011_18CS10063_test5.c > ass6_18CS10011_18CS10063_quad5.out
	
	@mv output.s ass6_18CS10011_18CS10063_test5.s
	
	@./tinyc < ass6_18CS10011_18CS10063_test5.c > ass6_18CS10011_18CS10063_quad5.out
	
	@mv output.s ass6_18CS10011_18CS10063_test5.asm

	@make test5
	@echo ""
	@echo "Commands for Test Cases"
	@echo "Test Case 1    Command : ./test1"
	@echo "Test Case 2    Command : ./test2"
	@echo "Test Case 3    Command : ./test3"
	@echo "Test Case 4    Command : ./test4"
	@echo "Test Case 5    Command : ./test5"
