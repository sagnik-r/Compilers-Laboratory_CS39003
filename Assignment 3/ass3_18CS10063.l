%{
	/*Defining the Token Classes*/
	#define KEYWORD 1
	#define IDENTIFIER 2
	#define INTEGER_CONSTANT 3
	#define FLOAT_CONST 4
	#define CHAR_CONST 5
	#define SCHAR_LITERAL 6
	#define PUNCTUATOR 7
	#define SINGLE_LINE 8
	#define MULTI_LINE 9
	#define WS 10
%}
/*These are the regular expression definitions*/

KEYWORD 	"break"|"float"|"static"|"case"|"for"|"struct"|"char"|"goto"|"switch"|"continue"|"if"|"typedef"|"default"|"int"|"union"|"do"|"long"|"void"|"double"|"return"|"while"|"else"|"short"|"extern"|"sizeof"

DIGIT 	[0-9]
DIGIT_NOTZERO 	[1-9]
ZERO	[0]
ALPHABET 	[a-zA-Z_]
IDENTIFIER 	{ALPHABET}({ALPHABET}|{DIGIT})*

INTEGER_CONST 	({DIGIT_NOTZERO}{DIGIT}*)|{ZERO}+
DIGIT_SEQ 	{DIGIT}+
FRACT_CONST 	({DIGIT_SEQ}?"."{DIGIT_SEQ})|({DIGIT_SEQ}".")
SIGN 	[+-]
EXP_SIGN	[eE]
EXP_PART 	{EXP_SIGN}{SIGN}?{DIGIT_SEQ}
FLOAT_CONST 	({FRACT_CONST}{EXP_PART}?)|({DIGIT_SEQ}{EXP_PART})
ESCAPE 		"\\\'"|"\\\""|"\?"|"\\"|"\a"|"\b"|"\f"|"\n"|"\r"|"\t"|"\v"
CHAR_SET 	{ESCAPE}|[^("\'"|"\\"|"\n")]
CHAR_SEQ 	{CHAR_SET}+
SING_QUOTE	"\'"
CHAR_CONST 	{SING_QUOTE}{CHAR_SEQ}{SING_QUOTE}
CONSTANT 	{INTEGER_CONST}|{FLOAT_CONST}|{CHAR_CONST}

SCHAR_SET 	{ESCAPE}|[^("\""|"\\"|"\n")]
SCHAR_SEQ 	{SCHAR_SET}+
DOUB_QUOTE "\""
SCHAR_LITERAL 	{DOUB_QUOTE}{SCHAR_SEQ}{DOUB_QUOTE}

PUNC_1 	"["|"]"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|","|"#"
PUNC_2 	"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"
PUNC_3 	"?"|":"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|";"
PUNC_4 	"("|")"
PUNCTUATOR 	{PUNC_1}|{PUNC_2}|{PUNC_3}|{PUNC_4}

SINGLE_LINE 	"//"[^\n]*
NOT_STAR 	[^"*"]|\n
NOT_SLASH 	[^"/"]|\n
NOT_SLASH_STAR 	[^"*""/]|\n
MULTI_LINE		"/*"{NOT_STAR}*"*"("*"|({NOT_SLASH_STAR}{NOT_STAR}*"*"))*"/"
COMMENT {SINGLE_LINE}|{MULTI_LINE}

WS		[ \t\n]
%%

{KEYWORD}	{return KEYWORD; /*Keyword Rule*/}
{IDENTIFIER}	{return IDENTIFIER;/*Identifier Rule*/}
{INTEGER_CONST}	{return INTEGER_CONSTANT;/*Integer Constant Rule*/}
{FLOAT_CONST}	{return FLOAT_CONST; /*Floating Point Constant Rule*/}
{CHAR_CONST}	{return CHAR_CONST; /*Character Constant Rule*/}
{SCHAR_LITERAL}	  {return SCHAR_LITERAL; /*String Literal Rule*/}
{PUNCTUATOR}	{return PUNCTUATOR; /*Punctuator Rule*/}
{SINGLE_LINE}	{return SINGLE_LINE; /*Single Line Comment*/}
{MULTI_LINE}	{return MULTI_LINE; /*Multi Line Comment*/}
{WS}	{;/*White Space Rule*/}

%%