/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TYPEDEF = 258,
    EXTERN = 259,
    STATIC = 260,
    INLINE = 261,
    RESTRICT = 262,
    CHAR = 263,
    SHORT = 264,
    INT = 265,
    LONG = 266,
    FLOAT = 267,
    DOUBLE = 268,
    CONST = 269,
    VOLATILE = 270,
    VOID = 271,
    STRUCT = 272,
    UNION = 273,
    BREAK = 274,
    CASE = 275,
    CONTINUE = 276,
    DEFAULT = 277,
    DO = 278,
    IF = 279,
    ELSE = 280,
    FOR = 281,
    GOTO = 282,
    WHILE = 283,
    SWITCH = 284,
    SIZEOF = 285,
    RETURN = 286,
    ELLIPSIS = 287,
    RIGHT_ASSIGN = 288,
    LEFT_ASSIGN = 289,
    ADD_ASSIGN = 290,
    SUB_ASSIGN = 291,
    MUL_ASSIGN = 292,
    DIV_ASSIGN = 293,
    MOD_ASSIGN = 294,
    AND_ASSIGN = 295,
    XOR_ASSIGN = 296,
    OR_ASSIGN = 297,
    RIGHT_OP = 298,
    LEFT_OP = 299,
    INC_OP = 300,
    DEC_OP = 301,
    PTR_OP = 302,
    AND_OP = 303,
    OR_OP = 304,
    LE_OP = 305,
    GE_OP = 306,
    EQ_OP = 307,
    NE_OP = 308,
    IDENTIFIER = 309,
    STRING_LITERAL = 310,
    PUNCTUATORS = 311,
    COMMENT = 312,
    INT_CONSTANT = 313,
    FLOAT_CONSTANT = 314,
    CHAR_CONSTANT = 315,
    LOWER_THAN_ELSE = 316
  };
#endif
/* Tokens.  */
#define TYPEDEF 258
#define EXTERN 259
#define STATIC 260
#define INLINE 261
#define RESTRICT 262
#define CHAR 263
#define SHORT 264
#define INT 265
#define LONG 266
#define FLOAT 267
#define DOUBLE 268
#define CONST 269
#define VOLATILE 270
#define VOID 271
#define STRUCT 272
#define UNION 273
#define BREAK 274
#define CASE 275
#define CONTINUE 276
#define DEFAULT 277
#define DO 278
#define IF 279
#define ELSE 280
#define FOR 281
#define GOTO 282
#define WHILE 283
#define SWITCH 284
#define SIZEOF 285
#define RETURN 286
#define ELLIPSIS 287
#define RIGHT_ASSIGN 288
#define LEFT_ASSIGN 289
#define ADD_ASSIGN 290
#define SUB_ASSIGN 291
#define MUL_ASSIGN 292
#define DIV_ASSIGN 293
#define MOD_ASSIGN 294
#define AND_ASSIGN 295
#define XOR_ASSIGN 296
#define OR_ASSIGN 297
#define RIGHT_OP 298
#define LEFT_OP 299
#define INC_OP 300
#define DEC_OP 301
#define PTR_OP 302
#define AND_OP 303
#define OR_OP 304
#define LE_OP 305
#define GE_OP 306
#define EQ_OP 307
#define NE_OP 308
#define IDENTIFIER 309
#define STRING_LITERAL 310
#define PUNCTUATORS 311
#define COMMENT 312
#define INT_CONSTANT 313
#define FLOAT_CONSTANT 314
#define CHAR_CONSTANT 315
#define LOWER_THAN_ELSE 316

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 9 "asgn4_18CS10063.y"

int intval;

#line 183 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
