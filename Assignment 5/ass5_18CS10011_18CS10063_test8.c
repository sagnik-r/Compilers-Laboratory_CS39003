//3d arrays and sending pointers as parameters
void swap(int *a,int *b){
	int temp = *a;
	*a = *b;
	*b = temp;
	return;
}

int main(){
	int a[3][2][4];
	int i,j,k;
	i = 0;
	j = 0;
	a[i][j][2] = 0;
	k = a[i][j][2];
	swap(&i, &j);
}
