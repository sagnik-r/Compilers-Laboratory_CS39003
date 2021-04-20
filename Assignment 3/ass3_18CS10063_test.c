/*This test file is written by:
Name: Sagnik Roy
Roll No: 18CS10063*/
#include <stdio.h>
#define X 3
typedef struct{
	int x;
} New;
union Data{
	int p;
	char str[20];
};
int main()
{
	static int a = 24059;
	switch(a){
		case 1: a++;
				break;
		default: break;
	}
	long long int d = 000;
	short p = 32;
	char myChar_123 = 'G';
	float f = 25.364;
	double d = 256.32E-2;
	int i = 35;
	do{
		i++;
	}while(i<40);
	//"This is a test file Checking comments"
	d = d + 2.0;
	a = a*2;
	a = a<<1;
	a = a>>1;
	i = sizeof(int);
	if(i>=1) printf("Hello World");
	else i &= 7;
	char s[] = "Sagnik\nRoy";
	i+=10;
	i-=25;
	union Data data;
	data.p = 32;
	return 0;
}