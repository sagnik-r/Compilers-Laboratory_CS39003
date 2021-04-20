//Arithmetic Operators and for loop
int main(){
	int x, y, n, scan;
	int quo, rem, fac;
	fac = 1;
	prints("Enter first number:");
	x = readi(&scan);
	prints("Enter second number:");
	y = readi(&scan);
	if(y != 0){
		quo = x/y;
		rem = x%y;
		prints("Quotient:");
		printi(quo);
		prints("\nRemainder:");
		printi(rem);
	}
	else{
		prints("Can't divide by zero");
	}
	int i;
	prints("\nEnter number:");
	n = readi(&scan);
	for(i = 1; i <= n; i++){
		fac = fac * i;	
	}
	prints("Factorial:");
	printi(fac);					
}
