#include <iostream>
#include "toylib.h"
#define SIZE 100
int main()
{
	printf("*******Testing Print String Upper*******\n");
	printf("Enter a string of length atmost 100 : ");
	char str[SIZE];
	scanf("%[^\n]s", str);
	printf("Output after Conversion : ");
	fflush(stdout);
	int ret = printStringUpper(str);
	printf("\n");
	printf("Printed %d characters\n\n", ret);

	printf("*******Testing Print Hex Integer*******\n");
	printf("Enter an Integer : ");
	int n;
	scanf("%d", &n);
	printf("Output after conversion to Hex : ");
	fflush(stdout);
	ret = printHexInteger(n);
	if(ret==-1)
		printf("Some error Occurred!!!\n");//Failure
	else
		printf("Printed %d characters\n", ret);//Success
	printf("\n");

	printf("*******Testing Print Float*******\n");
	printf("Enter a floating point number : ");
	float f;
	scanf("%f", &f);
	printf("Output usinf printFloat: ");
	fflush(stdout);
	ret = printFloat(f);
	if(ret==-1)
		printf("Some Error Occurred!!!|n");//Failure
	else
		printf("Printed %d characters\n", ret);//Success
	printf("\n");

	printf("*******Testing Read Hex Integer*******\n");
	printf("Enter a hexadecimal integer in  %%x format(letters to be input as lowercase english alphabets): ");
	fflush(stdout);
	ret = readHexInteger(&n);
	if(ret==-1)
		printf("Some Error Occurred!!\n\n");//Failure
	else
		printf("The number you entered is : %d\n\n", n);//Success

	printf("*******Testing Read Float*******\n");
	printf("Enter a floating point number : ");
	fflush(stdout);
	ret = readFloat(&f);
	if(ret==-1)
		printf("Some Error Occurred!!!\n\n");//Failure
	else
		printf("The number you entered is : %0.4f\n", f);//Success
}