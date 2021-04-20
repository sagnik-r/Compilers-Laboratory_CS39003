//Program to test do..while, while & for loop, and bitwise operations
int main()
{
	int i = 0;
	int j = 0;
	
	do{
		i++;
	}while(i < 10);
	
	while(i > 0){
		i--;
	}
	
	for(i = 0; i < 10; i++){
		i++;
	}
	
	i = i << 2;
	i = i >> 2;
	j = i ^ i;
	j = i | i;
}
