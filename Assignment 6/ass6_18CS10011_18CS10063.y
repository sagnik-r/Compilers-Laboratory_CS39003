%{
	#include <iostream>              
	#include <cstdlib>
	#include <string>
	#include <stdio.h>
	#include <sstream>	
	#include "ass6_18CS10011_18CS10063_translator.h"
    	void yyerror(const char*);
    	extern int yylex(void);
    	using namespace std;
%}


%union{
	int intval;			//To hold the value of integer constant
	char charval;			//To hold the value of character constant
    	idStr idl;			//To define the type for Identifier
    	float floatval;		//To hold the value of floating constant
    	string *strval;		//To hold the value of enumberation scnstant
    	decStr decl;			//To define the declarators
    	arglistStr argsl;		//To define the argumnets list
    	int instr;			//To defin the type used by M->(epsilon)
    	expresn expon;			//To define the structure of expression
    	list *nextlist;		//To define the nextlist type for N->(epsilon)
}

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

%token POINTER 
%token INCREMENT 
%token DECREMENT 
%token LEFT_SHIFT 
%token RIGHT_SHIFT 
%token LESS_EQUALS 
%token GREATER_EQUALS 
%token EQUALS 
%token NOT_EQUALS
%token AND 
%token OR 
%token ELLIPSIS 
%token MULTIPLY_ASSIGN 
%token DIVIDE_ASSIGN 
%token MODULO_ASSIGN 
%token ADD_ASSIGN 
%token SUBTRACT_ASSIGN
%token LEFT_SHIFT_ASSIGN
%token RIGHT_SHIFT_ASSIGN 
%token AND_ASSIGN 
%token XOR_ASSIGN 
%token OR_ASSIGN 
%token SINGLE_LINE_COMMENT 
%token MULTI_LINE_COMMENT

%token <idl> IDENTIFIER  
%token <intval> INTEGER_CONSTANT
%token <floatval> FLOATING_CONSTANT
%token <charval> CHAR_CONST
%token <strval> STRING_LITERAL

%type <expon> 
	primary_expression 
	postfix_expression 
	unary_expression 
	cast_expression 
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
	assignment_expression_opt 
	assignment_expression 
	constant_expression 
	expression 
	expression_statement 
	expression_opt 
	declarator 
	direct_declarator 
	initializer 
	declaration 
	init_declarator_list 
	init_declarator_list_opt 
	init_declarator

%type <nextlist> 
	block_item_list 
	block_item 
	statement 
	labeled_statement 
	compound_statement 
	selection_statement 
	iteration_statement 
	jump_statement 
	block_item_list_opt

%type <argsl> 
	argument_expression_list 
	argument_expression_list_opt

%type <decl> 
	type_specifier 
	declaration_specifiers 
	specifier_qualifier_list 
	type_name 
	pointer 
	pointer_opt

%type <instr> M
%type <nextlist> N
%type <charval> unary_operator

%start translation_unit

%left '+' '-'
%left '*' '/' '%'
%nonassoc UNARY
%nonassoc IF_CONFLICT
%nonassoc ELSE

%%

M: {
	$$ = next_instr;
};

N: {
	$$ = makelist(next_instr);
    	glob_quad.emit(Q_GOTO, -1);
};

/*Expressions*/

primary_expression
	:	IDENTIFIER {
	int nextinstr = 0;
	//Check whether its a function
	symdata * check_func = glob_st->search(*$1.name);
	nextinstr = nextinstr + 1;
	if(check_func == NULL){
		nextinstr = nextinstr + 1;
		$$.loc = curr_st->lookup_2(*$1.name);
		nextinstr = nextinstr + 1;
		if($$.loc->tp_n != NULL && $$.loc->tp_n->basetp == tp_arr){
			//If arr1
			nextinstr = nextinstr + 1;
			$$.arr = $$.loc;
			nextinstr = nextinstr + 1;
			$$.loc = curr_st->gentemp(new type_n(tp_int));
			nextinstr = nextinstr + 1;
			$$.loc->i_val.int_val = 0;
			nextinstr = nextinstr + 1;
			$$.loc->isInitialized = true;
			nextinstr = nextinstr + 1;
			glob_quad.emit(Q_ASSIGN, 0, $$.loc->name);
			nextinstr = nextinstr + 1;
			$$.type = $$.arr->tp_n;
			nextinstr = nextinstr + 1;	
			$$.poss_array = $$.arr;
			nextinstr = nextinstr + 1;
		}
		else{
			//If not an arr1
			nextinstr = nextinstr + 1;
			$$.type = $$.loc->tp_n;
			nextinstr = nextinstr + 1;
			$$.arr = NULL;
			nextinstr = nextinstr + 1;	
			$$.isPointer = false;
			
		}
	}
	else{
		//It is a function
		nextinstr = nextinstr + 1;
		$$.loc = check_func;
		nextinstr = nextinstr + 1;	
		$$.type = check_func->tp_n;
		nextinstr = nextinstr + 1;
		$$.arr = NULL;
		nextinstr = nextinstr + 1;
		$$.isPointer = false;
		nextinstr = nextinstr + 1;	
	}
	} 
        
	|	INTEGER_CONSTANT {
	int nextinstr = 0;
	//Declare and initialize the value of the temporary variable with the integer
	$$.loc = curr_st->gentemp(new type_n(tp_int));
	nextinstr = nextinstr + 1;
	$$.type = $$.loc->tp_n;
	nextinstr = nextinstr + 1;
	$$.loc->i_val.int_val = $1;
	nextinstr = nextinstr + 1;
	$$.loc->isInitialized = true;
	nextinstr = nextinstr + 1;
	$$.arr = NULL;
	nextinstr = nextinstr + 1;
	glob_quad.emit(Q_ASSIGN, $1, $$.loc->name);
	}
        
	|	FLOATING_CONSTANT {
	// Declare and initialize the value of the temporary variable with the floatval
	int nextinstr = 0;		
	$$.loc = curr_st->gentemp(new type_n(tp_double));
	nextinstr = nextinstr + 1;
	$$.type = $$.loc->tp_n;
	nextinstr = nextinstr + 1;
	$$.loc->i_val.double_val = $1;
	nextinstr = nextinstr + 1;
	$$.loc->isInitialized = true;
	nextinstr = nextinstr + 1;
	$$.arr = NULL;
	nextinstr = nextinstr + 1;
	glob_quad.emit(Q_ASSIGN, $1, $$.loc->name);
	}
         
        |	CHAR_CONST {
	// Declare and initialize the value of the temporary variable with the character
	int nextinstr = 0;
	$$.loc = curr_st->gentemp(new type_n(tp_char));
	nextinstr = nextinstr + 1;
	$$.type = $$.loc->tp_n;
	nextinstr = nextinstr + 1;
	$$.loc->i_val.char_val = $1;
	nextinstr = nextinstr + 1;		
	$$.loc->isInitialized = true;
	nextinstr = nextinstr + 1;
	$$.arr = NULL;
	nextinstr = nextinstr + 1;
	glob_quad.emit(Q_ASSIGN, $1, $$.loc->name);
	}
	
        |	STRING_LITERAL {
	int nextinstr = 0;
	strings_label.push_back(*$1);
	nextinstr = nextinstr + 1;
	$$.loc = NULL;
	nextinstr = nextinstr + 1;
	$$.isString = true;
	nextinstr = nextinstr + 1;
	$$.ind_str = strings_label.size() - 1;
	nextinstr = nextinstr + 1;
	$$.arr = NULL;
	nextinstr = nextinstr + 1;						
	$$.isPointer = false;
	} 
	
	|	'(' expression ')' {
        $$ = $2;
        };

postfix_expression 
	:	primary_expression {
        $$ = $1;
        } 
        
        |	postfix_expression '[' expression ']' {
	//Explanation of arr1 handling
	int nextinstr = 0;
	$$.loc = curr_st->gentemp(new type_n(tp_int));
	nextinstr = nextinstr + 1;
	symdata* temporary = curr_st->gentemp(new type_n(tp_int));
	nextinstr = nextinstr + 1;
	char temp[10];
	nextinstr = nextinstr + 1;
	sprintf(temp, "%d", $1.type->next->getSize());
	nextinstr = nextinstr + 1;
	glob_quad.emit(Q_MULT, $3.loc->name, temp, temporary->name);
	nextinstr = nextinstr + 1;
	glob_quad.emit(Q_PLUS, $1.loc->name, temporary->name, $$.loc->name);
	nextinstr = nextinstr + 1;                                                                        
	//The new size will be calculated and the temporary variable storing the size will be passed on a $$.loc
	//$$.arr <= base pointer
	$$.arr = $1.arr;
	nextinstr = nextinstr + 1;                                
	//$$.type <= basetp(arr)
	$$.type = $1.type->next;
	nextinstr = nextinstr + 1;
	$$.poss_array = NULL;
	nextinstr = nextinstr + 1;
	//$$.arr->tp_n has the full type of the arr which will be used for size calculations
        } 
        
        |	postfix_expression '(' argument_expression_list_opt ')' {
	int nextinstr = 0;
	//Explanation of Function Handling
	if(!$1.isPointer && !$1.isString && ($1.type) && ($1.type->basetp == tp_void)){
		nextinstr = nextinstr + 1;
	}
	else		
		$$.loc = curr_st->gentemp(CopyType($1.type));
	//Temporary is created
	nextinstr = nextinstr + 1;	 
	char str[10];
	if($3.arguments == NULL){
		nextinstr = nextinstr + 1;
		//No function Parameters
		sprintf(str, "0");
		nextinstr = nextinstr + 1;
		if($1.type->basetp != tp_void){
			glob_quad.emit(Q_CALL, $1.loc->name, str, $$.loc->name);
			nextinstr = nextinstr + 1;
		}
		else{
			glob_quad.emit2(Q_CALL, $1.loc->name, str);
			nextinstr = nextinstr + 1;
		}
		nextinstr = nextinstr + 1;
	}
	else{
		nextinstr = nextinstr + 1;							
		if((*$3.arguments)[0]->isString){
			nextinstr = nextinstr + 1;	
		    	str[0] = '_';
			nextinstr = nextinstr + 1;
			sprintf(str+1, "%d", (*$3.arguments)[0]->ind_str);
			nextinstr = nextinstr + 1;
		    	glob_quad.emit(Q_PARAM, str);
		    	nextinstr = nextinstr + 1;
		    	glob_quad.emit(Q_CALL, $1.loc->name, "1", $$.loc->name);
		    	nextinstr = nextinstr + 1;
	    	}
		else{
			nextinstr = nextinstr + 1;					
		    	for(int i=0; i < $3.arguments->size(); i++){
		    		nextinstr = nextinstr + 1;
				//To print the parameters 
				if((*$3.arguments)[i]->poss_array != NULL && $1.loc->name != "printi")
			    		glob_quad.emit(Q_PARAM, (*$3.arguments)[i]->poss_array->name);
			    	else
			    		glob_quad.emit(Q_PARAM, (*$3.arguments)[i]->loc->name);
			}
			nextinstr = nextinstr + 1;		
		    	sprintf(str, "%ld", $3.arguments->size());
		    	nextinstr = nextinstr + 1;
		    	if($1.type->basetp != tp_void)
				glob_quad.emit(Q_CALL, $1.loc->name, str, $$.loc->name);
		    	else
				glob_quad.emit2(Q_CALL, $1.loc->name, str);
		}
	}
	nextinstr = nextinstr + 1;
	$$.arr = NULL;
	$$.type = $$.loc->tp_n;
        } 
        
        |	postfix_expression '.' IDENTIFIER {
        /*Struct Logic to be Skipped*/
        }
        
        |	postfix_expression POINTER IDENTIFIER {}                                                                         
                                                                      
	|	postfix_expression INCREMENT {	
	int nextinstr = 0;
	$$.loc = curr_st->gentemp(CopyType($1.type));
	nextinstr = nextinstr + 1;
	if($1.arr != NULL){
		nextinstr = nextinstr + 1;
		//Post increment of an arr1 element
		symdata * temp_elem = curr_st->gentemp(CopyType($1.type));
		nextinstr = nextinstr + 1;
		glob_quad.emit(Q_RINDEX, $1.arr->name, $1.loc->name, $$.loc->name);
		nextinstr = nextinstr + 1;
		glob_quad.emit(Q_RINDEX, $1.arr->name, $1.loc->name, temp_elem->name);
		nextinstr = nextinstr + 1;                                        
		glob_quad.emit(Q_PLUS, temp_elem->name, "1", temp_elem->name);
		nextinstr = nextinstr + 1;
		glob_quad.emit(Q_LINDEX, $1.loc->name, temp_elem->name, $1.arr->name);
		nextinstr = nextinstr + 1;
		$$.arr = NULL;
		nextinstr = nextinstr + 1;
	}
	else{
		nextinstr = nextinstr + 1;
		//Post increment of an simple element
		glob_quad.emit(Q_ASSIGN, $1.loc->name, $$.loc->name);		
		glob_quad.emit(Q_PLUS, $1.loc->name, "1", $1.loc->name);    
		nextinstr = nextinstr + 1;                                      
	}
	$$.type = $$.loc->tp_n; 
	}                                
         
        |	postfix_expression DECREMENT {
	int nextinstr = 0;
	$$.loc = curr_st->gentemp(CopyType($1.type));
	nextinstr = nextinstr + 1;
	if($1.arr != NULL){
		nextinstr = nextinstr + 1;
	    	//Post decrement of an arr1 element
		symdata * temp_elem = curr_st->gentemp(CopyType($1.type));
		glob_quad.emit(Q_RINDEX, $1.arr->name, $1.loc->name, $$.loc->name);
		glob_quad.emit(Q_RINDEX, $1.arr->name, $1.loc->name, temp_elem->name);
		glob_quad.emit(Q_MINUS, temp_elem->name, "1", temp_elem->name);
		glob_quad.emit(Q_LINDEX, $1.loc->name, temp_elem->name, $1.arr->name);
		$$.arr = NULL;
		nextinstr = nextinstr + 1;
	}
	else{
		nextinstr = nextinstr + 1;
		//Post decrement of an simple element
		glob_quad.emit(Q_ASSIGN, $1.loc->name, $$.loc->name);
		nextinstr = nextinstr + 1;
		glob_quad.emit(Q_MINUS, $1.loc->name, "1", $1.loc->name);
		nextinstr = nextinstr + 1;
	}
	$$.type = $$.loc->tp_n;
	nextinstr = nextinstr + 1;
        } 
        
        |	'(' type_name ')' '{' initializer_list '}' {}
                                                                                
        |	'(' type_name ')' '{' initializer_list ',' '}' {};
                                                                                    
                   
argument_expression_list
	:       assignment_expression {
	int nextinstr = 0;
        $$.arguments = new vector<expresn*>;
        nextinstr = nextinstr + 1;
        expresn * tex = new expresn($1);
        nextinstr = nextinstr + 1;
        $$.arguments->push_back(tex);
        nextinstr = nextinstr + 1;
        }
         
        |	argument_expression_list ',' assignment_expression {
        int nextinstr = 0;
        expresn * tex = new expresn($3);
        nextinstr = nextinstr + 1;
        $$.arguments->push_back(tex);
        nextinstr = nextinstr + 1;
        };

argument_expression_list_opt
	:	argument_expression_list {
	$$ = $1;
        }
        
        |	/*epsilon*/ {
	int nextinstr = 0;
        $$.arguments = NULL;
        nextinstr = nextinstr + 1;
        };

unary_expression
	:	postfix_expression {
        $$ = $1;
        }
        
        |	INCREMENT unary_expression {
        int nextinstr = 0;
        $$.loc = curr_st->gentemp($2.type);
        nextinstr = nextinstr + 1;
        if($2.arr != NULL){
        	//Pre increment of an arr1 element 
		symdata * temp_elem = curr_st->gentemp(CopyType($2.type));
		nextinstr = nextinstr + 1;
		glob_quad.emit(Q_RINDEX, $2.arr->name, $2.loc->name, temp_elem->name);
		nextinstr = nextinstr + 1;
		glob_quad.emit(Q_PLUS, temp_elem->name, "1", temp_elem->name);
		nextinstr = nextinstr + 1;
		glob_quad.emit(Q_LINDEX, $2.loc->name, temp_elem->name, $2.arr->name);
		nextinstr = nextinstr + 1;
		glob_quad.emit(Q_RINDEX, $2.arr->name, $2.loc->name, $$.loc->name);
		nextinstr = nextinstr + 1;
		$$.arr = NULL;
	}
        else{
		//Pre increment
		nextinstr = nextinstr + 1;
		glob_quad.emit(Q_PLUS, $2.loc->name, "1", $2.loc->name);
		nextinstr = nextinstr + 1;
		glob_quad.emit(Q_ASSIGN, $2.loc->name, $$.loc->name);
		nextinstr = nextinstr + 1;
        }
        $$.type = $$.loc->tp_n;
        nextinstr = nextinstr + 1;
        }
        
        |	DECREMENT unary_expression {
        int nextinstr = 0;
	$$.loc = curr_st->gentemp(CopyType($2.type));
	nextinstr = nextinstr + 1;
	if($2.arr != NULL){
		nextinstr = nextinstr + 1;
	    	//Pre decrement of  arr1 Element 
	    	symdata * temp_elem = curr_st->gentemp(CopyType($2.type));
	    	nextinstr = nextinstr + 1;
	    	glob_quad.emit(Q_RINDEX, $2.arr->name, $2.loc->name, temp_elem->name);
	    	nextinstr = nextinstr + 1;
	    	glob_quad.emit(Q_MINUS, temp_elem->name, "1", temp_elem->name);
	    	nextinstr = nextinstr + 1;
	    	glob_quad.emit(Q_LINDEX, $2.loc->name, temp_elem->name, $2.arr->name);
	    	nextinstr = nextinstr + 1;
	    	glob_quad.emit(Q_RINDEX, $2.arr->name, $2.loc->name, $$.loc->name);
	    	nextinstr = nextinstr + 1;
	    	$$.arr = NULL;
	}
	else{
		nextinstr = nextinstr + 1;
	    	//Pre decrement
	    	glob_quad.emit(Q_MINUS, $2.loc->name, "1", $2.loc->name);
	    	nextinstr = nextinstr + 1;
	    	glob_quad.emit(Q_ASSIGN, $2.loc->name, $$.loc->name);
	    	nextinstr = nextinstr + 1;
	}
	$$.type = $$.loc->tp_n;
	nextinstr = nextinstr + 1;
        }
        
        |	unary_operator cast_expression {
        int nextinstr = 0;
	type_n * temp_type;
	switch($1){
		case '&':
			//Create a temporary type store the type
			temp_type = new type_n(tp_ptr, 1, $2.type);
			nextinstr = nextinstr + 1;
			$$.loc = curr_st->gentemp(CopyType(temp_type));
			nextinstr = nextinstr + 1;
			$$.type = $$.loc->tp_n;
			nextinstr = nextinstr + 1;
			glob_quad.emit(Q_ADDR, $2.loc->name, $$.loc->name);
			nextinstr = nextinstr + 1;
			$$.arr = NULL;
			nextinstr = nextinstr + 1;
			break;
		    
		case '*':
			$$.isPointer = true;
			nextinstr = nextinstr + 1;
			$$.type = $2.loc->tp_n->next;
			nextinstr = nextinstr + 1;
			$$.loc = $2.loc;
			nextinstr = nextinstr + 1;
			$$.arr = NULL;
			nextinstr = nextinstr + 1;
			break;
			
		case '+':
			$$.loc = curr_st->gentemp(CopyType($2.type));
			nextinstr = nextinstr + 1;
			$$.type = $$.loc->tp_n;
			nextinstr = nextinstr + 1;
			glob_quad.emit(Q_ASSIGN, $2.loc->name, $$.loc->name);
			nextinstr = nextinstr + 1;
			break;
			
		case '-':
			$$.loc = curr_st->gentemp(CopyType($2.type));
			nextinstr = nextinstr + 1;
			$$.type = $$.loc->tp_n;
			nextinstr = nextinstr + 1;
			glob_quad.emit(Q_UNARY_MINUS, $2.loc->name, $$.loc->name);
			nextinstr = nextinstr + 1;
			break;
			
		case '~':
			/*Bitwise Not to be implemented Later on*/
			$$.loc = curr_st->gentemp(CopyType($2.type));
			nextinstr = nextinstr + 1;
			$$.type = $$.loc->tp_n;
			nextinstr = nextinstr + 1;
			glob_quad.emit(Q_NOT, $2.loc->name, $$.loc->name);
			nextinstr = nextinstr + 1;
			break;
			
		case '!':
			$$.loc = curr_st->gentemp(CopyType($2.type));
			nextinstr = nextinstr + 1;
			$$.type = $$.loc->tp_n;
			nextinstr = nextinstr + 1;
			$$.truelist = $2.falselist;
			nextinstr = nextinstr + 1;
			$$.falselist = $2.truelist;
			nextinstr = nextinstr + 1;
			break;
			
		default:
		    	break;
	}
        }
        
        |	SIZEOF unary_expression {}
        
        |	SIZEOF '(' type_name ')' {};

unary_operator  
	:	'&' {
        $$ = '&';
        }
        
        |	'*' {
        $$ = '*';
        }
        
        |	'+' {
        $$ = '+';
        }
        
        |	'-' {
        $$ = '-';
        }
        
        |	'~' {
        $$ = '~';
        }
        
        |	'!' {
        $$ = '!';
        };

cast_expression 
	:	unary_expression {
	int nextinstr = 0;
	if($1.arr != NULL && $1.arr->tp_n != NULL && $1.poss_array == NULL){
		nextinstr = nextinstr + 1;
		//Right Indexing of an arr1 element as unary expression is converted into cast expression
		$$.loc = curr_st->gentemp(new type_n($1.type->basetp));
		nextinstr = nextinstr + 1;
		glob_quad.emit(Q_RINDEX, $1.arr->name, $1.loc->name, $$.loc->name);
		nextinstr = nextinstr + 1;
		$$.arr = NULL;
		nextinstr = nextinstr + 1;
		$$.type = $$.loc->tp_n;
		nextinstr = nextinstr + 1;
		//$$.poss_array=$1.arr;
	}
	else if($1.isPointer == true){
		nextinstr = nextinstr + 1;
		//RDereferencing as its a pointer
		$$.loc = curr_st->gentemp(CopyType($1.type));
		nextinstr = nextinstr + 1;
		$$.isPointer = false;
		nextinstr = nextinstr + 1;
		glob_quad.emit(Q_RDEREF, $1.loc->name, $$.loc->name);
		nextinstr = nextinstr + 1;
	}
	else
		$$ = $1;
        }
        
        |	'(' type_name ')' cast_expression {};
                                                                    
multiplicative_expression
	:	cast_expression {
	$$ = $1;
        }
        
        |	multiplicative_expression '*' cast_expression {
        int nextinstr = 0;
        typecheck(&$1, &$3);
        nextinstr = nextinstr + 1;
        $$.loc = curr_st->gentemp($1.type);
        nextinstr = nextinstr + 1;
        $$.type = $$.loc->tp_n;
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_MULT, $1.loc->name, $3.loc->name, $$.loc->name);
        }
        
        |	multiplicative_expression '/' cast_expression {
        int nextinstr = 0;
        typecheck(&$1, &$3);
        nextinstr = nextinstr + 1;
        $$.loc = curr_st->gentemp($1.type);
        nextinstr = nextinstr + 1;
        $$.type = $$.loc->tp_n;
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_DIVIDE, $1.loc->name, $3.loc->name, $$.loc->name);
        nextinstr = nextinstr + 1;
        }
        
        |	multiplicative_expression '%' cast_expression {
        int nextinstr = 0;
        typecheck(&$1, &$3);
        nextinstr = nextinstr + 1;
        $$.loc = curr_st->gentemp($1.type);
        nextinstr = nextinstr + 1;
        $$.type = $$.loc->tp_n;
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_MODULO, $1.loc->name, $3.loc->name, $$.loc->name);
        nextinstr = nextinstr + 1;
        };

additive_expression 
	:	multiplicative_expression {
        $$ = $1;
        }
        
        |	additive_expression '+' multiplicative_expression {
        int nextinstr = 0;
        typecheck(&$1, &$3);
        nextinstr = nextinstr + 1;
        $$.loc = curr_st->gentemp($1.type);
        nextinstr = nextinstr + 1;
        $$.type = $$.loc->tp_n;
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_PLUS, $1.loc->name, $3.loc->name, $$.loc->name);
        nextinstr = nextinstr + 1;
        }
        
        |	additive_expression '-' multiplicative_expression {
        int nextinstr = 0;
        typecheck(&$1, &$3);
        nextinstr = nextinstr + 1;
        $$.loc = curr_st->gentemp($1.type);
        nextinstr = nextinstr + 1;
        $$.type = $$.loc->tp_n;
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_MINUS, $1.loc->name, $3.loc->name, $$.loc->name);
        nextinstr = nextinstr + 1;
        };

shift_expression
	:	additive_expression {
        $$ = $1;
        }
        
        |	shift_expression LEFT_SHIFT additive_expression {
        int nextinstr = 0;
        $$.loc = curr_st->gentemp($1.type);
        nextinstr = nextinstr + 1;
        $$.type = $$.loc->tp_n;
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_LEFT_OP, $1.loc->name, $3.loc->name, $$.loc->name);
        nextinstr = nextinstr + 1;
        }
        
        |	shift_expression RIGHT_SHIFT additive_expression {
        int nextinstr = 0;
        $$.loc = curr_st->gentemp($1.type);
        nextinstr = nextinstr + 1;
        $$.type = $$.loc->tp_n;
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_RIGHT_OP, $1.loc->name, $3.loc->name, $$.loc->name);
        nextinstr = nextinstr + 1;
        };

relational_expression
	:	shift_expression {
        $$ = $1;
        }
        
        |	relational_expression '<' shift_expression {
        int nextinstr = 0;
        typecheck(&$1, &$3);
        nextinstr = nextinstr + 1;
        $$.type = new type_n(tp_bool);
        nextinstr = nextinstr + 1;
        $$.truelist = makelist(next_instr);
        nextinstr = nextinstr + 1;
        $$.falselist = makelist(next_instr+1);
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_IF_LESS, $1.loc->name, $3.loc->name, "-1");
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_GOTO, "-1");
        nextinstr = nextinstr + 1;
        }
        
        |	relational_expression '>' shift_expression {
        int nextinstr = 0;
        typecheck(&$1, &$3);
        nextinstr = nextinstr + 1;
        $$.type = new type_n(tp_bool);
        nextinstr = nextinstr + 1;
        $$.truelist = makelist(next_instr);
        nextinstr = nextinstr + 1;
        $$.falselist = makelist(next_instr+1);
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_IF_GREATER, $1.loc->name, $3.loc->name, "-1");
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_GOTO, "-1");
        nextinstr = nextinstr + 1;
        }
        
        |	relational_expression LESS_EQUALS shift_expression {
        int nextinstr = 0;
        typecheck(&$1, &$3);
        nextinstr = nextinstr + 1;
        $$.type = new type_n(tp_bool);
        nextinstr = nextinstr + 1;
        $$.truelist = makelist(next_instr);
        nextinstr = nextinstr + 1;
        $$.falselist = makelist(next_instr+1);
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_IF_LESS_OR_EQUAL, $1.loc->name, $3.loc->name, "-1");
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_GOTO, "-1");
        nextinstr = nextinstr + 1;
        }
        
        |	relational_expression GREATER_EQUALS shift_expression {
        int nextinstr = 0;
        typecheck(&$1, &$3);
        nextinstr = nextinstr + 1;
        $$.type = new type_n(tp_bool);
        nextinstr = nextinstr + 1;
        $$.truelist = makelist(next_instr);
        nextinstr = nextinstr + 1;
        $$.falselist = makelist(next_instr+1);
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_IF_GREATER_OR_EQUAL, $1.loc->name, $3.loc->name, "-1");
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_GOTO, "-1");
        };

equality_expression
	:	relational_expression {
        $$ = $1;
        }
        
        |	equality_expression EQUALS relational_expression {
        int nextinstr = 0;
        typecheck(&$1, &$3);
        nextinstr = nextinstr + 1;
        $$.type = new type_n(tp_bool);
        nextinstr = nextinstr + 1;
        $$.truelist = makelist(next_instr);
        nextinstr = nextinstr + 1;
        $$.falselist = makelist(next_instr+1);
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_IF_EQUAL, $1.loc->name, $3.loc->name, "-1");
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_GOTO, "-1");
        nextinstr = nextinstr + 1;
        }
        
        |	equality_expression NOT_EQUALS relational_expression {
        int nextinstr = 0;
        typecheck(&$1, &$3);
        nextinstr = nextinstr + 1;
        $$.type = new type_n(tp_bool);
        nextinstr = nextinstr + 1;
        $$.truelist = makelist(next_instr);
        nextinstr = nextinstr + 1;
        $$.falselist = makelist(next_instr+1);
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_IF_NOT_EQUAL, $1.loc->name, $3.loc->name, "-1");
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_GOTO, "-1");
        };

AND_expression 
	:	equality_expression {
        $$ = $1;
        }
        
        |	AND_expression '&' equality_expression {
        int nextinstr = 0;
        $$.loc = curr_st->gentemp($1.type);
        nextinstr = nextinstr + 1;
        $$.type = $$.loc->tp_n;
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_LOG_AND, $1.loc->name, $3.loc->name, $$.loc->name);
        nextinstr = nextinstr + 1;
        };

exclusive_OR_expression
	:	AND_expression {
        $$ = $1;
        }
        
        |	exclusive_OR_expression '^' AND_expression {
        $$.loc = curr_st->gentemp($1.type);
        $$.type = $$.loc->tp_n;
        glob_quad.emit(Q_XOR, $1.loc->name, $3.loc->name, $$.loc->name);
        };

inclusive_OR_expression
	:	exclusive_OR_expression {
        $$ = $1;
        }
        
        |	inclusive_OR_expression '|' exclusive_OR_expression {
        int nextinstr = 0;
        $$.loc = curr_st->gentemp($1.type);
        nextinstr = nextinstr + 1;
        $$.type = $$.loc->tp_n;
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_LOG_OR, $1.loc->name, $3.loc->name, $$.loc->name);
        nextinstr = nextinstr + 1;
        };

logical_AND_expression
	:	inclusive_OR_expression {
        $$ = $1;
        }
        
        |	logical_AND_expression AND M inclusive_OR_expression {
        int nextinstr = 0;
        if($1.type->basetp != tp_bool)
        	conv2Bool(&$1);
	nextinstr = nextinstr + 1;			
        if($4.type->basetp != tp_bool)
		conv2Bool(&$4);
	nextinstr = nextinstr + 1;			
	backpatch($1.truelist, $3);
	nextinstr = nextinstr + 1;
	$$.type = new type_n(tp_bool);
	nextinstr = nextinstr + 1;
	$$.falselist = merge($1.falselist, $4.falselist);
	nextinstr = nextinstr + 1;
	$$.truelist = $4.truelist;
	nextinstr = nextinstr + 1;
	};
	
logical_OR_expression
	:	logical_AND_expression {
        $$ = $1;
        }
        
        |	logical_OR_expression OR M logical_AND_expression  {
        int nextinstr = 0;
        if($1.type->basetp != tp_bool)
        	conv2Bool(&$1);
	nextinstr = nextinstr + 1;
	if($4.type->basetp != tp_bool)
		conv2Bool(&$4);
	nextinstr = nextinstr + 1; 
	backpatch($1.falselist, $3);
	nextinstr = nextinstr + 1;
	$$.type = new type_n(tp_bool);
	nextinstr = nextinstr + 1;
	$$.truelist = merge($1.truelist, $4.truelist);
	nextinstr = nextinstr + 1;
	$$.falselist = $4.falselist;
	nextinstr = nextinstr + 1;
	};

/*It is assumed that type of expression and conditional expression are same*/

conditional_expression
	:	logical_OR_expression {
	$$ = $1;
        }
        
        |	logical_OR_expression N '?' M expression N ':' M conditional_expression {
        int nextinstr = 0;
        $$.loc = curr_st->gentemp($5.type);
        nextinstr = nextinstr + 1;
        $$.type = $$.loc->tp_n;
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_ASSIGN, $9.loc->name, $$.loc->name);
        nextinstr = nextinstr + 1;
        list* TEMP_LIST = makelist(next_instr);
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_GOTO, "-1");
        nextinstr = nextinstr + 1;
        backpatch($6, next_instr);
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_ASSIGN, $5.loc->name, $$.loc->name);
        nextinstr = nextinstr + 1;
        TEMP_LIST = merge(TEMP_LIST, makelist(next_instr));
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_GOTO, "-1");
        nextinstr = nextinstr + 1;
        backpatch($2, next_instr);
        nextinstr = nextinstr + 1;
        conv2Bool(&$1);
        nextinstr = nextinstr + 1;
        backpatch($1.truelist, $4);
        nextinstr = nextinstr + 1;
        backpatch($1.falselist, $8);
        nextinstr = nextinstr + 1;
        backpatch(TEMP_LIST, next_instr);
        };

assignment_operator
	:	'='  
	|	MULTIPLY_ASSIGN
	|	DIVIDE_ASSIGN
	|	MODULO_ASSIGN
	|	ADD_ASSIGN
	|	SUBTRACT_ASSIGN
	|	LEFT_SHIFT_ASSIGN
	|	RIGHT_SHIFT_ASSIGN
	|	AND_ASSIGN
	|	XOR_ASSIGN
	|	OR_ASSIGN
	;

assignment_expression
	:	conditional_expression {
        $$ = $1;
        }
        
        |	unary_expression assignment_operator assignment_expression {
        int nextinstr = 0;
	//LDereferencing
	if($1.isPointer){
		nextinstr = nextinstr + 1;
	    	glob_quad.emit(Q_LDEREF, $3.loc->name, $1.loc->name);
	    	nextinstr = nextinstr + 1;
	}
	typecheck(&$1, &$3, true);
	nextinstr = nextinstr + 1;
	if($1.arr != NULL){
		nextinstr = nextinstr + 1;
	    	glob_quad.emit(Q_LINDEX, $1.loc->name, $3.loc->name, $1.arr->name);
	    	nextinstr = nextinstr + 1;
	}
	else if(!$1.isPointer){
	    	glob_quad.emit(Q_ASSIGN, $3.loc->name, $1.loc->name);
	    	nextinstr = nextinstr + 1;
    	}
	$$.loc = curr_st->gentemp($3.type);
	nextinstr = nextinstr + 1;
	$$.type = $$.loc->tp_n;
	nextinstr = nextinstr + 1;
	glob_quad.emit(Q_ASSIGN, $3.loc->name, $$.loc->name);
	nextinstr = nextinstr + 1;
	};

/*A constant value of this expression exists*/

constant_expression
	:	conditional_expression {
        $$ = $1;
        };

expression 
	:	assignment_expression {
        $$ = $1;
        }
        
        |	expression ',' assignment_expression {
        $$ = $3;
        };

/*Declarations*/ 

declaration
	:	declaration_specifiers init_declarator_list_opt ';' {
	int nextinstr = 0;
        if($2.loc != NULL && $2.type != NULL && $2.type->basetp == tp_func){
        	nextinstr = nextinstr + 1;
            	/*Delete curr_st*/
            	curr_st = new symtab();
        }
        };

init_declarator_list_opt
	:	init_declarator_list {
	int nextinstr = 0;
        if($1.type != NULL && $1.type->basetp == tp_func){
                nextinstr = nextinstr + 1;
                $$ = $1;
        }
        nextinstr = nextinstr + 1;
        }
        
        |	/*epsilon*/ {
        	cout<<"";
		$$.loc = NULL;
		cout<<"";
        };

declaration_specifiers
	:	storage_class_specifier declaration_specifiers_opt {}
	|	type_specifier declaration_specifiers_opt {}               
	|	type_qualifier declaration_specifiers_opt {}
	|	function_specifier declaration_specifiers_opt {}
	;

declaration_specifiers_opt
	:	declaration_specifiers                                  
	|	/*epsilon*/                                             
	;
	
init_declarator_list
	:	init_declarator {
        /*Expecting only function declaration*/
        $$ = $1;
        }
        
        |	init_declarator_list ',' init_declarator                
        ;

init_declarator
	:	declarator {
	int nextinstr = 0;
        if($1.type != NULL && $1.type->basetp == tp_func){
        	nextinstr = nextinstr + 1;
		$$ = $1;
        }
        nextinstr = nextinstr + 1;
        }
        
        |	declarator '=' initializer {
        int nextinstr = 0;
	//Initializations of declarators
	if($3.type != NULL){
		nextinstr = nextinstr + 1;
		if($3.type->basetp == tp_int){
			nextinstr = nextinstr + 1;
			$1.loc->i_val.int_val = $3.loc->i_val.int_val;
			nextinstr = nextinstr + 1;
			$1.loc->isInitialized = true;
			nextinstr = nextinstr + 1;
			symdata *temp_ver = curr_st->search($1.loc->name);
			nextinstr = nextinstr + 1;
			if(temp_ver != NULL){
				nextinstr = nextinstr + 1;
				temp_ver->i_val.int_val = $3.loc->i_val.int_val;
				nextinstr = nextinstr + 1;
				temp_ver->isInitialized = true;
				nextinstr = nextinstr + 1;
	    		}
		}
		else if($3.type->basetp == tp_char){
			nextinstr = nextinstr + 1;
	    		$1.loc->i_val.char_val = $3.loc->i_val.char_val;
	    		nextinstr = nextinstr + 1;
			$1.loc->isInitialized = true;
			nextinstr = nextinstr + 1;
			symdata *temp_ver = curr_st->search($1.loc->name);
			nextinstr = nextinstr + 1;
			if(temp_ver != NULL){
				temp_ver->i_val.char_val = $3.loc->i_val.char_val;
				nextinstr = nextinstr + 1;
				temp_ver->isInitialized = true;
				nextinstr = nextinstr + 1;
			}
		}
	}
	glob_quad.emit(Q_ASSIGN, $3.loc->name, $1.loc->name);
        };

storage_class_specifier
	:	EXTERN {}
	|	STATIC {}
        ;

type_specifier
	:	VOID {
        glob_type = new type_n(tp_void);
        }
        
        |	CHAR {
        glob_type = new type_n(tp_char);
        }
        
        |	SHORT {}
        
        |	INT {
        glob_type = new type_n(tp_int);
        }
        
        |	LONG {}
        
        |	FLOAT {}
        
        |	DOUBLE {
        glob_type = new type_n(tp_double);
        };
        

specifier_qualifier_list
	:	type_specifier specifier_qualifier_list_opt {}
        |	type_qualifier specifier_qualifier_list_opt {}; 

specifier_qualifier_list_opt
	:	specifier_qualifier_list {}
	|	/*epsilon*/ {};

type_qualifier
	:	CONST {}
	|	RESTRICT {}
	|	VOLATILE {};

function_specifier
	:	INLINE {};

declarator 
	:	pointer_opt direct_declarator {
	int nextinstr = 0;
	if($1.type == NULL){
		/*--------------*/
	}
	else{
		nextinstr = nextinstr + 1;
		if($2.loc->tp_n->basetp != tp_ptr){
			nextinstr = nextinstr + 1;
			type_n * test = $1.type;
			nextinstr = nextinstr + 1;
			while(test->next != NULL){
				test = test->next;
				nextinstr = nextinstr + 1;
			}
			test->next = $2.loc->tp_n;
			nextinstr = nextinstr + 1;
			$2.loc->tp_n = $1.type;
			nextinstr = nextinstr + 1;
		}
	}

	if($2.type != NULL && $2.type->basetp == tp_func){
		$$ = $2;
		nextinstr = nextinstr + 1;
	}
	else{
		//Its not a function
		$2.loc->size = $2.loc->tp_n->getSize();
		nextinstr = nextinstr + 1;
		$2.loc->offset = curr_st->offset;
		nextinstr = nextinstr + 1;
		curr_st->offset += $2.loc->size;
		nextinstr = nextinstr + 1;
		$$ = $2;
		nextinstr = nextinstr + 1;
		$$.type = $$.loc->tp_n;
		nextinstr = nextinstr + 1;
	}
        };

pointer_opt
	:	pointer {
        $$ = $1;
        cout << "";
        }
        
        |	/*epsilon*/ {
        $$.type = NULL;
        cout << "";
        };

direct_declarator
	:	IDENTIFIER {
	int nextinstr = 0;
        $$.loc = curr_st->lookup(*$1.name);
        nextinstr = nextinstr + 1;
	if($$.loc->var_type == ""){
		nextinstr = nextinstr + 1;
		//Type initialization
		$$.loc->var_type = "local";
		nextinstr = nextinstr + 1;
		$$.loc->tp_n = new type_n(glob_type->basetp);
		nextinstr = nextinstr + 1;
	}
        $$.type = $$.loc->tp_n;
        nextinstr = nextinstr + 1;
        }
        
        |	'(' declarator ')' {
        $$ = $2;
        cout << "";
        }
        
        |	direct_declarator '[' type_qualifier_list_opt assignment_expression_opt ']' {
        int nextinstr = 0;
	if($1.type->basetp == tp_arr){
		nextinstr = nextinstr + 1;
		/*If type is already an arr*/
		type_n * typ1 = $1.type, *typ = $1.type;
		nextinstr = nextinstr + 1;
		typ1 = typ1->next;
		nextinstr = nextinstr + 1;
		while(typ1->next != NULL){
			typ1 = typ1->next;
			nextinstr = nextinstr + 1;
			typ = typ->next;
			nextinstr = nextinstr + 1;
		}
		typ->next = new type_n(tp_arr, $4.loc->i_val.int_val, typ1);
		nextinstr = nextinstr + 1;
	}
	else{
		//Add the type of arr1 to list
	        if($4.loc == NULL){
			$1.type = new type_n(tp_arr, -1, $1.type);
			nextinstr = nextinstr + 1;
		}
	    	else{
			$1.type = new type_n(tp_arr, $4.loc->i_val.int_val, $1.type);
			nextinstr = nextinstr + 1;
		}
	}
	$$ = $1;
	nextinstr = nextinstr + 1;
	$$.loc->tp_n = $$.type;
	}
	
	|	direct_declarator '[' STATIC type_qualifier_list_opt assignment_expression ']' {}
	
	|	direct_declarator '[' type_qualifier_list STATIC assignment_expression ']' {}
	
	|	direct_declarator '[' type_qualifier_list_opt '*' ']' {}
	
	|	direct_declarator '(' parameter_type_list ')' {
	int nextinstr = 0;
	int params_no = curr_st->no_params;
	nextinstr = nextinstr + 1;
	curr_st->no_params = 0;
	nextinstr = nextinstr + 1;
	int dec_params = 0;
	nextinstr = nextinstr + 1;
	int over_params = params_no;
	nextinstr = nextinstr + 1;
	for(int i = curr_st->symbol_tab.size()-1; i >= 0; i--){
		nextinstr = nextinstr + 1;
	}
	for(int i = curr_st->symbol_tab.size()-1; i >= 0; i--){
		nextinstr = nextinstr + 1;
		string detect = curr_st->symbol_tab[i]->name;
		if(over_params == 0){
			break;
		}
		if(detect.size() == 4){
			nextinstr = nextinstr + 1;
		    	if(detect[0] == 't'){
		    		nextinstr = nextinstr + 1;
				if('0' <= detect[1] && detect[1] <= '9'){
					nextinstr = nextinstr + 1;
					if('0' <= detect[2] && detect[2] <= '9'){
						nextinstr = nextinstr + 1;
						if('0' <= detect[3] && detect[3] <= '9')
					    		dec_params++;
					    	nextinstr = nextinstr + 1;
					}
				}
		 	}
		}
		else
			over_params--;
	}
	params_no += dec_params;
	nextinstr = nextinstr + 1;
	int temp_i = curr_st->symbol_tab.size() - params_no;
	nextinstr = nextinstr + 1;
	symdata * new_func = glob_st->search(curr_st->symbol_tab[temp_i-1]->name);
	nextinstr = nextinstr + 1;
	if(new_func == NULL){
		nextinstr = nextinstr + 1;
		new_func = glob_st->lookup(curr_st->symbol_tab[temp_i-1]->name);
		nextinstr = nextinstr + 1;
		$$.loc = curr_st->symbol_tab[temp_i-1];
		nextinstr = nextinstr + 1;
		for(int i = 0;i < (temp_i-1); i++){
			nextinstr = nextinstr + 1;
			curr_st->symbol_tab[i]->ispresent = false;
			nextinstr = nextinstr + 1;
			if(curr_st->symbol_tab[i]->var_type == "local" || curr_st->symbol_tab[i]->var_type == "temp"){
				symdata *glob_var = glob_st->search(curr_st->symbol_tab[i]->name);
				nextinstr = nextinstr + 1;
				if(glob_var == NULL){
					nextinstr = nextinstr + 1;
					glob_var = glob_st->lookup(curr_st->symbol_tab[i]->name);
					nextinstr = nextinstr + 1;
					int t_size = curr_st->symbol_tab[i]->tp_n->getSize();
					glob_var->offset = glob_st->offset;
					nextinstr = nextinstr + 1;
					glob_var->size = t_size;
					nextinstr = nextinstr + 1;
					glob_st->offset += t_size;
					nextinstr = nextinstr + 1;
					glob_var->nest_tab = glob_st;
					nextinstr = nextinstr + 1;
					glob_var->var_type = curr_st->symbol_tab[i]->var_type;
					nextinstr = nextinstr + 1;
					glob_var->tp_n = curr_st->symbol_tab[i]->tp_n;
					nextinstr = nextinstr + 1;
					if(curr_st->symbol_tab[i]->isInitialized){
						glob_var->isInitialized = curr_st->symbol_tab[i]->isInitialized;
						nextinstr = nextinstr + 1;
						glob_var->i_val = curr_st->symbol_tab[i]->i_val;
						nextinstr = nextinstr + 1;
					}
				}
			}
		}
		if(new_func->var_type == ""){
			nextinstr = nextinstr + 1;
			//Declaration of the function for the first time
			new_func->tp_n = CopyType(curr_st->symbol_tab[temp_i-1]->tp_n);
			nextinstr = nextinstr + 1;
			new_func->var_type = "func";
			nextinstr = nextinstr + 1;
			new_func->isInitialized = false;
			nextinstr = nextinstr + 1;
			new_func->nest_tab = curr_st;
			nextinstr = nextinstr + 1;
			curr_st->name = curr_st->symbol_tab[temp_i-1]->name;
			nextinstr = nextinstr + 1;
			curr_st->symbol_tab[temp_i-1]->name = "retVal";
			nextinstr = nextinstr + 1;
			curr_st->symbol_tab[temp_i-1]->var_type = "return";
			nextinstr = nextinstr + 1;
			curr_st->symbol_tab[temp_i-1]->size = curr_st->symbol_tab[temp_i-1]->tp_n->getSize();
			nextinstr = nextinstr + 1;
			curr_st->symbol_tab[temp_i-1]->offset = 0;
			nextinstr = nextinstr + 1;
			curr_st->offset = 16;
			nextinstr = nextinstr + 1;
			int count = 0;
			for(int i = (curr_st->symbol_tab.size())-params_no; i < curr_st->symbol_tab.size(); i++){
				nextinstr = nextinstr + 1;
				curr_st->symbol_tab[i]->var_type = "param";
				nextinstr = nextinstr + 1;
				curr_st->symbol_tab[i]->offset = count - curr_st->symbol_tab[i]->size;
				nextinstr = nextinstr + 1;
				count = count-curr_st->symbol_tab[i]->size;
				nextinstr = nextinstr + 1;
			}
		}
	}
	else{
		nextinstr = nextinstr + 1;
		curr_st = new_func->nest_tab;
		nextinstr = nextinstr + 1;
	}
	curr_st->start_quad = next_instr;
	nextinstr = nextinstr + 1;
	$$.loc = new_func;
	nextinstr = nextinstr + 1;
	$$.type = new type_n(tp_func);
	nextinstr = nextinstr + 1;
	}
	
	|	direct_declarator '(' identifier_list_opt ')' {
	int nextinstr = 0;
	int temp_i = curr_st->symbol_tab.size();
	nextinstr = nextinstr + 1;
	symdata * new_func = glob_st->search(curr_st->symbol_tab[temp_i-1]->name);
	nextinstr = nextinstr + 1;
	if(new_func == NULL){
		nextinstr = nextinstr + 1;
		new_func = glob_st->lookup(curr_st->symbol_tab[temp_i-1]->name);
		nextinstr = nextinstr + 1;
		$$.loc = curr_st->symbol_tab[temp_i-1];
		nextinstr = nextinstr + 1;
		for(int i = 0;i < temp_i-1; i++){
			nextinstr = nextinstr + 1;
			curr_st->symbol_tab[i]->ispresent = false;
			nextinstr = nextinstr + 1;
			if(curr_st->symbol_tab[i]->var_type == "local" || curr_st->symbol_tab[i]->var_type == "temp"){
				nextinstr = nextinstr + 1;
			    	symdata *glob_var = glob_st->search(curr_st->symbol_tab[i]->name);
			    	nextinstr = nextinstr + 1;
				if(glob_var==NULL){
					nextinstr = nextinstr + 1;
					glob_var = glob_st->lookup(curr_st->symbol_tab[i]->name);
					nextinstr = nextinstr + 1;
					int t_size = curr_st->symbol_tab[i]->tp_n->getSize();
					nextinstr = nextinstr + 1;
					glob_var->offset = glob_st->offset;
					nextinstr = nextinstr + 1;
					glob_var->size = t_size;
					nextinstr = nextinstr + 1;
					glob_st->offset += t_size;
					nextinstr = nextinstr + 1;
					glob_var->nest_tab = glob_st;
					nextinstr = nextinstr + 1;
					glob_var->var_type = curr_st->symbol_tab[i]->var_type;
					nextinstr = nextinstr + 1;
					glob_var->tp_n = curr_st->symbol_tab[i]->tp_n;
					nextinstr = nextinstr + 1;
					if(curr_st->symbol_tab[i]->isInitialized){
						nextinstr = nextinstr + 1;
					    	glob_var->isInitialized = curr_st->symbol_tab[i]->isInitialized;
					    	nextinstr = nextinstr + 1;
					    	glob_var->i_val = curr_st->symbol_tab[i]->i_val;
					    	nextinstr = nextinstr + 1;
					}
				}
			}
		}
		if(new_func->var_type == ""){
			nextinstr = nextinstr + 1;
			/*Function is being declared here for the first time*/
			new_func->tp_n = CopyType(curr_st->symbol_tab[temp_i-1]->tp_n);
			nextinstr = nextinstr + 1;
			new_func->var_type = "func";
			nextinstr = nextinstr + 1;
			new_func->isInitialized = false;
			nextinstr = nextinstr + 1;
			new_func->nest_tab = curr_st;
			nextinstr = nextinstr + 1;
			/*Change the first element to retval and change the rest to param*/
			curr_st->name = curr_st->symbol_tab[temp_i-1]->name;
			nextinstr = nextinstr + 1;
			curr_st->symbol_tab[temp_i-1]->name = "retVal";
			nextinstr = nextinstr + 1;
			curr_st->symbol_tab[temp_i-1]->var_type = "return";
			nextinstr = nextinstr + 1;
			curr_st->symbol_tab[temp_i-1]->size = curr_st->symbol_tab[0]->tp_n->getSize();
			nextinstr = nextinstr + 1;
			curr_st->symbol_tab[temp_i-1]->offset = 0;
			nextinstr = nextinstr + 1;
			curr_st->offset = 16;
		}
	}
	else{
		nextinstr = nextinstr + 1;
	    	/*Already declared function. Therefore drop the new table and connect current symbol table pointer to the previously created function symbol table*/
	    	curr_st = new_func->nest_tab;
	}
	curr_st->start_quad = next_instr;
	nextinstr = nextinstr + 1;
	$$.loc = new_func;
	nextinstr = nextinstr + 1;
	$$.type = new type_n(tp_func);
	nextinstr = nextinstr + 1;
	};

type_qualifier_list_opt
	:	type_qualifier_list {}
	
	|	/*epsilon*/ {};

assignment_expression_opt
	:	assignment_expression {
        $$ = $1;
        }
        
        |	/*epsilon*/ {
        $$.loc = NULL;
        };

identifier_list_opt
	:	identifier_list                                         
	
	|	/*epsilon*/                                             
	;

pointer
	:	'*' type_qualifier_list_opt {
        $$.type = new type_n(tp_ptr);
        }
        
        |	'*' type_qualifier_list_opt pointer {
        $$.type = new type_n(tp_ptr,1,$3.type);
        };

type_qualifier_list
	:	type_qualifier {}
	
	|	type_qualifier_list type_qualifier {};

parameter_type_list
	:	parameter_list {
        /*-------*/
        }
        
        |	parameter_list ',' ELLIPSIS {};

parameter_list
	:	parameter_declaration {
        (curr_st->no_params)++;
        }
        
        |	parameter_list ',' parameter_declaration {
        (curr_st->no_params)++;
        };

parameter_declaration
	:	declaration_specifiers declarator {
        /*The parameter is already added to the current Symbol Table*/
        }
        
        |	declaration_specifiers {};

identifier_list 
	:	IDENTIFIER                                              
	
	|	identifier_list ',' IDENTIFIER                          
	;

type_name
	:	specifier_qualifier_list                                
	;

initializer
	:	assignment_expression {
        $$ = $1;
        }
        
        |	'{' initializer_list '}' {}
        
        |	'{' initializer_list ',' '}' {};

initializer_list
	:	designation_opt initializer                             
	
	|	initializer_list ',' designation_opt initializer       
	;                                                                                                                           

designation_opt
	:	designation                                             
	
	|	/*Epslion*/                                             
	;

designation
	:	designator_list '='                                     
	;

designator_list
	:	designator                                              
	
	|	designator_list designator                              
	;

designator
	:	'[' constant_expression ']'                             
	
	|	'.' IDENTIFIER {};

/*Statements*/

statement
	:	labeled_statement {
	/*Switch Case*/
	}
	
	|	compound_statement {
        $$ = $1;
        }
        
        |	expression_statement {
        $$ = NULL;
        }
        
        |	selection_statement {
        $$ = $1;
        }
        
        |	iteration_statement {
        $$ = $1;
        }
        
        |	jump_statement {
        $$ = $1;
        };

labeled_statement
	:	IDENTIFIER ':' statement {}
	
	|	CASE constant_expression ':' statement {}
	
	|	DEFAULT ':' statement {}
	;

compound_statement
	:	'{' block_item_list_opt '}' {
        $$ = $2;
        };

block_item_list_opt
	:	block_item_list {
        $$ = $1;
        }
        
        |	/*Epsilon*/ {
        $$ = NULL;
        };

block_item_list
	:	block_item {
        $$ = $1;
        }
        
        |	block_item_list M block_item {
        cout<<"";
        backpatch($1,$2);
        $$ = $3;
        };

block_item
	:	declaration {
        $$ = NULL;
        }
        
        |	statement {
        $$ = $1;
        }
        ;

expression_statement
	:	expression_opt ';'{
        $$ = $1;
        };

expression_opt
	:	expression {
        $$ = $1;
        }
        
        |	/*Epsilon*/ {
        cout << "";
        /*Initialize Expression to NULL*/
        $$.loc = NULL;
        };

selection_statement
	:	IF '(' expression N ')' M statement N ELSE M statement {
	int nextinstr = 0;
	/*N1 is used for falselist of expression, M1 is used for truelist of expression, N2 is used to prevent fall through, M2 is used for falselist of expression*/
	$7 = merge($7, $8);
	nextinstr = nextinstr + 1;
	$11 = merge($11, makelist(next_instr));
	nextinstr = nextinstr + 1;
	glob_quad.emit(Q_GOTO, "-1");
	nextinstr = nextinstr + 1;
	backpatch($4, next_instr);
	nextinstr = nextinstr + 1;
	conv2Bool(&$3);
	nextinstr = nextinstr + 1;
	backpatch($3.truelist, $6);
	nextinstr = nextinstr + 1;
	backpatch($3.falselist, $10);
	nextinstr = nextinstr + 1;
	$$ = merge($7, $11);
	nextinstr = nextinstr + 1;
	}
	
	|	IF '(' expression N ')' M statement %prec IF_CONFLICT {
	int nextinstr = 0;
        /*N is used for the falselist of expression to skip the block and M is used for truelist of expression*/
        $7 = merge($7, makelist(next_instr));
        nextinstr = nextinstr + 1;
        glob_quad.emit(Q_GOTO, "-1");
        nextinstr = nextinstr + 1;
        backpatch($4, next_instr);
        nextinstr = nextinstr + 1;
        conv2Bool(&$3);
        nextinstr = nextinstr + 1;
        backpatch($3.truelist, $6);
        nextinstr = nextinstr + 1;
        $$ = merge($7, $3.falselist);
        nextinstr = nextinstr + 1;
        }
        
        |	SWITCH '(' expression ')' statement {};

iteration_statement
	:	WHILE '(' M expression N ')' M statement {
	int nextinstr = 0;
	/*The first 'M' takes into consideration that the control will come again at the beginning of the condition checking.'N' here does the work of breaking condition i.e. it generate goto which wii be useful when we are exiting from while loop. Finally, the last 'M' is here to note the startinf statement that will be executed in every loop to populate the truelists of expression*/
	glob_quad.emit(Q_GOTO, $3);
	nextinstr = nextinstr + 1;
	backpatch($8, $3);
	nextinstr = nextinstr + 1;		/*S.nextlist to M1.instr*/
	backpatch($5, next_instr);		/*N1.nextlist to next_instr*/
	nextinstr = nextinstr + 1;    
	conv2Bool(&$4);
	nextinstr = nextinstr + 1;
	backpatch($4.truelist, $7);
	nextinstr = nextinstr + 1;
	$$ = $4.falselist;
	nextinstr = nextinstr + 1;
	}
	
	|	DO M statement  WHILE '(' M expression N ')' ';' {  
	int nextinstr = 0;
	/*M1 is used for coming back again to the statement as it stores the instruction which will be needed by the truelist of expression. M2 is neede as we have to again to check the condition which will be used to populate the nextlist of statements. Further N is used to prevent from fall through*/
	backpatch($8, next_instr);
	nextinstr = nextinstr + 1;
	backpatch($3, $6);			/*S1.nextlist to M2.instr*/
	conv2Bool(&$7);
	nextinstr = nextinstr + 1;
	backpatch($7.truelist, $2);		/*B.truelist to M1.instr*/
	$$ = $7.falselist;
	nextinstr = nextinstr + 1;
	}
	
	|	FOR '(' expression_opt ';' M expression_opt N ';' M expression_opt N ')' M statement {
	int nextinstr = 0;
	/*M1 is used for coming back to check the epression at every iteration. N1 is used  for generating the goto which will be used for exit conditions. M2 is used for nextlist of statement and N2 is used for jump to check the expression and M3 is used for the truelist of expression*/
	backpatch($11, $5);			/*N2.nextlist to M1.instr*/
	backpatch($14, $9);			/*S.nextlist to M2.instr*/
	glob_quad.emit(Q_GOTO, $9);
	backpatch($7, next_instr);		/*N1.nextlist to next_instr*/
	conv2Bool(&$6);
	nextinstr = nextinstr + 1;
	backpatch($6.truelist, $13);
	nextinstr = nextinstr + 1;
	$$ = $6.falselist;
	nextinstr = nextinstr + 1;
	}
	
	|	FOR '(' declaration expression_opt ';' expression_opt ')' statement {};

jump_statement
	:	GOTO IDENTIFIER ';' {}
	
	|	CONTINUE ';' {}
	
	|	BREAK ';' {}
	
	|	RETURN expression_opt ';' {
	int nextinstr = 0;
        if($2.loc == NULL)
		glob_quad.emit(Q_RETURN);
        else{
        	nextinstr = nextinstr + 1;
		expresn * dummy = new expresn();
		nextinstr = nextinstr + 1;
		dummy->loc = curr_st->symbol_tab[0];
		nextinstr = nextinstr + 1;
		dummy->type = dummy->loc->tp_n;
		nextinstr = nextinstr + 1;
		typecheck(dummy, &$2, true);
		nextinstr = nextinstr + 1;
		delete dummy;
		nextinstr = nextinstr + 1;
		glob_quad.emit(Q_RETURN, $2.loc->name);
        }
        $$ = NULL;
        };

/*External Definitions*/

translation_unit
	:	external_declaration                                    
	
	|	translation_unit external_declaration                   
	;

external_declaration
	:	function_definition                                     
	
	|	declaration {
	int nextinstr = 0;
	for(int i = 0; i < curr_st->symbol_tab.size(); i++){
		nextinstr = nextinstr + 1;
		if(curr_st->symbol_tab[i]->nest_tab == NULL){
			nextinstr = nextinstr + 1;
			if(curr_st->symbol_tab[i]->var_type == "local" || curr_st->symbol_tab[i]->var_type == "temp"){
				nextinstr = nextinstr + 1;
				symdata *glob_var = glob_st->search(curr_st->symbol_tab[i]->name);
				nextinstr = nextinstr + 1;
				if(glob_var == NULL){
					nextinstr = nextinstr + 1;
					glob_var = glob_st->lookup(curr_st->symbol_tab[i]->name);
					nextinstr = nextinstr + 1;
					int t_size = curr_st->symbol_tab[i]->tp_n->getSize();
					nextinstr = nextinstr + 1;
					glob_var->offset = glob_st->offset;
					nextinstr = nextinstr + 1;
					glob_var->size = t_size;
					nextinstr = nextinstr + 1;
					glob_st->offset += t_size;
					nextinstr = nextinstr + 1;
					glob_var->nest_tab = glob_st;
					nextinstr = nextinstr + 1;
					glob_var->var_type = curr_st->symbol_tab[i]->var_type;
					nextinstr = nextinstr + 1;
					glob_var->tp_n = curr_st->symbol_tab[i]->tp_n;
					nextinstr = nextinstr + 1;
					if(curr_st->symbol_tab[i]->isInitialized){
						glob_var->isInitialized = curr_st->symbol_tab[i]->isInitialized;
						nextinstr = nextinstr + 1;
						glob_var->i_val = curr_st->symbol_tab[i]->i_val;
						nextinstr = nextinstr + 1;
					}
				}
			}
		}
	}
	}                                       
	;

function_definition
	:	declaration_specifiers declarator declaration_list_opt compound_statement {
	int nextinstr = 0;
	symdata * func = glob_st->lookup($2.loc->name);
	nextinstr = nextinstr + 1;
	func->nest_tab->symbol_tab[0]->tp_n = CopyType(func->tp_n);
	nextinstr = nextinstr + 1;
	func->nest_tab->symbol_tab[0]->name = "retVal";
	nextinstr = nextinstr + 1;
	func->nest_tab->symbol_tab[0]->offset = 0;
	nextinstr = nextinstr + 1;
	//If return type is pointer then change the offset
	if(func->nest_tab->symbol_tab[0]->tp_n->basetp == tp_ptr){
		int diff = size_pointer - func->nest_tab->symbol_tab[0]->size;
		nextinstr = nextinstr + 1;
		func->nest_tab->symbol_tab[0]->size = size_pointer;
		nextinstr = nextinstr + 1;
		for(int i = 1; i < func->nest_tab->symbol_tab.size(); i++){
			func->nest_tab->symbol_tab[i]->offset += diff;
			nextinstr = nextinstr + 1;
		}
	}
	int offset_size = 0;
	nextinstr = nextinstr + 1;
	for(int i = 0; i < func->nest_tab->symbol_tab.size(); i++){
		offset_size += func->nest_tab->symbol_tab[i]->size;
		nextinstr = nextinstr + 1;
	}
	func->nest_tab->end_quad = next_instr - 1;
	nextinstr = nextinstr + 1;
	//Create a new Current Symbol Table
	curr_st = new symtab();
        };

declaration_list_opt
	:	declaration_list                                        
	
	|	/*Epsilon*/                                             
	;

declaration_list
	:	declaration                                             
	
	|	declaration_list declaration                            
	;

%%

void yyerror(const char*s){
	printf("%s",s);
}
