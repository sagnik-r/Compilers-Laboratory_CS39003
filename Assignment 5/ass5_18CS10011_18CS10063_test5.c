//Pointers and relational operator, if-else
int main()
{
	int a = 1;
	int *b;
	b = &a;
	*b = *b + 1;
	if(a < 0){
		a = a + 1;
	}
	if(a > 0 || a < 10){
		a = a + 1;
		a = a + 2;
	}
	else{
		a = a - 1;
		a = a - 1;
	}
	a = a + 2;
}
