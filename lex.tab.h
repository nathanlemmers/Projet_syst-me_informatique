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

#ifndef YY_YY_LEX_TAB_H_INCLUDED
# define YY_YY_LEX_TAB_H_INCLUDED
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
    tID = 258,
    tNB = 259,
    tIF = 260,
    tELSE = 261,
    tWHILE = 262,
    tPRINT = 263,
    tRETURN = 264,
    tINT = 265,
    tVOID = 266,
    tCOMMA = 267,
    tSEMI = 268,
    tRPAR = 269,
    tLPAR = 270,
    tLBRACE = 271,
    tRBRACE = 272,
    tNOT = 273,
    tOR = 274,
    tAND = 275,
    tASSIGN = 276,
    tLE = 277,
    tGE = 278,
    tEQ = 279,
    tNE = 280,
    tGT = 281,
    tLT = 282,
    tDIV = 283,
    tMUL = 284,
    tSUB = 285,
    tADD = 286,
    tERROR = 287
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 35 "Lex_et_Yacc/lex.y"
 char *s; int nb; 

#line 93 "lex.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);
/* "%code provides" blocks.  */
#line 28 "Lex_et_Yacc/lex.y"

  int yylex (void);
  void yyerror (const char *);



#line 113 "lex.tab.h"

#endif /* !YY_YY_LEX_TAB_H_INCLUDED  */
