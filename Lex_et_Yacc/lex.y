%{
#include <stdio.h>
#include <stdlib.h>
#include "../Table_symboles.ts.h"
%}

%code provides {
  int yylex (void);
  void yyerror (const char *);
  int profondeur = 0 ; ;
}

%union { char *s; }

%token <s> tID tNB ;
%token tIF  tELSE tWHILE tPRINT tRETURN tINT tVOID tCOMMA tSEMI tRPAR tLPAR tLBRACE tRBRACE tNOT tOR tAND tASSIGN tLE tGE tEQ tNE tGT tLT tDIV tMUL tSUB tADD tERROR
%left tADD tSUB
%left tMUL tDIV
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

argument : tINT tID {addVariable($2, 0, 0, 0) ;}
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

tandis : tWHILE tLPAR condition tRPAR tLBRACE {profondeur++ ;} structure tRBRACE {profondeur-- ; delVariable(profondeur)  ;}
;


sinon : tELSE tLBRACE {profondeur++ ;} structure tRBRACE {profondeur-- ; delVariable(profondeur)  ;}
;

si : 
    tIF tLPAR condition tRPAR tLBRACE {profondeur++ ;} structure tRBRACE {profondeur-- ; delVariable(profondeur)  ;}
;

condition : variable comparateur variable 
    |variable
    |tNOT variable
;

action : newVariable tSEMI {printf("Int declaration\n") ;} 
    |assignation  tSEMI {printf("Assignment\n") ;}
    |afficher tSEMI    {printf("Print\n") ;}
;


newVariable : tINT tID {addVariable($2, 1, 0, profondeur) ;}
    |tINT valeur tASSIGN calcul
    |tINT valeur tASSIGN variable
;

valeur : tID {addVariable($1, 1, 0, profondeur) ;}
    |valeur tCOMMA tID {addVariable($3, 1, 0, profondeur) ;}

assignation : tID tASSIGN variable {initialiser($1) ;}
    |tID tASSIGN calcul    {initialiser($1) ;}
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


//Faire même struct pour NB, voir ensuite
calcul : tID {int adrs = findOffset($1) ;
            addTemporaire() ;
            int adrsTempo = lastOffset() ;
            printf("COP %d, %d\n", adrs, adrsTempo)}
    |tNB
    |calcul tDIV calcul
    |calcul tMUL calcul 
    |calcul tSUB calcul
    |calcul tADD calcul
; 

/*operateur :
    tDIV  {printf("DIV\n") ;}
    |tMUL {printf("MUL\n") ;}
    |tSUB {printf("SUB\n") ;}
    |tADD {printf("ADD\n") ;}
;*/

fonction : tID tLPAR agrvs tRPAR ;

agrvs : agrv    
    |agrvs tCOMMA agrv
;

agrv : calcul
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
