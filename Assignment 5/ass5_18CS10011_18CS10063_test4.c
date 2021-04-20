//Program to test pointer related operations
int test1(char *c, int a, int b){
	return 1;
}

int main()
{
	int i = 10;
	int *p = &i;
	i++;
	*p = *p/2;
	i++;
	int j = 5;
	p = &j;
	i++;
	j = j >> 1;
	*p = *p - 1;
	i++;
	if(i == *p) 
		i++;
	if(j == *p) 
		j--;
	else 
		i = j + 3;
	i++;
	int a1 = i;
	int a2 = j % 5;
	i++;
	char s[100]= "The values are:";
	test1(s, a1, a2);
	i++;
}


