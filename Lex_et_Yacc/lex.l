%option noyywrap
%option noinput
%option nounput

%{
#include "lex.tab.h"
%}


%x COMMENT

%%
[ \t\n]  {} ;

 
"/*" { BEGIN(COMMENT); } 

[0-9]* {yylval.s = strdup(yytext) ; return tNB ;} //Pour les nombres décimaux
0x[0-9A-Fa-f]* {yylval.s = strdup(yytext) ; return tNB ; } //Pour les Hexadécimaux

"//".* {;}  


<COMMENT>. {;}
<COMMENT>\n {;}  
<COMMENT>"*/" { BEGIN(INITIAL); }


"if" {return tIF ;}
"else" {return tELSE ;}
"while" {return tWHILE ;}
"print" {return tPRINT ;}
"return" {return tRETURN ;}
"int" {return tINT ;}
"void" {return tVOID ;}


[,] {return tCOMMA ;}
[;] {return tSEMI ;}
\) {return tRPAR ;}
\( {return tLPAR ;}
\{ {return tLBRACE ;}
\} {return tRBRACE ;}
[!] {return tNOT ;}
"||" {return tOR ;}
"&&" {return tAND ;}
= {return tASSIGN ;}
"<=" {return tLE ;}
">=" {return tGE ;}
"==" {return tEQ ;}
"!=" {return tNE ;}
">" {return tGT ;}
"<" {return tLT ;}
"/" {return tDIV ;}
"*" {return tMUL ;}
"-" {return tSUB ;}
"+" {return tADD ;}


[a-zA-Z][a-zA-Z0-9]* {yylval.s = strdup(yytext) ; return tID ; }
. {}
 