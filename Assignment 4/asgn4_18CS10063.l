%{
#include "y.tab.h"
#include <math.h>
extern void yyerror(const char *);  /* prints grammar violation message */
void count(void);
%}

/* Definitions */

CONSTANT {IC}|{FC}|{CC}

NZ_DIGIT [1-9]
/* Non Zero Digit */

DIGIT [0-9]
/* Digit */

ZERO [0]
/* Zero */

DIGIT_SEQ ({DIGIT}+)
/* Digit Sequence */

NIC ({NZ_DIGIT}({DIGIT})*)
 /* Non Zero integer Constant */

IC ({NIC}|{ZERO}+)
  /* Integer Constant */
SIGN [+-]
 /* Sign */

E ([eE]{SIGN}?{DIGIT_SEQ})
/* Exponential Part */

FRACTIONAL_CONSTANT (({DIGIT_SEQ}?[\.]{DIGIT_SEQ})|({DIGIT_SEQ}[\.]))
/* Fractional Constant */

FC (({FRACTIONAL_CONSTANT}{E}?)|{DIGIT_SEQ}{E})
/*Floating point constant */

ALPHABET [a-zA-Z_]
/* Identifier Non Digit */

ID {ALPHABET}({ALPHABET}|{DIGIT})*
/* Identifier Identifier non digit */

ESC_SEQ		\\['"?\\abfnrtv]
/* Escape Sequence */

cchar 		[^'\\\n]|{ESC_SEQ}
/* C character set */

CC 		'({cchar})+'
/*Charactter Constant*/

schar 		[^"\\\n]|{ESC_SEQ}
/* String Character Set*/

SC 		\"({schar}+)\"
/* String Literal */

WS  		[ \t\v\n\f]
/*White Space*/

SINGLELINE_COMMENT  \/\/.*
/* Single Line Comment */

MULTILINE_COMMENT	\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*\/
/* Multi Line Comment */

%%

"break"         	{ return BREAK; }
"case"          	{ return CASE; }
"char"          	{ return CHAR; }
"continue"      	{ return CONTINUE; }
"default"       	{ return DEFAULT; }
"do"            	{ return DO; }
"double"        	{ return DOUBLE; }
"else"          	{ return ELSE; }
"extern"        	{ return EXTERN; }
"float"         	{ return FLOAT; }
"for"           	{ return FOR; }
"goto"          	{ return GOTO; }
"if"            	{ return IF; }
"int"           	{ return INT; }
"long"          	{ return LONG; }
"return"        	{ return RETURN; }
"short"         	{ return SHORT; }
"sizeof"        	{ return SIZEOF; }
"static"        	{ return STATIC; }
"struct"        	{ return STRUCT; }
"switch"        	{ return SWITCH; }
"typedef"       	{ return TYPEDEF; }
"union"         	{ return UNION; }
"void"          	{ return VOID; }
"while"        	        { return WHILE; }
"const"             {return CONST;}
"restrict"          {return RESTRICT;}
"volatile"          {return VOLATILE;}
"inline"            {return INLINE;}

{SC} 			{ return STRING_LITERAL; }
{ID}			{ return IDENTIFIER; }
{IC} 			{ return INT_CONSTANT; }
{FC} 			{ return FLOAT_CONSTANT; }
{CC} 			{ return CHAR_CONSTANT; }

"["			{ return '['; }
"]"			{ return ']'; }
"("			{ return '('; }
")"			{ return ')'; }
"{"			{ return '{'; }
"}"			{ return '}'; }
"."			{ return '.'; }
"->"			{ return PTR_OP; }
"++"			{ return INC_OP; }
"--"			{ return DEC_OP; }
"&"			{ return '&'; }
"*"			{ return '*'; }
"+"			{ return '+'; }
"-"			{ return '-'; }
"~"			{ return '~'; }
"!"			{ return '!'; }
"/"			{ return '/'; }
"%"			{ return '%'; }
"<<"			{ return LEFT_OP; }
">>"			{ return RIGHT_OP; }
"<"			{ return '<'; }
">"			{ return '>'; }
"<="			{ return LE_OP; }
">="			{ return GE_OP; }
"=="			{ return EQ_OP; }
"!="			{ return NE_OP; }
"^"			{ return '^'; }
"|"			{ return '|'; }
"&&"			{ return AND_OP; }
"||"			{ return OR_OP; }

"?"			{ return '?'; }
":"			{ return ':'; }
";"			{ return ';'; }
"..."			{ return ELLIPSIS; }
"="			{ return '='; }

"*="			{ return MUL_ASSIGN; }
"/="			{ return DIV_ASSIGN; }
"%="			{ return MOD_ASSIGN; }
"+="			{ return ADD_ASSIGN; }
"-="			{ return SUB_ASSIGN; }
"<<="			{ return LEFT_ASSIGN; }
">>="			{ return RIGHT_ASSIGN; }
"&="			{ return AND_ASSIGN; }
"^="			{ return XOR_ASSIGN; }
"|="			{ return OR_ASSIGN; }

","			{ return ','; }
"#"			{ return '#'; }


{SINGLELINE_COMMENT}    {;}
{MULTILINE_COMMENT}	{;}
{WS}			{;}

%%
