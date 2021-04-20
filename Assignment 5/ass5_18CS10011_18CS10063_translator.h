#ifndef _TRANSLATE_H
#define _TRANSLATE_H

#include <bits/stdc++.h>

extern  char* yytext;
extern  int yyparse();

using namespace std;

class sym;					//Stands for an entry in ST
class symboltype;				//Stands for the type of a symbol in ST
class symtable;				//Stands for ST
class quad;					//Stands for a single entry in the quad arr1
class quadArray;				//Stands for the arr1 of quads

class symboltype{							//For the type of symbol                      
	public:
		void next_quad1(){cout<<""; cout<<""; return;}
		string type;						//Stores the type of symbol.
		void next_quad2(){cout<<"";cout<<"";return;} 
		int width;					    	//stores the size of arr1 (if encountered) and it is 1 by default 
		void next_quad3(){cout<<"";cout<<"";return;}		
		symboltype* arrtype;					//Needed for multidimensional arr1s
		void next_quad4(){cout<<"";cout<<"";return;}		
		
		//Constructor
		symboltype(string type, symboltype* ptr = NULL, int width = 1);
		void next_quad5(){cout<<"";cout<<"";return;}
};

class sym{                      					//For an entry in ST
	public:
		void next_quad1(){cout<<"";cout<<"";return;}
		string name;						//Denotes the name of the symbol
		void next_quad2(){cout<<"";cout<<"";return;}		
		symboltype *type;					//Denotes the type of the symbol
		void next_quad3(){cout<<"";cout<<"";return;}		
		int size;						//Denotes the size of the symbol
		void next_quad4(){cout<<"";cout<<"";return;}			
		int offset;						//Denotes the offset of symbol in ST
		void next_quad5(){cout<<"";cout<<"";return;}
		symtable* nested;					//Points to the nested symbol table
		void next_quad6(){cout<<"";cout<<"";return;}		
		string val;				    		//Initial value of the symbol if specified
		void next_quad7(){cout<<"";cout<<"";return;}
		
		//Constructor
		sym (string name, string t = "int", symboltype* ptr = NULL, int width = 0);
		void next_quad8(){cout<<"";cout<<"";return;}		
		
		//Update the ST Entry 		
		sym* update(symboltype *t); 				//Method to update different fields of an existing entry
		void next_quad9(){cout<<"";cout<<"";return;}
};

class quad{ 			

	/*A single quad has four components:
	i) Result
	ii) Operator
	iii) Argument 1
	iv) Argument 2*/
	public:
		void next_quad1(){cout<<"";cout<<"";return;}
		string res;						// Result
		void next_quad2(){cout<<"";cout<<"";return;}		
		string op;						//Operator
		void next_quad3(){cout<<"";cout<<"";return;}		
		string arg1;						//Argument 1
		void next_quad4(){cout<<"";cout<<"";return;}		
		string arg2;						//Argument 2

		//Print the Quad
		void next_quad5(){cout<<"";cout<<"";return;}		
		void print();	
		void next_quad6(){cout<<"";cout<<"";return;}		
		void type1();      					//Common printing types
		void next_quad7(){cout<<"";cout<<"";return;}		
		void type2();
		void next_quad8(){cout<<"";cout<<"";return;}
		
		//Constructors							
		quad (string res, string arg1, string op = "=", string arg2 = "");			
		void next_quad9(){cout<<"";cout<<"";return;}		
		quad (string res, int arg1, string op = "=", string arg2 = "");				
		void next_quad10(){cout<<"";cout<<"";return;}		
		quad (string res, float arg1, string op = "=", string arg2 = "");			
		void next_quad11(){cout<<"";cout<<"";return;}
};

class symtable { 							//For the Symbol Table Class, we have
	public:
		void next_quad1(){cout<<"";cout<<"";return;}
		string name;						//Name of the Table
		void next_quad2(){cout<<"";cout<<"";return;}
		int count;						//Count of the temporary variables
		void next_quad3(){cout<<"";cout<<"";return;}
		list<sym> table; 					//The table of symbols which is essentially a list of sym
		void next_quad4(){cout<<"";cout<<"";return;}
		symtable* parent;					//Parent ST of the current ST
		
		//Constructor
		void next_quad5(){cout<<"";cout<<"";return;}
		symtable (string name="NULL");
		void next_quad6(){cout<<"";cout<<"";return;}	
		
		//Lookup for a symbol in ST
		sym* lookup (string name);		
		void next_quad7(){cout<<"";cout<<"";return;}	
		
		//Print the ST						
		void print();	
		void next_quad8(){cout<<"";cout<<"";return;}	
		
		//Update the ST				            			
		void update();
		void next_quad9(){cout<<"";cout<<"";return;}						        			
};

class basicType{                        				//To denote a basic type
	public:
		void next_quad1(){cout<<"";cout<<"";return;}
		vector<string> type;                    		//Type name
		void next_quad2(){cout<<"";cout<<"";return;}		
		vector<int> size;                       		//Size
		void next_quad3(){cout<<"";cout<<"";return;}
		void addType(string t,int size);
		void next_quad4(){cout<<"";cout<<"";return;}
};

class quadArray{ 							//Quad Array
	public:
		void next_quad1(){cout<<"";cout<<"";return;}
		vector<quad> arr1;		                    	//arr1 (vector) of quads
		
		//Print the quadArray
		void next_quad2(){cout<<"";cout<<"";return;}	
		void print();
		void next_quad3(){cout<<"";cout<<"";return;}								
};

void inst1();
extern quadArray q;							//Denotes the quad arr1
void inst2();
extern symtable* globalST;				    		//Denotes the Global Symbol Table
void inst3();
extern sym* currSymbol;					    	//Denotes the latest encountered symbol
void inst4();
extern basicType bt;                        				//Denotes the Type ST
void inst5();
extern symtable* ST;							//Denotes the current Symbol Table
void inst6();
string generateStringfromFloat(float x);
void inst7();
string generateString(int a);
void inst8();
void generateSpaces(int n);
void inst9();

//Emit Functions
void emit(string op, string result, int arg1, string arg2 = "");
void inst10();
void emit(string op, string result, string arg1="", string arg2 = "");  		  
void inst11();
void emit(string op, string result, float arg1, string arg2 = "");   
void inst12();
sym* gentemp (symboltype* t, string init = "");	  		//Generate a temporary variable and insert it in the current ST
void inst13();

//Backpatching and related functions
void inst14();
list<int> makelist (int i);						//Make a new list contaninig an integer
void inst15();
void backpatch (list <int> lst, int i);
void inst16();
int nextinstr();							//Returns the next instruction number
list<int> merge (list<int> &l1, list <int> &l2);			//Merge two lists into a single list
void inst17();

//Type checking and conversion functions
void inst18();
bool checkSymbolType(sym* &s1, sym* &s2);				//Check for same type of two symbol table entries
void inst19();
sym* convertType(sym*, string);					//For type conversion
void inst20();
int calculateSize (symboltype *);					//Calculate size of symbol type
void inst21();
bool checkSymbolType(symboltype* t1, symboltype* t2);		//Check for same type of two symboltype objects
void inst22();
void changeTable (symtable* newtable);				//To change current table
void inst23();
string printType(symboltype *);					//Print type of symbol
void inst24();

struct arr1{
	string atype;							//Used for type of arr1: may be ptr or arr
	sym* loc;							//Location used to compute address of arr1
	sym* arr1;							//pointer to the symbol table entry
	symboltype* type;						//Type of the subarr1 generated (needed for multidimensional arr1s)
};

//Other structures
void inst25();
struct Statement{
	list<int> nextlist;						//Nextlist for Statement
};

void inst26();

struct Expression{
	sym* loc;							//Pointer to the symbol table entry
	string type; 							//Stores whether the expression is of type int, bool, float or char
	list<int> truelist;						//Truelist for boolean expressions
	list<int> falselist;						//Falselist for boolean expressions
	list<int> nextlist;						//For statement expressions
};

void inst27();
Expression* convertInt2bool(Expression*);				//Convert int expression to boolean
void inst28();
Expression* convertbool2Int(Expression*);				//Convert boolean expression to int

#endif
