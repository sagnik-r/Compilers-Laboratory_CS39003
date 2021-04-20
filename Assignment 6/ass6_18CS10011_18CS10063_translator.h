#ifndef ASS6_18CS10011_18CS10063_TRANSLATOR_H
#define ASS6_18CS10011_18CS10063_TRANSLATOR_H

#include <stdio.h>
#include <vector>
#include <cstdlib>
#include <string>
#include <set>
#include <map>
#include <stack>
using namespace std;
void func1();
extern map<int,int> mp_set;void func2();
extern int size_int;void func3();
extern int size_double;void func4();
extern int size_pointer;void func5();
extern int size_char;void func6();
extern int size_bool;void func7();
extern stack<string> params_stack;void func8();
extern stack<int> types_stack;void func9();
extern stack<int> offset_stack;void func10();
extern stack<int> ptrarr_stack;void func11();
extern vector<string> strings_label;void func12();
class type_n;void func13();
class expresn;void func14();
class quad; void func15();
class symdata; void func16();
class symtab;void func17();
class quad_arr; void func18();
class funct;void func19();
class arr1;void func20();
//void totest(string x);//to test
struct decStr;void func21();
struct idStr;void func22();
struct expresn;void func23();
struct arglistStr;void func24();
extern type_n *glob_type;void func25();
extern int glob_width; void func26();
extern int next_instr;void func27(); //next instr for use in quads and in different function like backpatch
extern int temp_count;void func28(); // count of the temporary varibles to name the new temporary variable
extern symtab *glob_st;void func29(); //Global symbol table pointer
extern symtab *curr_st;void func30(); //Current Symbol table pointer
extern quad_arr glob_quad;void func31(); //to store all the quads that will be generated by the grammar

enum types{
	tp_void=0,tp_bool,tp_char,tp_int,tp_double,tp_ptr,tp_arr,tp_func
};
void func31();
typedef struct list{
	int index;
	struct list *next;
}list;
void func32();
enum opcode{

	//Binary Assignment Operator
	Q_PLUS=1,Q_MINUS,Q_MULT,Q_DIVIDE,Q_MODULO,Q_LEFT_OP,Q_RIGHT_OP,
	Q_XOR,Q_AND,Q_OR,Q_LOG_AND,Q_LOG_OR,Q_LESS,Q_LESS_OR_EQUAL,
	Q_GREATER_OR_EQUAL,Q_GREATER,Q_EQUAL,Q_NOT_EQUAL,

	//Unary Assignment Operator
	Q_UNARY_MINUS,Q_UNARY_PLUS,Q_COMPLEMENT,Q_NOT,

	//Copy Assignment
	Q_ASSIGN,

	Q_GOTO,

	//Conditional Jump
	Q_IF_EQUAL,Q_IF_NOT_EQUAL,Q_IF_EXPRESSION,Q_IF_NOT_EXPRESSION,
	Q_IF_LESS,Q_IF_GREATER,Q_IF_LESS_OR_EQUAL,Q_IF_GREATER_OR_EQUAL,

	//Type Conversions
	Q_CHAR2INT,Q_CHAR2DOUBLE,Q_INT2CHAR,Q_DOUBLE2CHAR,Q_INT2DOUBLE,Q_DOUBLE2INT,


	//Procedure Call
	Q_PARAM,Q_CALL,Q_RETURN,

	//Pointer Assignment Operator
	Q_LDEREF,Q_RDEREF,
	Q_ADDR,

	//arr1 Indexing
	Q_RINDEX,
	Q_LINDEX,

};
void func33();
//it is the basic type that an element can have
union basic_val{
	int int_val;
	double double_val;
	char char_val;
};
void func34();
class type_n{
public:
	int size;void f1(){return;}    // to save the size of the type
	types basetp;void f2(){return;} // to save the basic type of the elemnt
	type_n *next;void f3(){return;} // to save next type_n type for arrays
	type_n(types t,int sz=1, type_n *n=NULL);void f4(){return;} //constuctor
	int getSize();void f5(){return;} //returns the size
	types getBasetp();void f6(){return;} //return Base type
	void printSize();void f7(){return;} //to print the size
	void print();void f8(){return;} 
};
void func35();
type_n *CopyType(type_n *t);void func1();

class arr1
{
public:
	void f1(){return;}
	/* Stores the arr1 base and the variable containing arr1 offset */
	string base_arr;void f9(){return;}
	types tp;void f10(){return;}
	/* Initiates arr1 name, offset and arr1 type */
	arr1(string s,int sz,types t);void f11(){return;}
	/* Stores arr1 dimensions */
	vector<int> dims;void f12(){return;}

	/* Size of base type */
	int bsize;void f13(){return;}

	/* Number of dimensions */
	int dimension_size;void f14(){return;}

	/* Adds an arr1 index for arr1 accessing */
	void addindex(int i);void f15(){return;}

};

void func36();

/* To store details of functions, its parameters and return type */
class funct
{
public:
	/* Parameter type list */
	void f1(){return;}
	vector<types> typelist;void f16(){return;}
	
	/* Return type */
	type_n *rettype;void f17(){return;}

	funct(vector<types> tpls);void f18(){return;}
	/* Prints details in suitable format */
	void print();void f19(){return;}
};

void func37();
//class which will be used as building element for symbol table
class symdata{
public:
	string name;void f20(){return;}
	int size; void f21(){return;}
	int offset;void f22(){return;}
	basic_val i_val;void f23(){return;}//to store the initialized value for an element stored at symbol table
	type_n *tp_n;void f24(){return;}//for storing the type of element
	symtab *nest_tab;void f25(){return;} //to store the pointer to the symbol table to which the current element belongs to
	arr1 *arr;void f26(){return;}//to store the pointer to an arr1 if its an arr1 type
	funct *fun;void f27(){return;}//to store the pointer to a function if its an function
	void createarray();void f28(){return;}
	string var_type;void f29(){return;}//to store whether the varaible is "null=0" "local=1" "param=2" "func=3" "ret=4" "temporary=5"
	bool isInitialized;void f30(){return;} //If the value of element is initialized or not
	bool isFunction;void f31(){return;} //to know whether the current element is function like function pointer
	bool isArray;void f32(){return;} // to know whether the current element is ab arr1 it helps if we have been in grammar tree
	symdata(string n="");void f33(){return;} //name is initialized to null that will be used for naming temporary variables
	bool ispresent;void f34(){return;}
	bool isdone;void f35(){return;}
	bool isptrarr;void f36(){return;}
	bool isGlobal;void f37(){return;}
};	
void func38();
class symtab{
public:void f1(){return;}
	string name;void f38(){return;}			// name of the symbol
	int offset;void f39(){return;}				// final offset of this symbol table that will be used in the update function
	int start_quad;void f40(){return;}
	int end_quad;void f41(){return;}
	vector<symdata*> symbol_tab;void f42(){return;} //maintaining a list of symbol tables
	symtab();void f43(){return;}  //constructor
	~symtab();void f44(){return;} //destructor
	symdata* lookup(string n);void f45(){return;}// Lookup function searches the variable with name. If the variable is present then returns its pointer location else creates a new entry with its name and returns that pointer
	symdata* lookup_2(string n);void f46(){return;}//To handle global variables
	symdata* search(string n);void f47(){return;} //it searches for the variable and returns the oiter to it if present
	symdata* gentemp(type_n *type);void f48(){return;} //gentemp creates a new element in the symbol table with the type provided at the time of constructing
	void update(symdata *loc,type_n *type,basic_val initval, symtab *next = NULL);void f49(){return;}//
	void print();void f50(){return;}
	int no_params;void f51(){return;}
	void mark_labels();void f52(){return;}
	void function_prologue(FILE *fp,int count);void f53(){return;}
	void global_variables(FILE *fp);void f54(){return;}
	void gen_internal_code(FILE *fp,int ret_count);void f55(){return;}
	int function_call(FILE *fp);void f56(){return;}
	void function_epilogue(FILE *fp,int count,int ret_count);void f57(){return;}
	string assign_reg(int type_of,int no);void f58(){return;}
	void assign_offset();void f59(){return;}
	void function_restore(FILE *fp);void f60(){return;}
	int findg(string n);void f61(){return;}
};
void func39();
struct expresn{
	symdata* loc;
	type_n* type;
	list* truelist;
	list* falselist;
	bool isPointer;
	bool isArray;
	bool isString;
	int ind_str;
	symdata *arr;
	symdata *poss_array;
};
list* makelist(int i); void func40(); 
list* merge(list *l1,list *l2); void func41();
void backpatch(list *l,int i);  void func42();//to fill the dangling list of goto's l1 to i
void conv2Bool(expresn *e);void func43(); //to convert the given exprssion type to bool mostly used in relational operator
void typecheck(expresn *e1,expresn *e2,bool isAss = false);void func44();
void print_list(list *root);void func45();
// struct for declaration grammar
struct decStr
{
	type_n *type;						// type of the current declaration
	int width;					// width of the variable
};
void func46();
class quad{
public:void f1(){return;}
	string arg1,result,arg2;void f62(){return;} //consist of three elements 
	opcode op;void f63(){return;}
	void print_arg();void f64(){return;}
	quad(opcode,string,string,string);void f65(){return;} //constructorparameters
};
void func47();
struct arglistStr
{
	vector<expresn*> *arguments;		// A simple vector is used to store the locations of all seen arguments
};
void func48();
// struct for a identifier
struct idStr
{
	symdata *loc;					// pointer to the symboltable
	string *name;						// name of the identifier
};
void func49();
struct strstr{
	type_n lop;
	string name;
};
void func50();
class quad_arr{
public:void f1(){return;}
	vector<quad> arr;void f66(){return;}//to store the list of quads
	quad_arr();void f67(){return;}
	void emit(opcode opc, string arg1="", string arg2="", string result="");void f68(){return;} //emit used for operations with 3 inputs
	void emit(opcode opc, int val, string operand="");void f69(){return;}  // emit for assignment of integer
	void emit(opcode opc, double val, string operand="");void f70(){return;} //emit for assignment of double
	void emit(opcode opc, char val, string operand="");void f71(){return;} //emit for assignment of char
	void emit2(opcode opc,string arg1="", string arg2="", string result="");void f72(){return;}
	void print();void f73(){return;}  //print all the quads
};
void func51();
#endif