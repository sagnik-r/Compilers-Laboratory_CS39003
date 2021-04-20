#include<stdio.h>


int main()
{
	int token;
	while(token=yylex())//Interactive Flex
	{
		switch(token)
		{
			case KEYWORD:   		printf("<KEYWORD, %d, %s>\n", token, yytext);//Keyword
						    		break;
			case IDENTIFIER:    	printf("<IDENTIFIER, %d, %s>\n", token, yytext);//Identifier
							    	break;
		    case INTEGER_CONSTANT:  printf("<INTEGER_CONSTANT, %d, %s>\n", token, yytext);//Integer Constant
		    						break;
			case FLOAT_CONST:		printf("<FLOATING_CONSTANT, %d, %s>\n", token, yytext);//Floating Constant
									break;
			case CHAR_CONST :		printf("<CHARACTER_CONSTANT, %d, %s>\n", token, yytext);//Character Constant
									break;
			case SCHAR_LITERAL:		printf("<STRING_LITERAL, %d, %s>\n", token, yytext);//String Literal
									break;
			case PUNCTUATOR:		printf("<PUNCTUATOR, %d, %s>\n", token, yytext);//Punctuator
									break;
			case SINGLE_LINE:		printf("<SINGLE_LINE_COMMENT, %d, %s>\n", token, yytext);//Single Line Comment
									break;
			case MULTI_LINE:		printf("<MULTILINE COMMNET, %d, %s>\n", token, yytext);//Multi Line Comment
									break;
			case WS:				break;
			default:				break;
		}
	}
}