#include "ass5_18CS10011_18CS10063_translator.h"
#include<sstream>
#include<string>
#include<iostream>
using namespace std;

//Reference to global variables declared in header file 
symtable* globalST;					// Global Symbol Table
quadArray q;						// Quad arr1
string typevar;					// Stores latest type
symtable* ST;						// Points to current symbol table
sym* currSymbol; 					// Points to current symbol
basicType bt;                       			// Basic types

sym::sym(string name, string t, symboltype* arrtype, int width){
     
	//Symbol table entry
	this -> name = name;
	type = new symboltype(t, arrtype, width);     //Generate type of symbol
	size = calculateSize(type);                   //Find the size from the type
	offset = 0;                                   //Put offset as 0
	val = "-";                                    //No initial value
	nested = NULL;                                //No nested table
	
}

sym* sym::update(symboltype* t){
	type = t;					//Update the new type
	this -> size = calculateSize(t);              //New size
	return this;                                  //Return the same variable
}

// Constructor for a symbol type
symboltype::symboltype(string type, symboltype* arrtype, int width){        
	this -> type = type;
	this -> width = width;
	this -> arrtype = arrtype;
}

//Simple constructor for a symbol table
symtable::symtable(string name){            
	this -> name = name;
	count = 0;                           		//Put count as 0
}

//Lookup an id in the symbol table
sym* symtable::lookup(string name){               
	sym* symbol;	
	list<sym>::iterator it;                      //Iterator for list of symbols
	for(it = table.begin(); it != table.end(); it++){
		if(it -> name == name)
			return &(*it);                //Find the name of symbol in the symbol table and return if found
	}
	
	//New symbol to be added to table if not found
	symbol = new sym(name);
	table.push_back(*symbol);           		//Push the symbol into the table
	return &table.back();               		//Return the symbol
}

//Update the symbol table
void symtable::update(){
	list<symtable*> tb;                 		//List of tables
	int off;
	for(list<sym>::iterator it = table.begin(); it != table.end(); it++){
		if(it == table.begin()){
			it -> offset = 0;
			off = it -> size;
		}
		else{
			it -> offset = off;
			off = it -> offset + it -> size;
		}
		if(it -> nested != NULL) 
			tb.push_back(it -> nested);
	}
	for(list<symtable*>::iterator it1 = tb.begin(); it1 != tb.end(); ++it1){
	  	(*it1) -> update();
	}
}

//Print the symbol table
void symtable::print(){                          
	int next_instr = 0;					
	list<symtable*> tb;                      	 //List of tables
	next_instr = next_instr + 1;
	int i = 0;
	next_instr = next_instr + 1;
	for(i = 0; i < 100; i++)
		cout<<"~";             		//Design/formatting
	next_instr = next_instr + 1;
	cout << endl;
	next_instr = next_instr + 1;
	cout << "Table Name: " << this -> name << "\t\t\t Parent Name: ";          //Table name
	next_instr = next_instr + 1;
	cout << (this -> parent == NULL ? "NULL" : this -> parent -> name);
	next_instr = next_instr + 1; 
	cout << endl;
	next_instr = next_instr + 1;
	for(i = 0; i < 100; i++) 
		cout<<"-";
	next_instr = next_instr + 1;
	cout << endl;
	next_instr = next_instr + 1;	
	cout << "Name";              			//Name
	next_instr = next_instr + 1;
	generateSpaces(11);
	next_instr = next_instr + 1;
	cout << "Type";              			//Type
	next_instr = next_instr + 1;
	generateSpaces(16);
	next_instr = next_instr + 1;
	cout << "Initial Value";    			//Initial Value
	next_instr = next_instr + 1;
	generateSpaces(7);
	next_instr = next_instr + 1;
	cout << "Size";              			//Size
	next_instr = next_instr + 1;
	generateSpaces(11);
	next_instr = next_instr + 1;
	cout << "Offset";            			//Offset
	next_instr = next_instr + 1;
	generateSpaces(9);
	next_instr = next_instr + 1;
	cout << "Nested" << endl;       		//Nested symbol table
	next_instr = next_instr + 1;
	generateSpaces(100);
	next_instr = next_instr + 1;
	cout << endl;
	next_instr = next_instr + 1;
	ostringstream str1;
	next_instr = next_instr + 1; 
	for(list<sym>::iterator it = table.begin(); it != table.end(); it++){          //Print details for the table
		next_instr = next_instr + 1;
		cout << it -> name;                   //Print name
		next_instr = next_instr + 1;
		generateSpaces(15 - it -> name.length());
		next_instr = next_instr + 1;     
		string typeres = printType(it -> type);               //Use PrintType to print type
		next_instr = next_instr + 1;	
		cout << typeres;
		next_instr = next_instr + 1;
		generateSpaces(20 - typeres.length());
		next_instr = next_instr + 1; 
		cout << it -> val;                                    //Print initial value
		next_instr = next_instr + 1;
		generateSpaces(20 - it -> val.length());
		next_instr = next_instr + 1;
		cout << it -> size;                                   //Print size
		next_instr = next_instr + 1;
		str1 << it -> size;
		next_instr = next_instr + 1;
		generateSpaces(15 - str1.str().length());
		next_instr = next_instr + 1;
		str1.str("");
		next_instr = next_instr + 1;
		str1.clear();
		next_instr = next_instr + 1;
		cout << it -> offset;                                 //Print offset
		next_instr = next_instr + 1;
		str1 << it -> offset;
		next_instr = next_instr + 1;
		generateSpaces(15 - str1.str().length());
		next_instr = next_instr + 1;
		str1.str("");
		next_instr = next_instr + 1;
		str1.clear();
		next_instr = next_instr + 1;
		if(it -> nested == NULL){                             //Print nested
			next_instr = next_instr + 1;
			cout << "NULL" << endl;
			next_instr = next_instr + 1;	
		}
		else{
			next_instr = next_instr + 1;
			cout << it -> nested -> name << endl;
			next_instr = next_instr + 1;	
			tb.push_back(it -> nested);
			next_instr = next_instr + 1;
		}
	}
	next_instr = next_instr + 1;
	for(i = 0; i < 100; i++) 
		cout<< "-";
	next_instr = next_instr + 1;
	cout << "\n\n";
	next_instr = next_instr + 1;
	for(list<symtable*>::iterator it = tb.begin(); it != tb.end(); ++it){ 
		next_instr = next_instr + 1;	
	    	(*it) -> print();                               	//Print symbol table
		next_instr = next_instr + 1;
	}
	next_instr = next_instr + 1;		
}

//General constructor for quad
quad::quad(string res, string arg1, string op, string arg2){           
	this -> res = res;
	this -> arg1 = arg1;
	this -> op = op;
	this -> arg2 = arg2;
}

//General constructor for quad
quad::quad(string res, int arg1, string op, string arg2){             
	this -> res = res;
	this -> arg2 = arg2;
	this -> op = op;
	this -> arg1 = generateString(arg1);
}

//General constructor for quad
quad::quad(string res, float arg1, string op, string arg2){           
	this -> res = res;
	this -> arg2 = arg2;
	this -> op = op;
	this -> arg1 = generateStringfromFloat(arg1);
}

//Print a quad
void quad::print(){                                    
	
	// Binary Operations
	if(op == "+")					{this -> type1();}
	else if(op == "-")				{this -> type1();}
	else if(op == "*")				{this -> type1();}
	else if(op == "/")				{this -> type1();}
	else if(op == "%")				{this -> type1();}
	else if(op == "|")				{this -> type1();}
	else if(op == "^")				{this -> type1();}
	else if(op == "&")				{this -> type1();}
	
	// Relational Operations
	else if(op == "==")				{this -> type2();}
	else if(op == "!=")				{this -> type2();}
	else if(op == "<=")				{this -> type2();}
	else if(op == "<")				{this -> type2();}
	else if(op == ">")				{this -> type2();}
	else if(op == ">=")				{this -> type2();}
	else if(op == "goto")				{cout << "goto " << res;}	
	
	// Shift Operations
	else if(op == ">>")				{this -> type1();}
	else if(op == "<<")				{this -> type1();}
	else if(op == "=")				{cout << res << " = " << arg1;}					
	
	// Unary Operators..
	else if(op == "=&")				{cout << res << " = &" << arg1;}
	else if(op == "=*")				{cout << res << " = *" << arg1;}
	else if(op == "*=")				{cout << "*" << res << " = " << arg1;}
	else if(op == "uminus")			{cout << res << " = -" << arg1;}
	else if(op == "~")				{cout << res << " = ~" << arg1;}
	else if(op == "!")				{cout << res << " = !" << arg1;}
	
	// Other operations
	else if(op == "=[]")	 			{cout << res << " = " << arg1 << "[" << arg2 << "]";}
	else if(op == "[]=")	 			{cout << res << "[" << arg1 << "]" << " = " << arg2;}
	else if(op == "return") 			{cout << "return " << res;}
	else if(op == "param") 			{cout << "param " << res;}
	else if(op == "call") 				{cout << res << " = " << "call " << arg1 << ", " << arg2;}
	else if(op == "label")				{cout << res << ": ";}	
	else						{cout << "Can't find " << op;}			
	
	cout << endl;
}

void quad::type1(){
	cout << res << " = " << arg1 << " " << op << " " << arg2;
}

void quad::type2(){
	cout << "if " << arg1 << " " << op << " " << arg2 << " goto " << res;
}

//Add new trivial type to type ST
void basicType::addType(string t, int s){          
	type.push_back(t);
	size.push_back(s);
}

//Print the quad arr1 i.e the TAC
void quadArray::print(){                                   
	int next_instr = 0;			
	int i;
	for(i = 0; i < 50; i++) 
		cout<< "_";
	next_instr = next_instr + 1;
	cout << endl;
	next_instr = next_instr + 1;
	cout << "Three Address Code: " << endl;           //Print TAC
	next_instr = next_instr + 1;
	for(i = 0; i < 50; i++) 
		cout << "_";
	next_instr = next_instr + 1;
	cout << endl;
	next_instr = next_instr + 1;
	int j = 0;
	next_instr = next_instr + 1;
	for(vector<quad>::iterator it = arr1.begin(); it != arr1.end(); it++){
		if(it->op=="label"){           	//If it is a label, print it
			next_instr = next_instr + 1;
			cout << "\n";
			next_instr = next_instr + 1;
			cout << "L" << j << ": ";
			next_instr = next_instr + 1;
			it -> print();
			next_instr = next_instr + 1;
			cout << "\n";
			next_instr = next_instr + 1;
		}
		else{                         	//Else give 4 spaces and then print
			next_instr = next_instr + 1;
			cout << "L" << j << ": ";
			next_instr = next_instr + 1;
			generateSpaces(4);
			next_instr = next_instr + 1;
			it -> print();
			next_instr = next_instr + 1;
			cout << "\n";
			next_instr = next_instr + 1;
		}
		next_instr = next_instr + 1;
		j++;
	}
	next_instr = next_instr + 1;
	for(i = 0; i < 50; i++) 
		cout << "_";      			//Design/formatting
	cout << endl;
}

void generateSpaces(int n){
	int i;
	for(i = 0; i < n; i++) 
		cout << " ";
}

//To convert int to string
string generateString(int a){                    
	stringstream strs;                      	//Use buffer stringstream
	strs << a;
	string temp = strs.str();
	char* integer = (char*) temp.c_str();
	string str = string(integer);
	return str;                              
}

//To convert float to string
string generateStringfromFloat(float x){                        
	std::ostringstream buff;
	buff << x;
	return buff.str();
}

//Emit a quad: add the quad into the arr1
void emit(string op, string res, string arg1, string arg2){             
	quad *q1 = new quad(res, arg1, op, arg2);
	q.arr1.push_back(*q1);
}

//Emit a quad: add the quad into the arr1
void emit(string op, string res, int arg1, string arg2){                 
	quad *q2 = new quad(res, arg1, op, arg2);
	q.arr1.push_back(*q2);
}

//Emit a quad: add the quad into the arr1
void emit(string op, string res, float arg1, string arg2){                 
	quad *q3 = new quad(res, arg1, op, arg2);
	q.arr1.push_back(*q3);
}

//Convert symbol s into the required return type
sym* convertType(sym* s, string rettype){                             
	sym* temp = gentemp(new symboltype(rettype));
	if(s -> type -> type == "float"){                                      	//If type float
		if(rettype == "int"){                                      		//Converting to int
			emit("=", temp -> name, "float2int("+s -> name+")");
			return temp;
		}
		else if(rettype == "char"){                               		//Converting to char
			emit("=", temp -> name, "float2char("+s -> name+")");
			return temp;
		}
		return s;
	}
	else if(s -> type -> type == "int"){                                  	//If type int
		if(rettype == "float"){ 						//Converting to float
			emit("=", temp -> name, "int2float("+s -> name+")");
			return temp;
		}
		else if(rettype == "char"){ 						//Converting to char
			emit("=", temp -> name, "int2char("+s -> name+")");
			return temp;
		}
		return s;
	}
	else if(s -> type -> type == "char"){ 					//If type char
		if(rettype == "int"){ 							//Converting to int
			emit("=", temp -> name, "char2int("+s -> name+")");
			return temp;
		}
		if(rettype == "double"){ 						//Converting to double
			emit("=", temp -> name, "char2double("+s -> name+")");
			return temp;
		}
		return s;
	}
	return s;
}

//Change current symbol table
void changeTable(symtable* newtable){	       
	ST = newtable;
} 

//Check if the symbols have same type or not
bool checkSymbolType(sym*& s1, sym*& s2){
	
	//Get the base types
	symboltype* type1 = s1 -> type;                         
	symboltype* type2 = s2 -> type;
	if(checkSymbolType(type1, type2)){
		return true;
	}     
	
	//If one can be converted to the other. convert them  
	else if(s1 = convertType(s1, type2 -> type)){
		return true;
	}	
	else if(s2 = convertType(s2, type1 -> type)){
		return true;
	}
	else{
		return false;
	}
}

//Check if the symbol types are same or not
bool checkSymbolType(symboltype* t1, symboltype* t2){
	if(t1 == NULL && t2 == NULL){					//If two symboltypes are NULL
		return true;
	}              
	else if(t1 == NULL){						//If only one of them is NULL
		return false;
	}                     
	else if(t2 == NULL){
		return false;
	}
	else if(t1 -> type != t2 -> type){				//If base type isn't same
		return false;
	}           
	else{								//Otherwise check their arr1 type
		return checkSymbolType(t1 -> arrtype, t2 -> arrtype);
	}       
}

//Backpatching
void backpatch(list<int> l, int addr){                 
	string str = generateString(addr);              		//Get string form of the address
	for(list<int>::iterator it = l.begin(); it != l.end(); it++) 
		q.arr1[*it].res = str;                     		//Backpatching
}

list<int> makelist(int i){ 
	list<int> newlist(1,i);                      			//Make a new list
	return newlist;
}

list<int> merge(list<int> &a, list<int> &b){
	a.merge(b);                                			//Merge two existing lists
	return a;
}

Expression* convertInt2bool(Expression* e){        
	if(e -> type != "bool"){                
		e -> falselist = makelist(nextinstr());    		//Update falselist, truelist and also emit general goto statements
		emit("==", "", e -> loc -> name, "0");
		e -> truelist = makelist(nextinstr());
		emit("goto", "");
	}
}

Expression* convertbool2Int(Expression* e){ 
	if(e -> type == "bool"){ 
		e -> loc = gentemp(new symboltype("int"));         
		backpatch(e -> truelist, nextinstr());
		emit("=", e -> loc -> name, "true");
		int p = nextinstr() + 1;
		string str = generateString(p);
		emit("goto", str);
		backpatch(e -> falselist, nextinstr());
		emit("=", e -> loc -> name, "false");
	}
}

int nextinstr(){
	return q.arr1.size();                //Next instruction will be 1+last index and lastindex=size-1. Hence return size
}

//Generate temporary variable
sym* gentemp(symboltype* t, string init){           
	string name;
	name = "t" + generateString(ST -> count++);             	//Generate name of temporary
	sym* s = new sym(name);
	s -> type = t;
	s -> size = calculateSize(t);                        	//Calculate its size
	s -> val = init;
	ST -> table.push_back(*s);                        		//Push it in ST
	return &ST -> table.back();
	
}

//Function to calculate size
int calculateSize(symboltype* t){                   
	if(t -> type == "void"){	
		return bt.size[1];
	}
	else if(t -> type == "char")
		return bt.size[2];
	else if(t -> type == "int") 
		return bt.size[3];
	else if(t -> type == "float") 
		return  bt.size[4];
	else if(t -> type == "arr") 
		return t->width*calculateSize(t -> arrtype);     	//Recursive for arr1s (Multidimensional arr1s)
	else if(t -> type == "ptr")
		return bt.size[5];
	else if(t -> type == "func")
		return bt.size[6];
	else return -1;
}

//Print type of variable (required for multidimensional arr1s)
string printType(symboltype* t){                    
	if(t==NULL) 
		return bt.type[0];
	if(t -> type == "void")	
		return bt.type[1];
	else if(t -> type == "char")
		return bt.type[2];
	else if(t -> type == "int") 
		return bt.type[3];
	else if(t -> type == "float") 
		return bt.type[4];
	else if(t -> type == "ptr") 
		return bt.type[5]+"("+printType(t -> arrtype)+")";       	//Recursive for ptr
	else if(t -> type == "arr"){
		string str = generateString(t -> width);                      //Recursive for arr1s
		return bt.type[6]+"("+str+","+printType(t -> arrtype)+")";
	}
	else if(t -> type == "func") 
		return bt.type[7];
	else return "NA";
}

void inst1(){return;}
void inst2(){return;}
void inst3(){return;}
void inst4(){return;}
void inst5(){return;}
void inst6(){return;}
void inst7(){return;}
void inst8(){return;}
void inst9(){return;}
void inst10(){return;}
void inst11(){return;}
void inst12(){return;}
void inst13(){return;}
void inst14(){return;}
void inst15(){return;}
void inst16(){return;}
void inst17(){return;}
void inst18(){return;}
void inst19(){return;}
void inst20(){return;}
void inst21(){return;}
void inst22(){return;}
void inst23(){return;}
void inst24(){return;}
void inst25(){return;}
void inst26(){return;}
void inst27(){return;}
void inst28(){return;}

int main(int argc, char* argv[]){
	//Add base types initially
	bt.addType("null", 0);                 
	bt.addType("void", 0);
	bt.addType("char", 1);
	bt.addType("int", 4);
	bt.addType("float", 8);
	bt.addType("ptr", 4);
	bt.addType("arr", 0);
	bt.addType("func", 0);
	
	globalST = new symtable("Global");                         	//Global ST
	ST=globalST;
	yyparse();							//Parse
	globalST->update();						//Update the global ST
	cout<<"\n";		
	globalST->print();						//Print all STs
	q.print();							//Print TAC
};
