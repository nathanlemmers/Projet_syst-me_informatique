%{
#include <stdio.h>
#include <stdlib.h>
%}

%code provides {
  int yylex (void);
  void yyerror (const char *);
}

%union { char *s; }

%token <s> tID tNB ;
%token tIF  tELSE tWHILE tPRINT tRETURN tINT tVOID tCOMMA tSEMI tRPAR tLPAR tLBRACE tRBRACE tNOT tOR tAND tASSIGN tLE tGE tEQ tNE tGT tLT tDIV tMUL tSUB tADD tERROR

%%

totals : total
    |totals total {printf("Code correct.\n") ;}
;

total :
    tVOID tID tLPAR arguments tRPAR tLBRACE structure tRBRACE {printf("fonction void reconnue\n") ;}
    | tINT tID tLPAR arguments tRPAR tLBRACE structure retour tRBRACE {printf("fonction int reconnue\n") ;}
; 

retour : tRETURN variable tSEMI ;


arguments : argument
    |arguments tCOMMA argument
    |tVOID
;

argument : tINT tID
;


structure :
     contenu structure
    | contenu
;

contenu : 
    action 
    |Sicomplet {printf("Structure if ou if else\n") ;}
    |tandis {printf("Structure While\n") ;} 
;


Sicomplet : si
    |si sinon 
;

tandis : tWHILE tLPAR condition tRPAR tLBRACE structure tRBRACE
;


sinon : tELSE tLBRACE structure tRBRACE
;

si : 
    tIF tLPAR condition tRPAR tLBRACE structure tRBRACE
;

condition : variable comparateur variable 
    |variable
    |tNOT variable
;

action : newVariable tSEMI {printf("Int declaration\n") ;}
    |assignation  tSEMI {printf("Assignment\n") ;}
    |afficher tSEMI    {printf("Print\n") ;}
;


newVariable : tINT tID 
    |tINT valeur tASSIGN calculs
    |tINT valeur tASSIGN variable
;

valeur : tID
    |valeur tCOMMA tID

assignation : tID tASSIGN variable 
    |tID tASSIGN calculs
;

afficher :
    tPRINT tLPAR tID tRPAR 
;



variable : tID
    |tNB 
    |fonction
; 


comparateur : tOR    {printf("comparateur\n") ;}
    |tAND   {printf("comparateur\n") ;}
    |tLE    {printf("comparateur\n") ;}
    |tGE    {printf("comparateur\n") ;}
    |tEQ    {printf("comparateur\n") ;}
    |tNE    {printf("comparateur\n") ;}
    |tGT    {printf("comparateur\n") ;}
    |tLT    {printf("comparateur\n") ;}
;

calculs : calcul variable 
    |calculs operateur variable ;

calcul :
    variable operateur ;

operateur :
    tDIV  {printf("DIV\n") ;}
    |tMUL {printf("MUL\n") ;}
    |tSUB {printf("SUB\n") ;}
    |tADD {printf("ADD\n") ;}
;

fonction : tID tLPAR agrvs tRPAR ;

agrvs : agrv    
    |agrvs tCOMMA agrv
;

agrv : calculs
    |variable
;

%%

void yyerror(const char *msg) {
  fprintf(stderr, "error: %s\n", msg);
  exit(1);
}

int main(void) {
  yyparse();
}
