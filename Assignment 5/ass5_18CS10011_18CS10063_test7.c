//Handling float and char data types, conditional expressions, nested if, general operators
int main(){
	int k = 0;	
	float a = 2.3;
	int b;
	k++;	
	int c = 2;
	b = a + c;
	k++;
	c--;
	b = b * a;
	k++;
	int t = -(b + 5);
	int u = ~(b);
	int v = !(b);
	k++;
	b = b % c + 100;
	k++;
	if(b == 100){ 
		if(c != 3)
			c = 0;
		else 
			c = 1;
	}
	k++;
	int s;
	s = b > 100 ? 1 : 0;
	k++;
	char r = 'a', r1 = 'c';
	int q = 30;
	k++;
	r = r - q;
}
