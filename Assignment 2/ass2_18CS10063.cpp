#include "toylib.h"

int printStringUpper (char *str)
{
	int bytes = 0;//Variable will store length of string

	for(int i = 0; str[i]!='\0'; i++)//Loop runs till null is encountered
	{
		bytes++;
		if(str[i]>='a' && str[i]<='z')
		{
			str[i] = str[i] - 'a' + 'A';
		}
	}


	__asm__ __volatile__(
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(str), "d"(bytes)
	);//1: stdout

	return bytes;//Return characters printed
}

int printHexInteger (int n)
{
	char buffOut[BUFF], zero = '0';//Declaring output buffer
	int i = 0, j, k, bytes;

	if(n==0)//Trivial Case
		buffOut[i++] = zero;
	else
	{
		if(n<0)
		{
			buffOut[i++] = '-';
			n = -n;
		}
		while(n)
		{
			int unit = n%16;
			if(i>=BUFF)
				return BAD;

			if(unit<=9)
				buffOut[i++] = unit + zero;
			else
				buffOut[i++] = 'A' + unit - 10;

			n = n/16;
		}
	}//Digit extraction and conversion to Hex Format (%X)

	if(buffOut[0] == '-')
		j = 1;
	else 
		j = 0;

	k = i-1;
	while(j<k)
	{
		char temp = buffOut[j];
		buffOut[j++] = buffOut[k];
		buffOut[k--] = temp;
	}//Reversing

	buffOut[i++] = '\n';
	bytes = i;

	__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(buffOut), "d"(bytes)
	);//1: stdout

	return bytes-1;//Characters printed with -1 to compensate for \n
}

int printFloat (float f)
{
	char buffOut[BUFF], intPart[BUFF], decPart[BUFF];//Output buffer declaration

	int iPart = (int)f;//Integer part
	
	int i = 0, j = 0, negFlag = 0, bytes;

	if(f<0)
	{
		negFlag = 1;
		f = -f;
		iPart = -iPart;
	}//Check for negative

	if(iPart==0)
		intPart[i++] = '0';
	else
	{
		while(iPart)
		{
			intPart[i++] = iPart%10 + '0';
			iPart = iPart/10;
		}
	}//Extracting integer part

	for(int l = 0; l<4; l++)
	{
		f = f*10;
		int num = (int)f;
		int dig = num%10;
		decPart[j++] = dig + '0';
	}//Extracting decimal part

	int k = 0;
	if(negFlag)
		buffOut[k++] = '-';

	for(int l = i-1; l>=0; l--)
	{
		if(k>=BUFF)
			return BAD;//Overflow
		buffOut[k++] = intPart[l];
	}//Forming the buffer

	buffOut[k++] = '.';

	for(int l=0; l<j; l++)
	{
		if(k>=BUFF)
			return BAD;//Overflow
		buffOut[k++] = decPart[l];
	}
    
    buffOut[k++] = '\n';
    bytes = k;

    __asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(buffOut), "d"(bytes)
	);//1: stdout

	return bytes-1;//Characters printed -1 to compensate for \n
}

int readHexInteger (int *n)
{
	char buffIn[BUFF];//Input buffer
	int readLength;

	__asm__ __volatile__(
		"movl $0, %%eax\n\t"
		"movq $0, %%rdi\n\t"
		"syscall \n\t"
		:"=a" (readLength)
		:"S"(buffIn), "d"(BUFF)
	);// 0: stdin

	if(readLength<=0)//Checking for bad input
		return BAD;
	int isNeg = 0;
	int first = 0;
	if(buffIn[0]=='-')
	{
		isNeg = 1;
		first = 1;
	}

	long long int base = 1;
	long long int num = 0;
	readLength--;
	for(int i = readLength-1; i>=first; i--)//Digit extraction from buffer
	{
		char ch = buffIn[i];
		long long int hexDig;
		if(ch>='0'&&ch<='9')
		{
			hexDig = ch - '0';
		}
		else if(ch>='a'&&ch<='f')
		{
			hexDig = 10 + ch - 'a';
		}
		else
		{
			return BAD;//Invalid hexadecimal character
		}

		num = num + base*hexDig;

		if(num>MAX_INT)
		{
			return BAD;//Overflow for type int
		}
		base = base*16;
	}
	if(isNeg)
		num = -num;
	*n = (int)num;

	return GOOD;//Return for success
}

int readFloat (float *f)
{
	char buffIn[BUFF];//Input Buffer
	int readLength;//characters read (include \n)

	__asm__ __volatile__(
		"movl $0, %%eax\n\t"
		"movq $0, %%rdi\n\t"
		"syscall \n\t"
		:"=a" (readLength)
		:"S"(buffIn), "d"(BUFF)
	);

	if(readLength<=0)//Bad input
		return BAD;
	int isNeg = 0;
	int first = 0;

	if(buffIn[0]=='-')
	{
		isNeg = 1;
		first = 1;
	}
	readLength--;
	int indexDec = -1, foundDec = 0;
	for(int i = first; i<readLength; i++)//Digit extraction from buffer
	{
		if(buffIn[i]>='1'&&buffIn[i]<='9')
			continue;
		else if(buffIn[i]=='.'&&foundDec==0)
		{
			foundDec = 1;
			indexDec = i;
		}
		else
		{
			return BAD;//Invalod character or 2nd decimal point
		}
	}
	float num = 0.0;
	float base = 1.0;
	if(foundDec==0)
	{
		indexDec = readLength;
	}
	for(int i = indexDec-1; i>=first; i--)
	{
		char ch = buffIn[i];
		num = num + (ch-'0')*base;

		base = base*10.0;
	}
	base = 0.1;
	for(int i=indexDec+1; i<readLength; i++)
	{
		char ch = buffIn[i];
		num = num + (ch-'0')*base;

		base = base/10.0;
	}

	if(isNeg)
		num = -num;

	*f = num;
	return GOOD;//Success return
}