//Program to test operations on 1d arrays
int main()
{
	int arr[5];
	int i = 0;
	i = i + 1;
	
	for(i = 0; i < 5; i++){
		arr[i] = i + 1;
	}
	
	i = i + 1;
	int sum = 0;
	i = -1;
	i = i + 1;
	
	while(i < 5 && sum >= 0){
		sum = sum + arr[i];
		i++;
	}
	return 0;
}
