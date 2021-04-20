//Arrays and Pointers

int main()
{
	int *b;
	int a = 1;
	b = &a;
	*b = *b + 100;
	printi(a);
	prints("\n");
	int c[10];
	for(i = 0; i < 10; i++)
		c[i] = i * 10;
	prints("Printing elements in array:");
	for(i = 0; i < 10; i++){
		prints("\n");
		printi(c[i]);
	}						 
}
