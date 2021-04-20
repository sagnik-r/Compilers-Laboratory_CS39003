%{

//Header Files Needed
#include <iostream>              
#include <cstdlib>
#include <string>
#include <stdio.h>
#include <sstream>

//Translator file
#include "ass5_18CS10011_18CS10063_translator.h"

//yylex for lexer, yyerror for error recovery, typevar for last encountered type
extern int yylex();
void yyerror(string s);
extern string typevar;

using namespace std;
%}

%union{            
  	int instr;		//Instruction number (for backpatching)
	char* charval;		//Char value
	sym* symp;		//Symbol

	Expression* expr;	//Expression
	symboltype* symtp;	//Symbol type  
	Statement* st;		//Statement
	int intval;		//Integer value			

	arr1* A;  		//arr1 type
	int numpar;		//Number of parameters
	char unaryOperator;	//Unary operator
	
//yylval is union of all these types			
}

//Tokens 

%token CONST
%token RESTRICT
%token VOLATILE
%token INLINE
%token BREAK
%token CASE 
%token CHAR 
%token CONTINUE
%token DEFAULT 
%token DO 
%token DOUBLE
%token ELSE 
%token EXTERN
%token FLOAT 
%token FOR 
%token GOTO
%token IF 
%token INT
%token LONG
%token RETURN
%token SHORT
%token SIZEOF
%token STATIC
%token STRUCT
%token SWITCH
%token TYPEDEF
%token UNION 
%token VOID 
%token WHILE 

//Comments
%token MULTI_COMMENT 
%token SINGLE_COMMENT
	
%token BLANK
	
//Constants	
%token <intval> INTEGER_CONST
%token <charval> FLOAT_CONST 
%token <charval> CHARACTER_CONST
	
%token <charval> STRING_LITERAL 
%token <symp> IDENTIFIER 
	
//Punctuators
%token LEFT_SQR 
%token RIGHT_SQR
%token LEFT_BKT 
%token RIGHT_BKT
%token LEFT_CURL
%token RIGHT_CURL
%token DOT 
%token ARROW
%token INC 
%token DCM 
%token BAND
%token MULT
%token PLUS
%token SUB 
%token TILDE
%token NOT 
%token DIV 
%token REM 
%token LSHIFT
%token RSHIFT
%token LT 
%token GT 
%token LEQ
%token GEQ
%token EQEQ
%token NEQ 
%token XOR 
%token BOR 
%token AND 
%token OR 
%token QUES
%token COLON
%token SCOL 
%token DDD 
%token EQL 
%token MEQL
%token DEQL
%token REQL
%token PEQL
%token SEQL
%token LSEQL
%token RSEQL
%token BANDEQL
%token XOREQL 
%token BOREQL 
%token COMMA 
%token HASH

%start translation_unit

%right "then" ELSE			//To remove dangling else problem

//Expressions
%type <expr>
	expression
	primary_expression 
	multiplicative_expression
	additive_expression
	shift_expression
	relational_expression
	equality_expression
	AND_expression
	exclusive_OR_expression
	inclusive_OR_expression
	logical_AND_expression
	logical_OR_expression
	conditional_expression
	assignment_expression
	expression_statement

//number of parameters
%type <numpar>
	argument_expression_list
	argument_expression_list_opt

%type <A>
	postfix_expression
	unary_expression
	cast_expression

//Unary Operator
%type <unaryOperator>
	unary_operator

//symbol
%type <symp>
	initializer
	
%type <symp>
	direct_declarator
	init_declarator
	declarator

//symbol type
%type <symtp>
	pointer

%type <st>  
	statement
	labeled_statement 
	compound_statement
	selection_statement
	iteration_statement
	jump_statement
	block_item
	block_item_list
	block_item_list_opt

//Auxillary non-terminals M and N
%type <instr> M
%type <st> N

%%

M
	:	%empty			//Empty 
	{$$ = nextinstr();}		//Used for backpatching (stores index of the next quad to be generated)
	;

N
	:	%empty			//Empty	  
	{$$ = new Statement();		//Used for backpatching (inserts a goto and stores index of the next goto statement)
	$$ -> nextlist = makelist(nextinstr());
	emit("goto", "");}
	;
	
primary_expression
	:	IDENTIFIER  			//identifier
	{int next_instr = 0; 
	$$ = new Expression();	//create new expression and store pointer to ST entry in the location
	next_instr = next_instr + 1;
	$$ -> loc = $1;
	next_instr = next_instr + 1;
	$$ -> type = "nonbool";
	next_instr = next_instr + 1;}                   					    
	
	|	INTEGER_CONST          					    
	{int next_instr = 0;		
	$$ = new Expression();	//create new expression and store the value of the constant in a temporary
	next_instr = next_instr + 1;
	string p = generateString($1);
	next_instr = next_instr + 1;
	$$ -> loc = gentemp(new symboltype("int"), p);
	next_instr = next_instr + 1;	
	emit("=", $$ -> loc -> name, p);
	next_instr = next_instr + 1;}
	
	|	FLOAT_CONST    
	{int next_instr = 0;
	$$ = new Expression();	 //create new expression and store the value of the constant in a temporary
	next_instr = next_instr + 1;
	$$ -> loc = gentemp(new symboltype("float"), $1);
	next_instr = next_instr + 1;
	emit("=", $$ -> loc -> name, string($1));
	next_instr = next_instr + 1;}
	
	|	CHARACTER_CONST       	  					
	{int next_instr = 0;		
	$$ = new Expression();	 //create new expression and store the value of the constant in a temporary
	next_instr = next_instr + 1;
	$$ -> loc = gentemp(new symboltype("char"), $1);
	next_instr = next_instr + 1;
	emit("=", $$ -> loc -> name, string($1));
	next_instr = next_instr + 1;}
	
	|	STRING_LITERAL        		
	{int next_instr = 0;		
	$$ = new Expression();	 //create new expression and store the value of the constant in a temporary
	next_instr = next_instr + 1;
	$$ -> loc = gentemp(new symboltype("ptr"), $1);
	next_instr = next_instr + 1;
	$$ -> loc -> type -> arrtype = new symboltype("char");
	next_instr = next_instr + 1;}
	
	|	LEFT_BKT expression RIGHT_BKT   //simply equal to expression     
	{$$ = $2;}
	;
	
postfix_expression
	:	primary_expression 		//create new Array and store the location of primary expression in it     				       
	{int next_instr = 0;		
	$$ = new arr1();
	next_instr = next_instr + 1;
	$$ -> arr1 = $1 -> loc;
	next_instr = next_instr + 1;
	$$ -> type = $1 -> loc -> type;
	next_instr = next_instr + 1; 					
	$$ -> loc = $$ -> arr1;
	next_instr = next_instr + 1;}
	
	|	postfix_expression LEFT_SQR expression RIGHT_SQR 
	{int next_instr = 0;		
	$$ = new arr1();
	next_instr = next_instr + 1;
	$$ -> type = $1 -> type -> arrtype;		//type = type of element		
	next_instr = next_instr + 1;							
	$$ -> arr1 = $1 -> arr1;			//copy the base		 			
	next_instr = next_instr + 1;						
	$$ -> loc = gentemp(new symboltype("int"));		//store computer address
	next_instr = next_instr + 1;						
	$$ -> atype = "arr";			//atype is arr			
	next_instr = next_instr + 1;
	if($1 -> atype == "arr"){	// if already arr, multiply the size of the sub-type of Array with the expression value and add			
		next_instr = next_instr + 1;	
		sym* t = gentemp(new symboltype("int"));
		next_instr = next_instr + 1;
		int p = calculateSize($$ -> type);
		next_instr = next_instr + 1;
		string str = generateString(p);
		next_instr = next_instr + 1;			
		emit("*", t -> name, $3 -> loc -> name, str);	
		next_instr = next_instr + 1;	
		emit("+", $$ -> loc -> name, $1 -> loc -> name, t -> name);
		next_instr = next_instr + 1;
	}
	else{          // if 1 D array, simply calculate size              
		next_instr = next_instr + 1;
		int p = calculateSize($$ -> type);
		next_instr = next_instr + 1;
		string str = generateString(p);
		next_instr = next_instr + 1;		
 		emit("*", $$ -> loc -> name, $3 -> loc -> name, str);
		next_instr = next_instr + 1;
	}
	}
	
	|	postfix_expression LEFT_BKT argument_expression_list_opt RIGHT_BKT       
	// call the function with number of parameters from argument_expression_list_opt
	{int next_instr = 0;		 
  	$$ = new arr1();
	next_instr = next_instr + 1;
	$$ -> arr1 = gentemp($1 -> type);
	next_instr = next_instr + 1;
	string str = generateString($3);
	next_instr = next_instr + 1;		
	emit("call", $$ -> arr1 -> name, $1 -> arr1 -> name, str);
	next_instr = next_instr + 1;}
	
	|	postfix_expression DOT IDENTIFIER
	{}
	
	|	postfix_expression ARROW IDENTIFIER
	{}
	
	|	postfix_expression INC 	 //generate new temporary, equate it to old one and then add 1              
	{int next_instr = 0;		 
  	$$ = new arr1();
	next_instr = next_instr + 1;
	$$ -> arr1 = gentemp($1 -> arr1 -> type);
	next_instr = next_instr + 1;
	emit("=", $$ -> arr1 -> name, $1 -> arr1 -> name);
	next_instr = next_instr + 1;
	emit("+", $1 -> arr1 -> name, $1 -> arr1 -> name, "1");
	next_instr = next_instr + 1;}
	
	|	postfix_expression DCM      //generate new temporary, equate it to old one and then subtract 1          
	{int next_instr = 0;		 
  	$$ = new arr1();
	next_instr = next_instr + 1;
	$$ -> arr1 = gentemp($1 -> arr1 -> type);
	next_instr = next_instr + 1;
	emit("=", $$ -> arr1 -> name, $1 -> arr1 -> name);
	next_instr = next_instr + 1;
	emit("-", $1 -> arr1 -> name, $1 -> arr1 -> name, "1");
	next_instr = next_instr + 1;}
	
	|	LEFT_BKT type_name RIGHT_BKT LEFT_CURL initializer_list RIGHT_CURL
	{}
	
	|	LEFT_BKT type_name RIGHT_BKT LEFT_CURL initializer_list COMMA RIGHT_CURL
	{}
	;
	
argument_expression_list_opt
	:	%empty 				//Empty   
	{$$ = 0;}
	
	|	argument_expression_list  //Equate $$ and $1
	{$$ = $1;} 
	;
	
argument_expression_list
	:	assignment_expression    
	{int next_instr = 0;		
	$$ = 1;      					//one argument and emit param                                
	next_instr = next_instr + 1;						
	emit("param", $1 -> loc -> name);
	next_instr = next_instr + 1;}
	
	|	argument_expression_list COMMA assignment_expression     
	{int next_instr = 0;		 
	$$ = $1 + 1;                   // one more argument and emit param               
	next_instr = next_instr + 1;	 
	emit("param", $3 -> loc -> name);
	next_instr = next_instr + 1;}
	;
	
unary_expression
	:	postfix_expression   //simply equate
	{$$ = $1;}
	 					  
	|	INC unary_expression     //simply add 1                      
	{int next_instr = 0;			
	emit("+", $2 -> arr1 -> name, $2 -> arr1 -> name, "1");
	next_instr = next_instr + 1;	
	$$ = $2;
	next_instr = next_instr + 1;}
	
	|	DCM unary_expression    //simply subtract 1                       
	{int next_instr = 0;		 
	emit("-", $2 -> arr1 -> name, $2 -> arr1 -> name, "1");
	next_instr = next_instr + 1;  
	$$ = $2;
	next_instr = next_instr + 1;}
	
	|	unary_operator cast_expression    //if it is of this type, where unary operator is involved                   
	{int next_instr = 0;							  	
	$$ = new arr1();
	next_instr = next_instr + 1;  
	if($1 == '&'){    //address of something, then generate a pointer temporary and emit the quad                                   
		next_instr = next_instr + 1;
		$$ -> arr1 = gentemp((new symboltype("ptr")));
		next_instr = next_instr + 1;
		$$ -> arr1 -> type -> arrtype = $2 -> arr1 -> type; 
		next_instr = next_instr + 1;
		emit("=&", $$ -> arr1 -> name, $2 -> arr1 -> name);
		next_instr = next_instr + 1;
	}
	else if($1 == '*'){    //value of something, then generate a temporary of the corresponding type and emit the quad	     
		next_instr = next_instr + 1;
		$$ -> atype = "ptr";
		next_instr = next_instr + 1;
		$$ -> loc = gentemp($2 -> arr1 -> type -> arrtype);
		next_instr = next_instr + 1;
		$$ -> arr1 = $2 -> arr1;
		next_instr = next_instr + 1;
		emit("=*", $$ -> loc -> name, $2 -> arr1 -> name);
		next_instr = next_instr + 1;
	}
	else if($1 == '+')	//unary plus, do nothing
		 $$ = $2;                    
	else if($1 == '-'){		 //unary minus, generate new temporary of the same base type and make it negative of current one			   
		next_instr = next_instr + 1;
		$$ -> arr1 = gentemp(new symboltype($2 -> arr1 -> type -> type));
		next_instr = next_instr + 1;
		emit("uminus", $$ -> arr1 -> name, $2 -> arr1 -> name);
		next_instr = next_instr + 1;
	}
	else if($1 == '~'){      //bitwise not, generate new temporary of the same base type and make it negative of current one             
		next_instr = next_instr + 1;
		$$ -> arr1 = gentemp(new symboltype($2 -> arr1 -> type -> type));
		next_instr = next_instr + 1;
		emit("~", $$ -> arr1 -> name, $2 -> arr1 -> name);
		next_instr = next_instr + 1;
	}
	else if($1 == '!'){		//logical not, generate new temporary of the same base type and make it negative of current one		
		next_instr = next_instr + 1;
		$$ -> arr1 = gentemp(new symboltype($2 -> arr1 -> type -> type));
		next_instr = next_instr + 1;
		emit("!", $$ -> arr1 -> name, $2 -> arr1 -> name);
		next_instr = next_instr + 1;
	}
	}
	
	|	SIZEOF unary_expression
	{}
	
	|	SIZEOF LEFT_BKT type_name RIGHT_BKT
	{}
	;
	
unary_operator 	 //simply equate to the corresponding operator
	:	BAND
	{$$ = '&';}
	
	|	MULT
	{$$ = '*';}
	
	|	PLUS
	{$$ = '+';}
	
	|	SUB
	{$$ = '-';}
	
	|	TILDE
	{$$ = '~';} 
	
	|	NOT
	{$$ = '!';}
	;
	
cast_expression
	:	unary_expression 	//unary expression, simply equate
	{$$ = $1;}
	                       
	|	LEFT_BKT type_name RIGHT_BKT cast_expression    //if cast type is given      
	{int next_instr = 0;		
	$$ = new arr1();
	next_instr = next_instr + 1;
	$$ -> arr1 = convertType($4 -> arr1, typevar); 	//generate a new symbol of the given type            
	next_instr = next_instr + 1;}
	;

multiplicative_expression
	:	cast_expression  
	{int next_instr = 0;		
	$$ = new Expression();     //generate new expression        
	next_instr = next_instr + 1;						    
	if($1 -> atype == "arr"){  //if it is of type arr			   
		next_instr = next_instr + 1;
		$$ -> loc = gentemp($1 -> loc -> type);
		next_instr = next_instr + 1;
		emit("=[]", $$ -> loc -> name, $1 -> arr1 -> name, $1 -> loc -> name);   //emit with Array right  
		next_instr = next_instr + 1;
	}
	else if($1 -> atype == "ptr"){    //if it is of type ptr     
		next_instr = next_instr + 1;
		$$ -> loc = $1 -> loc;       //equate the locs  
		next_instr = next_instr + 1;
	}
	else
		$$ -> loc = $1 -> arr1;
	}
	
	|	multiplicative_expression MULT cast_expression      //if we have multiplication     
	{int next_instr = 0;		
	if(checkSymbolType($1 -> loc, $3 -> arr1)){     //if types are compatible, generate new temporary and equate to the product     
		next_instr = next_instr + 1;
		$$ = new Expression();
		next_instr = next_instr + 1;
		$$ -> loc = gentemp(new symboltype($1 -> loc -> type -> type));
		next_instr = next_instr + 1;
		emit("*", $$ -> loc -> name, $1 -> loc -> name, $3 -> arr1 -> name);
		next_instr = next_instr + 1;
	}
	else
		cout << "Type Error in Program" << endl;	// error	
	next_instr = next_instr + 1;
	}
	
	|	multiplicative_expression DIV cast_expression    //if we have division  
	{int next_instr = 0;		 
	if(checkSymbolType($1 -> loc, $3 -> arr1)){ 	 //if types are compatible, generate new temporary and equate to the quotient
		next_instr = next_instr + 1;
		$$ = new Expression();
		next_instr = next_instr + 1;
		$$ -> loc = gentemp(new symboltype($1 -> loc -> type -> type));
		next_instr = next_instr + 1;					
		emit("/", $$ -> loc -> name, $1 -> loc -> name, $3 -> arr1 -> name);
		next_instr = next_instr + 1;					
	}
	else   //error
		cout << "Type Error in Program" << endl;
	next_instr = next_instr + 1;
	}
	
	|	multiplicative_expression REM cast_expression    //if we have mod
	{int next_instr = 0;		
	if(checkSymbolType($1 -> loc, $3 -> arr1)){  //if types are compatible, generate new temporary and equate to the quotient
		next_instr = next_instr + 1;					
		$$ = new Expression();
		next_instr = next_instr + 1;	
		$$ -> loc = gentemp(new symboltype($1 -> loc -> type -> type));
		next_instr = next_instr + 1;					
		emit("%", $$ -> loc -> name, $1 -> loc -> name, $3 -> arr1 -> name);
		next_instr = next_instr + 1;	
	}
	else	//error
		cout << "Type Error in Program" << endl;
	next_instr = next_instr + 1;
	}
	;
	
additive_expression
	:	multiplicative_expression	 //simply equate
	{$$ = $1;}            
	
	|	additive_expression PLUS multiplicative_expression      //if we have addition 
	{int next_instr = 0;			
	if(checkSymbolType($1 -> loc, $3 -> loc)){	//if types are compatible, generate new temporary and equate to the sum
		next_instr = next_instr + 1;
		$$ = new Expression();
		next_instr = next_instr + 1;
		$$ -> loc = gentemp(new symboltype($1 -> loc -> type -> type));
		next_instr = next_instr + 1;
		emit("+", $$ -> loc -> name, $1 -> loc -> name, $3 -> loc -> name);
		next_instr = next_instr + 1;
	}
	else
		cout << "Type Error in Program" << endl;//error
	next_instr = next_instr + 1;
	}
	
	|	additive_expression SUB multiplicative_expression   //if we have subtraction 
	{int next_instr = 0;		
	if(checkSymbolType($1 -> loc, $3 -> loc)){   //if types are compatible, generate new temporary and equate to the difference  
		next_instr = next_instr + 1;
		$$ = new Expression();
		next_instr = next_instr + 1;
		$$ -> loc = gentemp(new symboltype($1 -> loc -> type -> type));
		next_instr = next_instr + 1;
		emit("-", $$ -> loc -> name, $1 -> loc -> name, $3 -> loc -> name);
		next_instr = next_instr + 1;
	}
	else
		cout << "Type Error in Program" << endl;	//error
	next_instr = next_instr + 1;
	}
	;
	
shift_expression
	:	additive_expression		//simply equate
	{$$ = $1;}              
	
	|	shift_expression LSHIFT additive_expression   
	{int next_instr = 0;			 
	if($3 -> loc -> type -> type == "int"){    //if base type is int, generate new temporary and equate to the shifted value       
		next_instr = next_instr + 1;
	  	$$ = new Expression();
		next_instr = next_instr + 1;
	  	$$ -> loc = gentemp(new symboltype("int"));
		next_instr = next_instr + 1;
      		emit("<<", $$ -> loc -> name, $1 -> loc -> name, $3 -> loc -> name);
		next_instr = next_instr + 1;
	}
	else
		cout << "Type Error in Program" << endl;  //error
	next_instr = next_instr + 1;
	}
	
	|	shift_expression RSHIFT additive_expression
	{int next_instr = 0;				
	if($3 -> loc -> type -> type == "int"){ 	//if base type is int, generate new temporary and equate to the shifted value	
		next_instr = next_instr + 1;
	  	$$ = new Expression();
		next_instr = next_instr + 1;
	  	$$ -> loc = gentemp(new symboltype("int"));
		next_instr = next_instr + 1;
      		emit(">>", $$ -> loc -> name, $1 -> loc -> name, $3 -> loc -> name);
		next_instr = next_instr + 1;
	}
	else
		cout << "Type Error in Program" << endl; //error
	next_instr = next_instr + 1;
	}
	;

relational_expression
	:	shift_expression	 //simply equate
	{$$ = $1;}              
	
	|	relational_expression LT shift_expression
	{int next_instr = 0;		
	if(checkSymbolType($1 -> loc, $3 -> loc)){      
		next_instr = next_instr + 1;							
		$$ = new Expression();
		next_instr = next_instr + 1;
		$$ -> type = "bool";       //new type is boolean                  
		next_instr = next_instr + 1;							
		$$ -> truelist = makelist(nextinstr());     //makelist for truelist and falselist 
		next_instr = next_instr + 1;							
		$$ -> falselist = makelist(nextinstr() + 1);
		next_instr = next_instr + 1;							
		emit("<", "", $1 -> loc -> name, $3 -> loc -> name);   //emit statement if a<b goto ..   
		next_instr = next_instr + 1;							
		emit("goto", "");	//emit statement goto ..
		next_instr = next_instr + 1;
	}
	else
		cout << "Type Error in Program" << endl;//error
	next_instr = next_instr + 1;
	}
	
	|	relational_expression GT shift_expression    //similar to above, check compatible types,make new lists and emit      
	{int next_instr = 0;		
	if(checkSymbolType($1 -> loc, $3 -> loc)){
		next_instr = next_instr + 1;
		$$ = new Expression();
		next_instr = next_instr + 1;
		$$ -> type = "bool";
		next_instr = next_instr + 1;
		$$ -> truelist = makelist(nextinstr());
		next_instr = next_instr + 1;
		$$ -> falselist = makelist(nextinstr() + 1);
		next_instr = next_instr + 1;
		emit(">", "", $1 -> loc -> name, $3 -> loc -> name);
		next_instr = next_instr + 1;	
		emit("goto", "");
		next_instr = next_instr + 1;				
	}
	else
		cout << "Type Error in Program" << endl;
	next_instr = next_instr + 1;
	}
	
	|	relational_expression LEQ shift_expression		//similar to above, check compatible types,make new lists and emit	 
	{int next_instr = 0;		
	if(checkSymbolType($1 -> loc, $3 -> loc)){
		next_instr = next_instr + 1;
		$$ = new Expression();
		next_instr = next_instr + 1;	
		$$ -> type = "bool";
		next_instr = next_instr + 1;
		$$ -> truelist = makelist(nextinstr());
		next_instr = next_instr + 1;
		$$ -> falselist = makelist(nextinstr() + 1);
		next_instr = next_instr + 1;
		emit("<=", "", $1 -> loc -> name, $3 -> loc -> name);
		next_instr = next_instr + 1;
		emit("goto", "");
		next_instr = next_instr + 1;
	}
	else
		cout << "Type Error in Program" << endl;
	next_instr = next_instr + 1;
	}
	
	|	relational_expression GEQ shift_expression 		//similar to above, check compatible types,make new lists and emit	 
	{int next_instr = 0;		
	if(checkSymbolType($1 -> loc, $3 -> loc)){
		next_instr = next_instr + 1;
		$$ = new Expression();
		next_instr = next_instr + 1;
		$$ -> type = "bool";
		next_instr = next_instr + 1;
		$$ -> truelist = makelist(nextinstr());
		next_instr = next_instr + 1;
		$$ -> falselist = makelist(nextinstr() + 1);
		next_instr = next_instr + 1;		
		emit(">=", "", $1 -> loc -> name, $3 -> loc -> name);
		next_instr = next_instr + 1;	
		emit("goto", "");
		next_instr = next_instr + 1;
	}
	else 
		cout << "Type Error in Program" << endl;
	next_instr = next_instr + 1;
 	}
 	;
 	
equality_expression
	:	relational_expression	//simply equate
	{$$ = $1;}
							
	|	equality_expression EQEQ relational_expression 
	{int next_instr = 0;		
	if(checkSymbolType($1->loc, $3->loc)){     //check compatible types           
		next_instr = next_instr + 1;
		convertbool2Int($1);       //convert bool to int            
		next_instr = next_instr + 1;
		convertbool2Int($3);
		next_instr = next_instr + 1;
		$$ = new Expression();
		next_instr = next_instr + 1;
		$$ -> type = "bool";
		next_instr = next_instr + 1;
		$$ -> truelist = makelist(nextinstr());     //make lists for new expression       
		next_instr = next_instr + 1;
		$$ -> falselist = makelist(nextinstr() + 1); 
		next_instr = next_instr + 1;
		emit("==", "", $1 -> loc -> name, $3 -> loc -> name);   //emit if a==b goto ..   
		next_instr = next_instr + 1;
		emit("goto", "");			//emit goto ..	
		next_instr = next_instr + 1;
	}
	else
		cout << "Type Error in Program" << endl;
	next_instr = next_instr + 1;
	}

	|	equality_expression NEQ relational_expression   //Similar to above, check compatibility, convert bool to int, make list and emit
	{int next_instr = 0;		
	if(checkSymbolType($1 -> loc, $3 -> loc)){ 
		next_instr = next_instr + 1;
		convertbool2Int($1);
		next_instr = next_instr + 1;
		convertbool2Int($3);
		next_instr = next_instr + 1;
		$$ = new Expression();          //result is boolean       
		next_instr = next_instr + 1;
		$$ -> type = "bool";
		next_instr = next_instr + 1;
		$$ -> truelist = makelist(nextinstr());
		next_instr = next_instr + 1;
		$$ -> falselist = makelist(nextinstr() + 1);
		next_instr = next_instr + 1;
		emit("!=", "", $1 -> loc -> name, $3 -> loc -> name);
		next_instr = next_instr + 1;
		emit("goto", "");
		next_instr = next_instr + 1;
	}
	else
		cout << "Type Error in Program" << endl;
	next_instr = next_instr + 1;
	}
	;
	
AND_expression
	:	equality_expression		//simply equate
	{$$ = $1;}						
	
	|	AND_expression BAND equality_expression 
	{int next_instr = 0;		
	if(checkSymbolType($1 -> loc, $3 -> loc)){    //check compatible types           
		next_instr = next_instr + 1;
		convertbool2Int($1);          //convert bool to int                   
		next_instr = next_instr + 1;   
		convertbool2Int($3);
		next_instr = next_instr + 1;
		$$ = new Expression();
		next_instr = next_instr + 1;
		$$ -> type = "nonbool";       //result is not boolean             
		next_instr = next_instr + 1;
		$$ -> loc = gentemp(new symboltype("int"));
		next_instr = next_instr + 1;
		emit("&", $$ -> loc -> name, $1 -> loc -> name, $3 -> loc -> name);   //emit the quad            
		next_instr = next_instr + 1;
	}
	else
		cout << "Type Error in Program" << endl;
	next_instr = next_instr + 1;
	}
	;
	
exclusive_OR_expression
	:	AND_expression		//simply equate
	{$$ = $1;}		
			
	|	exclusive_OR_expression XOR AND_expression     //same as and_expression: check compatible types, make non-boolean expression and convert bool to int and emit
	{int next_instr = 0;			 
  	if(checkSymbolType($1 -> loc, $3 -> loc)){     
  		next_instr = next_instr + 1;
		convertbool2Int($1);
		next_instr = next_instr + 1;
		convertbool2Int($3);
		next_instr = next_instr + 1;			
		$$ = new Expression();
		next_instr = next_instr + 1;
		$$ -> type = "nonbool";
		next_instr = next_instr + 1;
		$$ -> loc = gentemp(new symboltype("int"));
		next_instr = next_instr + 1;
		emit("^", $$ -> loc -> name, $1 -> loc -> name, $3 -> loc -> name);
		next_instr = next_instr + 1;
	}
	else 
		cout << "Type Error in Program" << endl;
	next_instr = next_instr + 1;
  	}
  	;
  	
inclusive_OR_expression
	:	exclusive_OR_expression		//simply equate
	{$$ = $1;}			
					
	|	inclusive_OR_expression BOR exclusive_OR_expression    //same as and_expression: check compatible types, make non-boolean expression and convert bool to int and emit      
	{int next_instr = 0;		
  	if(checkSymbolType($1 -> loc, $3 -> loc)){   
  		next_instr = next_instr + 1;
		convertbool2Int($1);
		next_instr = next_instr + 1;	
		convertbool2Int($3);
		next_instr = next_instr + 1;
		$$ = new Expression();
		next_instr = next_instr + 1;
		$$ -> type = "nonbool";
		next_instr = next_instr + 1;					
		$$ -> loc = gentemp(new symboltype("int"));
		next_instr = next_instr + 1;	
		emit("|", $$ -> loc -> name, $1 -> loc -> name, $3 -> loc -> name);
		next_instr = next_instr + 1;
	}
	else 
		cout << "Type Error in Program" << endl;
	next_instr = next_instr + 1; 
  	}
  	;
  	
logical_AND_expression
	:	inclusive_OR_expression			//simply equate
	{$$ = $1;}				
					  
	|	logical_AND_expression N AND M inclusive_OR_expression     //backpatching involved here 
	{int next_instr = 0;		
	convertInt2bool($5);       //convert inclusive_or_expression int to bool  
	next_instr = next_instr + 1;
	backpatch($2 -> nextlist, nextinstr());  //$2->nextlist goes to next instruction      
	next_instr = next_instr + 1;
	convertInt2bool($1);       //convert logical_and_expression to bool            
	next_instr = next_instr + 1;
	$$ = new Expression();     //make new boolean expression 
	next_instr = next_instr + 1;
	$$ -> type = "bool";
	next_instr = next_instr + 1;	
	backpatch($1 -> truelist, $4);    //if $1 is true, we move to $5    
	next_instr = next_instr + 1;
	$$ -> truelist = $5 -> truelist;   //if $5 is also true, we get truelist for $$     
	next_instr = next_instr + 1;
	$$ -> falselist = merge($1 -> falselist, $5 -> falselist);   //merge their falselists 
	next_instr = next_instr + 1;}
	;
	
logical_OR_expression
	:	logical_AND_expression	//simply equate
	{$$ = $1;}				
	
	|	logical_OR_expression N OR M logical_AND_expression   //backpatching involved here     
	{int next_instr = 0;		
  	convertInt2bool($5);		//convert logical_and_expression int to bool	 
	next_instr = next_instr + 1;
	backpatch($2 -> nextlist, nextinstr());		//$2->nextlist goes to next instruction
	next_instr = next_instr + 1;
	convertInt2bool($1);			//convert logical_or_expression to bool
	next_instr = next_instr + 1;
	$$ = new Expression();			//make new boolean expression
	next_instr = next_instr + 1;	
	$$ -> type = "bool";
	next_instr = next_instr + 1;
	backpatch($1 -> falselist, $4);		//if $1 is true, we move to $5
	next_instr = next_instr + 1;	
	$$ -> truelist = merge($1 -> truelist, $5 -> truelist);		//merge their truelists
	next_instr = next_instr + 1;							
	$$ -> falselist = $5 -> falselist;		//if $5 is also false, we get falselist for $$ 	
	next_instr = next_instr + 1;}
	;
	
conditional_expression 
	:	logical_OR_expression	//simply equate
	{$$ = $1;}       
	
	|	logical_OR_expression N QUES M expression N COLON M conditional_expression 
	{
		//normal conversion method to get conditional expressions	
	int next_instr = 0;		
	$$ -> loc = gentemp($5 -> loc -> type);    //generate temporary for expression    
	next_instr = next_instr + 1;
	$$ -> loc -> update($5 -> loc -> type);
	next_instr = next_instr + 1;
	emit("=", $$ -> loc -> name, $9 -> loc -> name);     //make it equal to sconditional_expression 
	next_instr = next_instr + 1;
	list<int> l = makelist(nextinstr());    //makelist next instruction    
	next_instr = next_instr + 1;	
	emit("goto", "");              //prevent fallthrough
	next_instr = next_instr + 1;
	backpatch($6 -> nextlist, nextinstr());    //after N, go to next instruction     
	next_instr = next_instr + 1;
	emit("=", $$ -> loc -> name, $5 -> loc -> name);
	next_instr = next_instr + 1;	        
	list<int> m = makelist(nextinstr());   //makelist next instruction      
	next_instr = next_instr + 1;	
	l = merge(l, m);			//merge the two lis			
	next_instr = next_instr + 1;				
	emit("goto", "");		//prevent fallthrough				
	next_instr = next_instr + 1;
	backpatch($2 -> nextlist, nextinstr());   //backpatching
	next_instr = next_instr + 1;
	convertInt2bool($1);        //convert expression to boolean           
	next_instr = next_instr + 1;
	backpatch($1 -> truelist, $4);     //$1 true goes to expression      
	next_instr = next_instr + 1;
	backpatch($1 -> falselist, $8);      //$1 false goes to conditional_expression     
	next_instr = next_instr + 1;
	backpatch(l, nextinstr());
	next_instr = next_instr + 1;}
	;
	
assignment_expression
	:	conditional_expression		//simply equate
	{$$ = $1;}         
		
	|	unary_expression assignment_operator assignment_expression 
	{int next_instr = 0;		
	if($1 -> atype == "arr"){      //if type is arr, simply check if we need to convert and emit 
		next_instr = next_instr + 1;
		$3 -> loc = convertType($3 -> loc, $1 -> type -> type);
		next_instr = next_instr + 1;
		emit("[]=", $1 -> arr1 -> name, $1 -> loc -> name, $3 -> loc -> name);
		next_instr = next_instr + 1;	
	}
	else if($1 -> atype == "ptr"){      //if type is ptr, simply emit
		next_instr = next_instr + 1;
		emit("*=", $1 -> arr1 -> name, $3 -> loc -> name);
		next_instr = next_instr + 1;	
	}
	else{          //otherwise assignment                     
		next_instr = next_instr + 1;
		$3 -> loc = convertType($3 -> loc, $1 -> arr1 -> type -> type);
		next_instr = next_instr + 1;	
		emit("=", $1 -> arr1 -> name, $3 -> loc -> name);
		next_instr = next_instr + 1;
	}
	next_instr = next_instr + 1;
	$$ = $3;
	next_instr = next_instr+1;}
	;
	
assignment_operator
	:	EQL
	{}
	
	|	MEQL
	{}
	
	|	DEQL
	{}
	
	|	REQL
	{}
	
	|	PEQL
	{}
	
	|	SEQL
	{}
	
	|	LSEQL
	{}
	
	|	RSEQL
	{}
	
	|	BANDEQL
	{}
	
	|	XOREQL
	{}
	
	|	BOREQL
	{}
	;
	
expression
	:	assignment_expression
	{$$ = $1;}
	
	|	expression COMMA assignment_expression
	{}
	;
	
constant_expression
	:	conditional_expression
	{}
	;

declaration
	:	declaration_specifiers init_declarator_list SCOL
	{}
	
	|	declaration_specifiers SCOL
	{}
	;


declaration_specifiers
	:	storage_class_specifier declaration_specifiers
	{}
	
	|	storage_class_specifier
	{}
	
	|	type_specifier declaration_specifiers
	{}
	
	|	type_specifier
	{}
	
	|	type_qualifier declaration_specifiers
	{}
	
	|	type_qualifier
	{}
	
	|	function_specifier declaration_specifiers
	{}
	
	|	function_specifier 
	{}
	;
	
init_declarator_list
	:	init_declarator
	{}
	
	|	init_declarator_list COMMA init_declarator
	{}
	;

init_declarator
	:	declarator
	{$$ = $1;}
	
	|	declarator EQL initializer 
	{if($3 -> val != "")		 //get the initial value and  emit it
		$1 -> val = $3 -> val;        
	emit("=", $1 -> name, $3 -> name);}
	;

storage_class_specifier
	:	EXTERN
	{}
	
	|	STATIC
	{}
	;
	
type_specifier		 //store the latest type in var_type
	:	VOID
	{typevar = "void";}           
	
	|	CHAR
	{typevar = "char";}
	
	|	SHORT
	{}
	
	|	INT
	{typevar = "int";}
	
	|	LONG
	{}
	
	|	FLOAT
	{typevar = "float";}
	
	|	DOUBLE
	{}
	;
	
specifier_qualifier_list
	:	type_specifier specifier_qualifier_list_opt
	{}
	
	|	type_qualifier specifier_qualifier_list_opt
	{}
	;

specifier_qualifier_list_opt
	:	%empty				//Empty
	{}
	
	|	specifier_qualifier_list
	{}
	;
	
type_qualifier
	:	CONST
	{}
	
	|	RESTRICT
	{}
	
	|	VOLATILE
	{}
	;

function_specifier
	:	INLINE
	{}
	;
	
declarator
	:	pointer direct_declarator 
	{int next_instr = 0;		
	symboltype *t = $1;
	next_instr = next_instr + 1;
	while(t -> arrtype != NULL)		//for multidimensional arr1s, move in depth till you get the base type
		t = t -> arrtype;           
	next_instr = next_instr + 1;
	t -> arrtype = $2 -> type;     //add the base type               
	next_instr = next_instr + 1;
	$$ = $2 -> update($1);      //update             
	next_instr = next_instr + 1;}
	
	|	direct_declarator
	{}
        ;

direct_declarator
	:	IDENTIFIER        //if ID, simply add a new variable of var_type         
	{int next_instr = 0;		
	$$ = $1 -> update(new symboltype(typevar));
	next_instr = next_instr + 1;	
	currSymbol = $$;
	next_instr = next_instr + 1;}
	
	|	LEFT_BKT declarator RIGHT_BKT		//simply equate
	{$$ = $2;}        
	
	|	direct_declarator LEFT_SQR type_qualifier_list assignment_expression RIGHT_SQR
	{}
	
	|	direct_declarator LEFT_SQR type_qualifier_list RIGHT_SQR
	{}
	
	|	direct_declarator LEFT_SQR assignment_expression RIGHT_SQR
	{int next_instr = 0;		
	symboltype *t = $1 -> type;
	next_instr = next_instr + 1;
	symboltype *prev = NULL;
	next_instr = next_instr + 1;
	while(t -> type == "arr"){
		next_instr = next_instr+1;
		prev = t;
		next_instr = next_instr + 1;
		t = t -> arrtype;       //keep moving recursively to get basetype
		next_instr = next_instr + 1;
	}
	if(prev == NULL){
		next_instr = next_instr + 1;
		int temp = atoi($3 -> loc -> val.c_str());  //get initial value    
		next_instr = next_instr + 1;		
		symboltype* s = new symboltype("arr", $1 -> type, temp);    //create new symbol with that initial value    
		next_instr = next_instr + 1;	
		$$ = $1 -> update(s);   //update the symbol table
		next_instr = next_instr + 1;
	}
	else{
		next_instr = next_instr + 1;	
		prev -> arrtype = new symboltype("arr", t, atoi($3 -> loc -> val.c_str()));     //similar arguments as above	 
		next_instr = next_instr + 1;	
		$$ = $1 -> update($1 -> type);
		next_instr = next_instr + 1;	
	}
	}
	
	|	direct_declarator LEFT_SQR RIGHT_SQR 
	{int next_instr = 0;		       
	symboltype *t = $1 -> type;
	next_instr = next_instr + 1;
	symboltype *prev = NULL;
	next_instr = next_instr + 1;
	while(t -> type == "arr"){
		next_instr = next_instr + 1;	
		prev = t;
		next_instr = next_instr + 1;
		t = t -> arrtype;      //keep moving recursively to base type   
		next_instr = next_instr + 1;	
	}
	if(prev == NULL){
		next_instr = next_instr + 1;
		symboltype* s = new symboltype("arr", $1 -> type, 0);    //no initial values, simply keep 0
		next_instr = next_instr + 1;
		$$ = $1 -> update(s);
		next_instr = next_instr + 1;
	}
	else{
		next_instr = next_instr + 1;
		prev -> arrtype = new symboltype("arr", t, 0);
		next_instr = next_instr + 1;	
		$$ = $1 -> update($1 -> type);
		next_instr = next_instr + 1;
	}
	}
	
	|	direct_declarator LEFT_SQR STATIC type_qualifier_list assignment_expression RIGHT_SQR
	{}
	
	|	direct_declarator LEFT_SQR STATIC assignment_expression RIGHT_SQR
	{}
	
	|	direct_declarator LEFT_SQR type_qualifier_list MULT RIGHT_SQR
	{}
	
	|	direct_declarator LEFT_SQR MULT RIGHT_SQR 
	{}
	
	|	direct_declarator LEFT_BKT changetable parameter_type_list RIGHT_BKT
	{int next_instr = 0;				
	ST -> name = $1 -> name;
	next_instr = next_instr + 1;
	if($1 -> type -> type != "void"){
		next_instr = next_instr + 1;
		sym *s = ST -> lookup("return");     //lookup for return value    
		next_instr = next_instr + 1;
		s -> update($1 -> type);
		next_instr = next_instr + 1;			
	}
	next_instr = next_instr + 1;
	$1 -> nested = ST;       
	next_instr = next_instr + 1;	
	ST -> parent = globalST;
	next_instr = next_instr + 1;
	changeTable(globalST);		// Come back to globalsymbol table		
	next_instr = next_instr + 1;
	currSymbol = $$;
	next_instr = next_instr + 1;}
	
	|	direct_declarator LEFT_BKT identifier_list RIGHT_BKT
	{}
	
	|	direct_declarator LEFT_BKT changetable RIGHT_BKT	 //similar as above
	{int next_instr = 0;		
	ST -> name = $1 -> name;
	next_instr = next_instr + 1;
	if($1 -> type -> type != "void"){
		next_instr = next_instr + 1;
		sym *s = ST -> lookup("return");
		next_instr = next_instr + 1;
		s -> update($1 -> type);
		next_instr = next_instr + 1;		
	}
	next_instr = next_instr + 1;
	$1 -> nested=ST;
	next_instr = next_instr + 1;
	ST -> parent = globalST;
	next_instr = next_instr + 1;
	changeTable(globalST);		// Come back to globalsymbol table		
	next_instr = next_instr + 1;
	currSymbol = $$;
	next_instr = next_instr + 1;}
	;
	
changetable
	:	%empty
	{int next_instr = 0;		
	if(currSymbol -> nested == NULL)
		changeTable(new symtable(""));	// Function symbol table doesn't already exist
	else{
		next_instr = next_instr + 1;
		changeTable(currSymbol -> nested);	// Function symbol table already exists					
		next_instr = next_instr + 1;			
		emit("label", ST -> name);
		next_instr = next_instr + 1;
	}
	}
	;
	
type_qualifier_list_opt
	:	%empty				//Empty 
	{}
	
	|	type_qualifier_list      
	{}
	;

pointer
	:	MULT type_qualifier_list_opt
	{$$ = new symboltype("ptr");}	 //create new pointer
	
	|	MULT type_qualifier_list_opt pointer 
	{$$ = new symboltype("ptr", $3);}
	;

type_qualifier_list
	:	type_qualifier   
	{}
	
	|	type_qualifier_list type_qualifier
	{}
	;
	
parameter_type_list
	:	parameter_list   
	{}
	
	|	parameter_list COMMA DDD   
	{}
	;

parameter_list
	:	parameter_declaration   
	{}
	
	|	parameter_list COMMA parameter_declaration    
	{}
	;

parameter_declaration
	:	declaration_specifiers declarator   
	{}
	
	|	declaration_specifiers
	{}
	;
	
identifier_list
	:	IDENTIFIER
	{}
	
	|	identifier_list COMMA IDENTIFIER
	{}
	;

type_name
	:	specifier_qualifier_list
	{}
	;

initializer
	:	assignment_expression   //assignment
	{$$ = $1 -> loc;}    
		   
	|	LEFT_CURL initializer_list RIGHT_CURL  
	{}
	
	|	LEFT_CURL initializer_list COMMA RIGHT_CURL
	{}
	;

initializer_list
	:	designation_opt initializer  
	{}
	
	|	initializer_list COMMA designation_opt initializer   
	{}
	;
	
designation_opt
	:	%empty 			//Empty
	{}
	
	|	designation   
	{}
	;

designation
	:	designator_list EQL   
	{}
	;
	
designator_list
	:	designator    
	{}
	
	|	designator_list designator   
	{}
	;

designator
	:	LEFT_SQR constant_expression RIGHT_SQR   
	{}
	
	|	DOT IDENTIFIER 
	{}
	;

//Statements

statement
	:	labeled_statement   
	{}
	
	|	compound_statement   
	{$$ = $1;}
	
	|	expression_statement
	{$$ = new Statement();        //create new statement with same nextlist       
	$$ -> nextlist = $1 -> nextlist;} 
		 
	|	selection_statement   
	{$$ = $1;}
		 
	|	iteration_statement   
	{$$ = $1;}
	 
	|	jump_statement   
	{$$ = $1;}
	;

labeled_statement
	:	IDENTIFIER COLON statement   
	{}
	
	|	CASE constant_expression COLON statement   
	{}
	
	|	DEFAULT COLON statement   
	{}
	;
	
compound_statement
	:	LEFT_CURL block_item_list_opt RIGHT_CURL   //equate
	{$$ = $2;}  
	;

block_item_list_opt 
	:	%empty				//Empty   	
	{$$ = new Statement();}    //create new statement   
	
	|	block_item_list    //simply equate
	{$$ =$1;}        
	;

block_item_list 
	:	block_item   //simply equate
	{$$ = $1;}			
	
	|	block_item_list M block_item    
	{$$ = $3;
	backpatch($1 -> nextlist, $2);}		//after $1, move to block_item via $2
	;
	
block_item
	:	declaration   
	{$$ = new Statement();}      //new statement    
	
	|	statement   //simply equate
	{$$ = $1;}				
	;

expression_statement
	:	expression SCOL //simply equate
	{$$ = $1;}			

	|	SCOL 	
	{$$ = new Expression();}    //new  expression  
	;
	
selection_statement
	:	IF LEFT_BKT expression N RIGHT_BKT M statement N %prec "then"    // if statement without else  
	{int next_instr = 0;		
	backpatch($4 -> nextlist, nextinstr());     //nextlist of N goes to nextinstr   
	next_instr = next_instr + 1;						
	convertInt2bool($3);       //convert expression to bool  
	next_instr = next_instr + 1;
	$$ = new Statement();      //make new statement  
	next_instr = next_instr + 1;
	backpatch($3 -> truelist, $6);    //if expression is true, go to M i.e just before statement body    
	next_instr = next_instr + 1;
	list<int> temp = merge($3 -> falselist, $7 -> nextlist);   //merge falselist of expression, nextlist of statement and second N
	next_instr = next_instr + 1;        
	$$ -> nextlist = merge($8 -> nextlist, temp);
	next_instr = next_instr + 1;}
	
	|	IF LEFT_BKT expression N RIGHT_BKT M statement N ELSE M statement   //if statement with else
	{int next_instr = 0;		
	backpatch($4 -> nextlist, nextinstr());		//nextlist of N goes to nextinstr
	next_instr = next_instr + 1;	
	convertInt2bool($3);        //convert expression to bool
	next_instr = next_instr + 1;
	$$ = new Statement();      //make new statement 
	next_instr = next_instr + 1;
	backpatch($3 -> truelist, $6);    //when expression is true, go to M1 else go to M2
	next_instr = next_instr + 1;
	backpatch($3 -> falselist, $10);
	next_instr = next_instr + 1;
	list<int> temp = merge($7 -> nextlist, $8 -> nextlist);      //merge the nextlists of the statements and second N   
	next_instr = next_instr + 1;
	$$ -> nextlist = merge($11 -> nextlist, temp);
	next_instr = next_instr + 1;}
					
	|	SWITCH LEFT_BKT expression RIGHT_BKT statement 		//not to be modelled
	{}       
	;
	
iteration_statement	
	:	WHILE M LEFT_BKT expression RIGHT_BKT M statement      //while statement
	{int next_instr = 0;		
	$$ = new Statement();    //create statement
	next_instr = next_instr + 1;
	convertInt2bool($4);     //convert expression to bool
	next_instr = next_instr + 1;	
	backpatch($7 -> nextlist, $2);	// M1 to go back to expression again
	next_instr = next_instr + 1;
	backpatch($4 ->truelist, $6);	// M2 to go to statement if the expression is true
	next_instr = next_instr + 1;
	$$ -> nextlist = $4 -> falselist;   //when expression is false, move out of loop
	next_instr = next_instr + 1;
	// Emit to prevent fallthrough
	string str = generateString($2);
	next_instr = next_instr + 1;	
	emit("goto", str);
	next_instr = next_instr + 1;}
	
	|	DO M statement M WHILE LEFT_BKT expression RIGHT_BKT SCOL     //do statement 
	{int next_instr = 0;		
	$$ = new Statement();     //create statement
	next_instr = next_instr + 1;
	convertInt2bool($7);      //convert to bool
	next_instr = next_instr + 1;
	backpatch($7 -> truelist, $2);	// M1 to go back to statement if expression is true					
	next_instr = next_instr + 1;	
	backpatch($3 -> nextlist, $4);	// M2 to go to check expression if statement is complete					
	next_instr = next_instr + 1;
	$$ -> nextlist = $7 -> falselist;   //move out if statement is false                     
	next_instr = next_instr + 1;}
					
	|	FOR LEFT_BKT expression_statement M expression_statement RIGHT_BKT M statement  //for loop    
	{int next_instr = 0;		
	$$ = new Statement();   //create new statement
	next_instr = next_instr + 1;
	convertInt2bool($5);    //convert check expression to boolean
	next_instr = next_instr + 1;
	backpatch($5 -> truelist,$7);     //if expression is true, go to M2    
	next_instr = next_instr + 1;        
	backpatch($8 -> nextlist, $4);     //after statement, go back to M1   
	next_instr = next_instr + 1;
	string str = generateString($4);
	next_instr = next_instr + 1; 
	emit("goto", str);        //prevent fallthrough          
	next_instr = next_instr + 1;
	$$ -> nextlist = $5 -> falselist;    //move out if statement is false  
	next_instr = next_instr + 1;}
					
	|	FOR LEFT_BKT expression_statement M expression_statement M expression N RIGHT_BKT M statement		//for loop
	{int next_instr = 0;		
	$$ = new Statement();	 //create new statement	 
	next_instr = next_instr + 1;
	convertInt2bool($5);    //convert check expression to boolean
	next_instr = next_instr + 1;
	backpatch($5 -> truelist, $10);		 //if expression is true, go to M2
	next_instr = next_instr + 1; 
	backpatch($8 -> nextlist, $4);		//after N, go back to M1
	next_instr = next_instr + 1;
	backpatch($11 -> nextlist, $6);		//statement go back to expression
	next_instr = next_instr + 1;
	string str = generateString($6);
	next_instr = next_instr + 1;	   
	emit("goto", str);			 //prevent fallthrough	
	next_instr = next_instr + 1;		
	$$ -> nextlist = $5 -> falselist;	 //move out if statement is false
	next_instr = next_instr + 1;}
	;
	
jump_statement
	:	GOTO IDENTIFIER SCOL 
	{$$ = new Statement();}        //not to be modelled    
	
	|	CONTINUE SCOL 
	{$$ = new Statement();}		//not to be modelled	   
	
	|	BREAK SCOL 
	{$$ = new Statement();}		//not to be modelled		 
	
	|	RETURN expression SCOL               
  	{int next_instr = 0;		
	$$ = new Statement();
	next_instr = next_instr + 1;
	emit("return", $2 -> loc -> name);      //emit return with the name of the return value          
	next_instr = next_instr + 1;}
		
	|	RETURN SCOL 
	{int next_instr = 0;		
	$$ = new Statement();
	next_instr = next_instr + 1;
	emit("return", "");             //simply emit return             
	next_instr = next_instr + 1;}
	;
	
translation_unit
	:external_declaration 
	{}
	
	|translation_unit external_declaration 
	{} 
	;

external_declaration
	:	function_definition 
	{}
	
	|	declaration   
	{}
	;

function_definition
	:	declaration_specifiers declarator declaration_list_opt changetable compound_statement  
	{int next_instr = 0;			 
	ST -> parent = globalST;
	next_instr = next_instr + 1;	
	changeTable(globalST);}		 //once we come back to this at the end, change the table to global Symbol table
	;

declaration_list
	:	declaration   
	{}
	
	|	declaration_list declaration    
	{}
	;				   										  				   

declaration_list_opt
	:%empty			//Empty 	
	{}
	
	|	declaration_list   
	{}
	;

%%

void yyerror(string s){        
	cout << s << endl;
}
