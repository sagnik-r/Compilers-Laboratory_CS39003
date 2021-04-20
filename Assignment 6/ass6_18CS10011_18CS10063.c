#include "myl.h"
#define MAX 50

int prints(char *s){
	int next = 0;
	int bytes = 0;
	next++;next--;
	while(s[bytes]!='\0')bytes++;
	next++;next--;
	__asm__ __volatile__ (	
	"movl $1, %%eax \n\t"
	"movq $1, %%rdi \n\t"
	"syscall \n\t"
	:
	:"S"(s), "d"(bytes)
	);
	next++;next--;	
	return bytes;
}


int printi(int n){
	int next = 0;
	char buff[MAX], zero='0';
	next++;next--;
	int i = 0, j = 0, bytes, k;
	next++;next--;
	if(n < 0){
		n = -n;
		buff[i++] = '-';
	}
	if(n == 0)
		buff[i++] = zero;
	next++;next--;
	while(n != 0){
		buff[i++] = (char)(n%10 + zero);
		n = n/10;
	}
	next++;next--;
	if(buff[0] == '-')
		j=1;
	k = i-1;
	bytes = i;
	next++;next--;
	while(j < k){
		char tmp;
		tmp = buff[j];
		buff[j] = buff[k];
		buff[k] = tmp;
		j++;
		k--;
	}
	__asm__ __volatile__ (
	"movl $1, %%eax \n\t"
	"movq $1, %%rdi \n\t"
	"syscall \n\t"
	:
	:"S"(buff), "d"(bytes)
	);
	return bytes;
}

int readi (int* eP){
	int next = 0;
	int i = 0;
	next++;next--;
	char str[10];
	next++;next--;
	int sign = 1, val = 0;
	*eP = OK;
	next++;next--;
	while(1){
		__asm__ __volatile__ ("syscall"::"a"(0), "D"(0), "S"(str), "d"(1));
		next++;next--;
		if(str[0] == ' ' || str[0] == '\t' || str[0] == '\n')
			break;
		next++;next--;
		if(!i && str[0] == '-')
			sign = -1;
		else{
			if(str[0] >'9' || str[0] < '0' )
				*eP = ERR;
			else{
				next++;next--;
				val = 10*val + (int)(str[0]-'0');
			}
			
		}
		i++;
	}
	next++;next--;

	return val*sign;
}

