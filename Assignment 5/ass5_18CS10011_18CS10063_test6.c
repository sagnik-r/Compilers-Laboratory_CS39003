//2D matrices & functions without any parameters
int noParamFunc(){
	int i = 0;
	++i;
	i = (i + 10) ^ 5;
	i--;
	return i;
}

int main(){
	int a[2][3], i, j, k;
	k = 0;
	for(i = 1; i >= 0; i--){
		for(j = 0;j < 3; j++){
			k++;
			a[i][j] = i + j;
			k++;
		}
	}
	k++;
	k = a[1][2];
	k++;
	int y = noParamFunc();
	k++;
	return 0;	
}
