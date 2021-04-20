%{ /* C Declarations and Definitions */
	#include <string.h>
	#include <stdio.h>

	extern int yylex();
	void yyerror(char *s);
%}

%union {
int intval;
}

%token TYPEDEF EXTERN STATIC INLINE RESTRICT
%token CHAR SHORT INT LONG FLOAT DOUBLE CONST VOLATILE VOID
%token STRUCT UNION
%token BREAK CASE CONTINUE DEFAULT DO IF ELSE FOR GOTO WHILE SWITCH SIZEOF
%token RETURN

%token ELLIPSIS RIGHT_ASSIGN LEFT_ASSIGN ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN
%token DIV_ASSIGN MOD_ASSIGN AND_ASSIGN XOR_ASSIGN OR_ASSIGN RIGHT_OP LEFT_OP
%token INC_OP DEC_OP PTR_OP AND_OP OR_OP LE_OP GE_OP EQ_OP NE_OP

%token IDENTIFIER STRING_LITERAL PUNCTUATORS COMMENT
%token INT_CONSTANT FLOAT_CONSTANT CHAR_CONSTANT

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%start translation_unit

%%

primary_expression
	: IDENTIFIER
	{printf("primary_expression -> identifier\n");}
	| constant
	{printf("primary_expression -> constant\n");}
	| STRING_LITERAL
	{printf("primary_expression -> string_literal\n");}
	| '(' expression ')'
	{printf("primary_expression -> ( expression )\n");}
	;

constant
	: INT_CONSTANT
	| FLOAT_CONSTANT
	| CHAR_CONSTANT
	;

postfix_expression
	: primary_expression
	{printf("postfix_expression -> primary_expression\n");}
	| postfix_expression '[' expression ']'
	{printf("postfix_expression -> postfix_expression [ expression ]\n");}
	| postfix_expression '(' ')'
	{printf("postfix_expression -> postfix_expression ( argument_expression_list_opt )\n");}
	| postfix_expression '(' argument_expression_list ')'
	{printf("postfix_expression -> postfix_expression ( argument_expression_list_opt )\n");}
	| postfix_expression '.' IDENTIFIER
	{printf("postfix_expression -> postfix_expression . identifier\n");}
	| postfix_expression PTR_OP IDENTIFIER
	{printf("postfix_expression -> postfix_expression -> identifier\n");}
	| postfix_expression INC_OP
	{printf("postfix_expression -> postfix_expression ++\n");}
	| postfix_expression DEC_OP
	{printf("postfix_expression -> postfix_expression --\n");}
	| '(' type_name ')' '{' initializer_list '}'
	{printf("postfix_expression -> ( type_name ) { initializer_list }\n");}
	|  '(' type_name ')' '{' initializer_list ',' '}'
	{printf("postfix_expression -> ( type_name ) { initializer_list , }\n");}
	;

argument_expression_list
	: assignment_expression
	{printf("argument_expression_list -> assignment_expression\n");}
	| argument_expression_list ',' assignment_expression
	{printf("argument_expression_list -> argument_expression_list , assignment_expression \n");}
	;

unary_expression
	: postfix_expression
	{printf("unary_expression -> postfix_expression \n");}
	| INC_OP unary_expression
	{printf("unary_expression -> ++ unary_expression\n");}
	| DEC_OP unary_expression
	{printf("unary_expression -> -- unary_expression\n");}
	| unary_operator cast_expression
	{printf("unary_expression -> unary_operator cast_expression\n");}
	| SIZEOF unary_expression
	{printf("unary_expression -> sizeof unary_expression\n");}
	| SIZEOF '(' type_name ')'
	{printf("unary_expression -> sizeof ( type_name )\n");}
	;

unary_operator
	: '&'
	{printf("unary_operator -> unary_operator_&\n");}
	| '*'
	{printf("unary_operator -> unary_operator_*\n");}
	| '+'
	{printf("unary_operator -> unary_operator_+\n");}
	| '-'
	{printf("unary_operator -> unary_operator_-\n");}
	| '~'
	{printf("unary_operator -> unary_operator_~\n");}
	| '!'
	{printf("unary_operator -> unary_operator_!\n");}
	;

cast_expression
	: unary_expression
	{printf("cast_expression -> unary_expression\n");}
	| '(' type_name ')' cast_expression
	{printf("cast_expression -> ( type_name ) cast_expression\n");}
	;

multiplicative_expression
	: cast_expression
	{printf("multiplicative_expression -> cast_expression\n");}
	| multiplicative_expression '*' cast_expression
	{printf("multiplicative_expression -> multiplicative_expression * cast_expression\n");}
	| multiplicative_expression '/' cast_expression
	{printf("multiplicative_expression -> multiplicative_expression / cast_expression\n");}
	| multiplicative_expression '%' cast_expression
	{printf("multiplicative_expression -> multiplicative_expression %% cast_expression\n");}
	;

additive_expression
	: multiplicative_expression
	{printf("additive_expression -> multiplicative_expression\n");}
	| additive_expression '+' multiplicative_expression
	{printf("additive_expression -> additive_expression + multiplicative_expression\n");}
	| additive_expression '-' multiplicative_expression
	{printf("additive_expression -> additive_expression - multiplicative_expression\n");}
	;

shift_expression
	: additive_expression
	{printf("shift_expression -> additive_expression\n");}
	| shift_expression LEFT_OP additive_expression
	{printf("shift_expression -> shift_expression << additive_expression\n");}
	| shift_expression RIGHT_OP additive_expression
	{printf("shift_expression -> shift_expression >> additive_expression\n");}
	;

relational_expression
	: shift_expression
	{printf("relational_expression -> shift_expression\n");}
	| relational_expression '<' shift_expression
	{printf("relational_expression -> relational_expression < shift_expression\n");}
	| relational_expression '>' shift_expression
	{printf("relational_expression -> relational_expression > shift_expression\n");}
	| relational_expression LE_OP shift_expression
	{printf("relational_expression -> relational_expression <= shift_expression\n");}
	| relational_expression GE_OP shift_expression
	{printf("relational_expression -> relational_expression >= shift_expression\n");}
	;

equality_expression
	: relational_expression
	{printf("equality_expression -> relational_expression\n");}
	| equality_expression EQ_OP relational_expression
	{printf("equality_expression -> equality_expression == relational_expression\n");}
	| equality_expression NE_OP relational_expression
	{printf("equality_expression -> equality_expression != relational_expression\n");}
	;

and_expression
	: equality_expression
	{printf("and_expression -> equality_expression\n");}
	| and_expression '&' equality_expression
	{printf("and_expression -> and_expression & equality_expression\n");}
	;

exclusive_or_expression
	: and_expression
	{printf("exclusive_or_expression -> and_expression\n");}
	| exclusive_or_expression '^' and_expression
	{printf("exclusive_or_expression -> axclusive_or_expression ^ ans_expression\n");}
	;

inclusive_or_expression
	: exclusive_or_expression
	{printf("inclusive_or_expression -> exclusive_or_expression\n");}
	| inclusive_or_expression '|' exclusive_or_expression
	{printf("inclusive_or_expression -> inclusive_or_expression | exclusive_or_expression\n");}
	;

logical_and_expression
	: inclusive_or_expression
	{printf("logical_and_expression -> inclusive_or_expression\n");}
	| logical_and_expression AND_OP inclusive_or_expression
	{printf("logical_and_expression -> logical_and_expression && inclusive_or_expression\n");}
	;

logical_or_expression
	: logical_and_expression
	{printf("logical_or_expression -> logical_and_expression\n");}
	| logical_or_expression OR_OP logical_and_expression
	{printf("logical_or_expression -> logica_or_expression || logical_and_expression\n");}
	;

conditional_expression
	: logical_or_expression
	{printf("conditional_expression -> logical_or_expression\n");}
	| logical_or_expression '?' expression ':' conditional_expression
	{printf("conditional_expression -> logical_expression ? expression : conditional_expression\n");}
	;

assignment_expression
	: conditional_expression
	{printf("assignment_expression -> conditional_expression\n");}
	| unary_expression assignment_operator assignment_expression
	{printf("assignment_expression -> unary_expression assignment_operator assignment_expression\n");}
	;

assignment_operator
	: '='
	{printf("assignment_operator -> =\n");}
	| MUL_ASSIGN
	{printf("assignment_operator -> *=\n");}
	| DIV_ASSIGN
	{printf("assignment_operator -> /=\n");}
	| MOD_ASSIGN
	{printf("assignment_operator -> %%=\n");}
	| ADD_ASSIGN
	{printf("assignment_operator -> +=\n");}
	| SUB_ASSIGN
	{printf("assignment_operator -> -=\n");}
	| LEFT_ASSIGN
	{printf("assignment_operator -> <<=\n");}
	| RIGHT_ASSIGN
	{printf("assignment_operator -> >>=\n");}
	| AND_ASSIGN
	{printf("assignment_operator -> &=\n");}
	| XOR_ASSIGN
	{printf("assignment_operator -> ^=\n");}
	| OR_ASSIGN
	{printf("assignment_operator -> |=\n");}
	;

expression
	: assignment_expression
	{printf("expression -> assignment_expression\n");}
	| expression ',' assignment_expression
	{printf("expression -> expression , assignment_expression\n");}
	;

constant_expression
	: conditional_expression
	{printf("constant_expression -> conditional_expression\n");}
	;

declaration
	: declaration_specifiers ';'
	{printf("declaration -> declaration_specifiers init_declarator_list_opt\n");}
	| declaration_specifiers init_declarator_list ';'
	{printf("declaration -> declaration_specifiers init_declarator_list_opt\n");}
	;

declaration_specifiers
	: storage_class_specifier
	{printf("declaration_specifiers -> storage_class_specifier declaration_specifiers_opt\n");}
	| storage_class_specifier declaration_specifiers
	{printf("declaration_specifiers -> storage_class_specifier declaration_specifiers_opt\n");}
	| type_specifier
	{printf("declaration_specifiers -> type_specifier declaration_specifiers_opt\n");}
	| type_specifier declaration_specifiers
	{printf("declaration_specifiers -> type_specifier declaration_specifiers_opt\n");}
	| type_qualifier
	{printf("declaration_specifiers -> type_qualifier declaration_specifiers_opt\n");}
	| type_qualifier declaration_specifiers
	{printf("declaration_specifiers -> type_qualifier declaration_specifiers_opt\n");}
	| function_specifier
	{printf("declaration_specifiers -> function_specifier declaration_specifiers_opt\n");}
	| function_specifier declaration_specifiers
	{printf("declaration_specifiers -> function_specifier declaration_specifiers_opt\n");}
	;

init_declarator_list
	: init_declarator
	{printf("init_declarator_list -> init_declarator\n");}
	| init_declarator_list ',' init_declarator
	{printf("init_declarator_list -> init_declarator_list , init_declarator\n");}
	;

init_declarator
	: declarator
	{printf("init_declarator -> declarator\n");}
	| declarator '=' initializer
	{printf("init_declarator -> declarator = initializer\n");}
	;

storage_class_specifier
	: EXTERN
	{printf("storage_class_specifier -> extern\n");}
	| STATIC
	{printf("storage_class_specifier -> static\n");}
	;

type_specifier
	: VOID
	{printf("type_specifier -> void\n");}
	| CHAR
	{printf("type_specifier -> char\n");}
	| SHORT
	{printf("type_specifier -> short\n");}
	| INT
	{printf("type_specifier -> int\n");}
	| LONG
	{printf("type_specifier -> long\n");}
	| FLOAT
	{printf("type_specifier -> float\n");}
	| DOUBLE
	{printf("type_specifier -> double\n");}
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list
	{printf("specifier_qualifier_list -> type_specifier specifier_qualifier_list_opt\n");}
	| type_specifier
	{printf("specifier_qualifier_list -> type_specifier specifier_qualifier_list_opt\n");}
	| type_qualifier specifier_qualifier_list
	{printf("specifier_qualifier_list -> type_qualifier specifier_qualifier_list_opt\n");}
	| type_qualifier
	{printf("specifier_qualifier_list -> type_qualifier specifier_qualifier_list_opt\n");}
	;

type_qualifier
	: CONST
	{printf("type_qualifier -> const\n");}
	| RESTRICT
	{printf("type_qualifier -> restrict\n");}
	| VOLATILE
	{printf("type_qualifier -> volatile\n");}
	;
	
function_specifier
	: INLINE
	{printf("function_specifier -> inline\n");}
	;
	
declarator
	: pointer direct_declarator
	{printf("declarator -> pointer_opt direct_declarator\n");}
	| direct_declarator
	{printf("declarator -> pointer_opt direct_declarator\n");}
	;

direct_declarator
	: IDENTIFIER
	{printf("direct_declarator -> identifier\n");}
	| '(' declarator ')'
	{printf("direct_declarator -> ( declarator )\n");}
	| direct_declarator '['  type_qualifier_list_opt assignment_expression_opt ']'
	{printf("direct_declarator -> direct_declarator [ type_qualifier_list_opt assignment_expression_opt ]\n");}
	| direct_declarator '[' STATIC type_qualifier_list_opt assignment_expression ']'
	{printf("direct_declarator -> [ static type_qualifier_list_opt assignment_expression ]\n");}
	| direct_declarator '[' type_qualifier_list STATIC assignment_expression ']'
	{printf("direct_declarator -> [ type_qualifier_list static assignment_expression ]\n");}
    	| direct_declarator '[' type_qualifier_list_opt '*' ']'
    	{printf("direct_declarator -> direct_declarator [ type_qualifier_list_opt * ]\n");}
	| direct_declarator '(' parameter_type_list ')'
	{printf("direct_declarator -> direct_declarator ( parameter_type_list )\n");}
	| direct_declarator '(' identifier_list ')'
	{printf("direct_declarator -> direct_declarator ( identifier_list_opt )\n");}
	| direct_declarator '(' ')'
	{printf("direct_declarator -> direct_declarator ( identifier_list_opt )\n");}
	;

type_qualifier_list_opt
	:  /* empty */
	| type_qualifier_list
	{printf("Type_qualifier_list_optional \n");}
	;
assignment_expression_opt
	:  /* empty */
	| assignment_expression
	{printf("Assignment_expression_optional \n");}
	;

pointer
	: '*'
	{printf("pointer -> * type_qualifier_list_opt\n");}
	| '*' type_qualifier_list
	{printf("pointer -> * type_qualifier_list_opt\n");}
	| '*' pointer
	{printf("pointer -> * type_qualifier_list_opt pointer\n");}
	| '*' type_qualifier_list pointer
	{printf("pointer -> * type_qualifier_list_opt pointer\n");}
	;

type_qualifier_list
	: type_qualifier
	{printf("type_qualifier_list -> type_qualifier\n");}
	| type_qualifier_list type_qualifier
	{printf("type_qualifier_list -> type_qualifier_list type_qualifier\n");}
	;

parameter_type_list
	: parameter_list
	{printf("parameter_type_list -> parameter_list\n");}
	| parameter_list ',' ELLIPSIS
	{printf("parameter_type_list -. parameter_list , ...\n");}
	;

parameter_list
	: parameter_declaration
	{printf("parameter_list -> parameter_declaration\n");}
	| parameter_list ',' parameter_declaration
	{printf("parameter_list -> parameter_list , parameter_declaration\n");}
	;

parameter_declaration
	: declaration_specifiers declarator
	{printf("parameter_declaration -> declaration_specifiers declarator\n");}
	| declaration_specifiers
	{printf("parameter_declaration -> declaration_specifiers\n");}
	;

identifier_list
	: IDENTIFIER
	{printf("identifier_list -> identifier\n");}
	| identifier_list ',' IDENTIFIER
	{printf("identifier_list -> identifier_list , identifier\n");}
	;

type_name
	: specifier_qualifier_list
	{printf("type_name -> specifier_qualifier_list\n");}
	;

initializer
	: assignment_expression
	{printf("initializer -> assignment_expression\n");}
	| '{' initializer_list '}'
	{printf("initializer -> { initializer_list }\n");}
	| '{' initializer_list ',' '}'
	{printf("initializer -> { iniializer_list , }\n");}
	;

initializer_list
	: initializer
	{printf("initializer_list -> designation_opt initializer\n");}
	| designation initializer
	{printf("initializer_list -> designation_opt initializer\n");}
	| initializer_list ',' initializer
	{printf("initializer_list -> initializer_list , designation_opt initializer\n");}
	|  initializer_list ',' designation initializer
	{printf("initializer_list -> initializer_list , designation_opt initializer\n");}
	;

designation
	: designator_list '='
	{printf("designation -> designator_list =\n");}
	;

designator_list
	: designator
	{printf("designator_list -> designator\n");}
	| designator_list designator
	{printf("designator_list -> designator_list designator\n");}
	;

designator
	: '[' constant_expression ']'
	{printf("designator -> [ constant_expression ]\n");}
	| '.' IDENTIFIER
	{printf("designator -> . identifier\n");}
	;

statement
	: labeled_statement
	{printf("statement -> labeled_statement\n");}
	| compound_statement
	{printf("statement -> compound_statement\n");}
	| expression_statement
	{printf("statement -> expression_statement\n");}
	| selection_statement
	{printf("statement -> selection_statement\n");}
	| iteration_statement
	{printf("statement -> iteration_statement\n");}
	| jump_statement
	{printf("statement -> jump_statement\n");}
	;

labeled_statement
	: IDENTIFIER ':' statement
	{printf("labeled_statement -> labeled_statement identifier : statement\n");}
	| CASE constant_expression ':' statement
	{printf("labeled_statement -> case constant_expression : statement\n");}
	| DEFAULT ':' statement
	{printf("labeled_statement -> default : statement\n");}
	;

compound_statement
	: '{' '}'
	{printf("compound_statement -> { block_item_list_opt }\n");}
	| '{' block_item_list '}'
	{printf("compound_statement -> { block_item_list_opt }\n");}
	;

block_item_list
	: block_item
	{printf("block_item_list -> block_item\n");}
	| block_item_list block_item
	{printf("block_item_list -> block_item_list block_item\n");}
	;

block_item
	: declaration
	{printf("block_item -> declaration\n");}
	| statement
	{printf("block_item -> statement\n");}
	;

expression_statement
	: ';'
	{printf("expression_statement -> expression_opt ;\n");}
	| expression ';'
	{printf("expression_statement -> expression_opt ;\n");}
	;

selection_statement
	: IF '(' expression ')' statement	%prec LOWER_THAN_ELSE 
	{printf("selection_statement -> if ( expression ) statement\n");}
	| IF '(' expression ')' statement ELSE statement
	{printf("selection_statement -> if (expression) statement else statement\n");}
	| SWITCH '(' expression ')' statement
	{printf("selection_statement -> switch (expression) statement\n");}
	;

iteration_statement
	: WHILE '(' expression ')' statement
	{printf("iteration_statement -> while ( expression ) statement\n");}
	| DO statement WHILE '(' expression ')' ';'
	{printf("iteration_statement -> do statement while ( expression ) ;\n");}
	| FOR '(' expression_statement expression_statement ')' statement
	{printf("iteration_statement -> for( expression_opt ; expression_opt ; expression_opt ) statement\n");}
	| FOR '(' expression_statement expression_statement expression ')' statement
	{printf("iteration_statement -> for( expression_opt ; expression_opt ; expression_opt ) statement\n");}
	| FOR '(' declaration expression_statement expression ')' statement
    	{printf("iteration_statement -> for( declaration expression_opt ; expression_opt ) statement\n");}
    	| FOR '(' declaration expression_statement ')' statement
    	{printf("iteration_statement -> for( declaration expression_opt ; expression_opt ) statement\n");}
	;

jump_statement
	: GOTO IDENTIFIER ';'
	{printf("jump_statement -> goto identifier ;\n");}
	| CONTINUE ';'
	{printf("jump_statement -> continue ;\n");}
	| BREAK ';'
	{printf("jump_statement -> break ;\n");}
	| RETURN ';'
	{printf("jump_statement -> return expression_opt ;\n");}
	| RETURN expression ';'
	{printf("jump_statement -> return expression_opt ;\n");}
	;

translation_unit
	: external_declaration
	{printf("translation_unit -> external_declaration\n");}
	| translation_unit external_declaration
	{printf("translation_unit -> translation_unit external_declaration\n");}
	;

external_declaration
	: function_definition
	{printf("external_declaration -> function_definition\n");}
	| declaration
	{printf("external_declaration -> declaration\n");}
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement
	{printf("function_definition -> declaration_specifiers declarator declarator_list_opt compound_statement\n");}
	| declaration_specifiers declarator compound_statement
	{printf("function_definition -> declaration_specifiers declarator declarator_list_opt compound_statement\n");}
	;

declaration_list
	: declaration
	{printf("declaration_list -> declaration\n");}
	| declaration_list declaration
	{printf("declaration_list -> declaration_list declaration\n");}
	;


%%
void yyerror(char *s) {
	printf ("\n FOUND ERROR: %s\n",s);
}
