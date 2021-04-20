//To show function call
int max(int a[],int n){
	int i, max;
	max = a[0];
	for(i = 1; i < n; i++){
		if(max < a[i])
			max = a[i];
	}
	return max;
}

int main(){
	int a[100];
	int i, n, scan;
	prints("Enter number of elements in array(should be less than 100):");
	n = readi(&scan);
	for(i = 0; i < n; i++){
		prints("Enter Element:");
		a[i] = readi(&scan);
	}
	prints("Maximum element of array:");
	printi(max(a,n));
}
