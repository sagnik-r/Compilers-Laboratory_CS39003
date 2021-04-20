//Logical operators and if else
int main(){
	int a, b, c;
	int scan;
	int min, max, sum;
	prints("Enter first number:");
	a = readi(&scan);
	prints("Enter second number:");
	b = readi(&scan);
	prints("Enter third number:");
	c = readi(&scan);
	if(a < b){
		if(a < c){
			min = a;
		}
		else{
			min = c;
		}				
	}
	else{
		if(b < c){
			min = b;
		}
		else{
			min = c;
		}
	}
	if(a > b){
		if(a > c){
			max = a;
		}
		else{
			max = c;
		}				
	}
	else{
		if(b > c){
			max = b;
		}
		else{
			max = c;
		}
	}
	
	sum = a + b + c;
	prints("Min:");
	printi(min);
	prints("\nMax:");
	printi(max);
	prints("\nSum:");
	printi(sum);
}
