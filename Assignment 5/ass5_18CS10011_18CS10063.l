%{
	#include <stdio.h>
	#include <string.h>
	#include "ass5_18CS10011_18CS10063_translator.h"
	#include "y.tab.h"
%}

/*Definition of regular expressions*/

%option noyywrap

SINGLE_LINE		[/][/][^\n]*
KEYWORD		"const"|"restrict"|"volatile"|"inline"|"break"|"case"|"char"|"continue"|"default"|"do"|"double"|"else"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"return"|"short"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"void"|"while"
MULTIPLE		"/*"([^*]|(\*+[^*/]))*\*+\/
DIGIT			[0-9]
NONDIGIT		[a-zA-Z_]
IDENTIFIER		[_a-zA-Z][_A-Za-z0-9]*
NON_ZERO_DIGIT		[1-9]
INT_CONST		"0"|{NON_ZERO_DIGIT}("0"|{NON_ZERO_DIGIT})*
SIGN			"+"|"-"
DSEQ			{DIGIT}+	
EXP			("e"{SIGN}?{DSEQ})|("E"{SIGN}?{DSEQ})
FRAC_CONST		({DSEQ}?"."{DSEQ})|({DSEQ}".")
FLOATING_CONST		({FRAC_CONST}{EXP}?)|({DSEQ}{EXP})
ESC_SQ			"\\\'"|"\a"|"\\\""|"\?"|"\b"|"\\"|"\f"|"\n"|"\r"|"\t"|"\v"
C_CHAR			{ESC_SQ}|[^("\'"|"\\"|"\n")]
C_CHAR_SQ		{C_CHAR}+
C_CHAR_CONST		"\'"{C_CHAR_SQ}"\'"

PUNCTUATOR		"["|"]"|"{"|"}"|"."|"->"|"("|")"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"="|"*="|"/="|"%="|"+="|"-      ="|"<<="|">>="|"&="|"^="|"|="|","|"#"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."

S_CHAR			{ESC_SQ}|[^("\""|"\\"|"\n")]
S_CHAR_SQ		{S_CHAR}+
S_LIT			"\""{S_CHAR_SQ}?"\""

%%

{SINGLE_LINE}		{/*Empty*/}

"const"		{return CONST;}
"restrict"		{return RESTRICT;}
"volatile"		{return VOLATILE;}
"inline"		{return INLINE;}
"break"		{return BREAK;}
"case"			{return CASE;}
"char"			{return CHAR;}
"continue"		{return CONTINUE;}
"default"		{return DEFAULT;}
"do"			{return DO;}
"double"		{return DOUBLE;}
"else"			{return ELSE;}
"extern"		{return EXTERN;}
"float"		{return FLOAT;}
"for"			{return FOR;}
"goto"			{return GOTO;}
"if"			{return IF;}
"int"			{return INT;}
"long"			{return LONG;}
"return"		{return RETURN;}
"short"		{return SHORT;}
"sizeof"		{return SIZEOF;}
"static"		{return STATIC;}
"struct"		{return STRUCT;}
"switch"		{return SWITCH;}
"typedef"		{return TYPEDEF;}
"union"		{return UNION;}
"void"			{return VOID;}
"while"		{return WHILE;}

"["			{return LEFT_SQR;}
"]"			{return RIGHT_SQR;}
"("			{return LEFT_BKT;}
")"			{return RIGHT_BKT;}
"{"			{return LEFT_CURL;}
"}"			{return RIGHT_CURL;}
"."			{return DOT;}
"->"			{return ARROW;}
"++"			{return INC;}
"--"			{return DCM;}
"&"			{return BAND;}
"*"			{return MULT;}
"+"			{return PLUS;}
"-"			{return SUB;}
"~"			{return TILDE;}
"!"			{return NOT;}
"="			{return EQL;}
"*="			{return MEQL;}
"/="			{return DEQL;}
"%="			{return REQL;}
"+="			{return PEQL;}
"-="			{return SEQL;}	  	 	
"<<="			{return LSEQL;}
">>="			{return RSEQL;}
"&="			{return BANDEQL;}
"^="			{return XOREQL;}
"|="			{return BOREQL;}
","			{return COMMA;}
"#"			{return HASH;}
"/"			{return DIV;}
"%"			{return REM;}
"<<"			{return LSHIFT;}
">>"			{return RSHIFT;}
"<"			{return LT;}
">"			{return GT;}
"<="			{return LEQ;}
">="			{return GEQ;}
"=="			{return EQEQ;}
"!="			{return NEQ;}
"^"			{return XOR;}
"|"			{return BOR;}
"&&"			{return AND;}
"||"			{return OR;}
"?"			{return QUES;}
":"			{return COLON;}
";"			{return SCOL;}
"..."			{return DDD;}

{S_LIT}		{yylval.charval = yytext;		return STRING_LITERAL;}
{IDENTIFIER}		{yylval.symp = ST -> lookup(yytext);	return IDENTIFIER;}
{FLOATING_CONST}	{yylval.charval = yytext;		return FLOAT_CONST;}
{C_CHAR_CONST}		{yylval.charval = yytext;		return CHARACTER_CONST;}
{INT_CONST}		{yylval.intval = atoi(yytext);	return INTEGER_CONST;}

{MULTIPLE}		{/*Empty*/}
"\n"			{/*Empty*/}
"\t"			{/*Empty*/}
" "			{/*Empty*/}

%%
