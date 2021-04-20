a.out:		main.o		libtoylib.a
			c++ main.o -L. -ltoylib
			
main.o:	main.cpp	toylib.h
			c++ -Wall -c main.cpp
			
libtoylib.a:	toylib.o
			ar -rcs libtoylib.a	ass2_18CS10063.o
			
toylib.o:	ass2_18CS10063.cpp	toylib.h
			c++ -Wall -c ass2_18CS10063.cpp
			
clean:
			rm main.o	libtoylib.o	toylib.o 
