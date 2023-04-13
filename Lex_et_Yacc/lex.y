%{
#include <stdio.h>
#include <stdlib.h>
#include "./Table_symboles/ts.h"
%}

%code provides {
  int yylex (void);
  void yyerror (const char *);
}

%union { char *s; }

%token <s> tID tNB ;
%token tIF  tELSE tWHILE tPRINT tRETURN tINT tVOID tCOMMA tSEMI tRPAR tLPAR tLBRACE tRBRACE tNOT tOR tAND tASSIGN tLE tGE tEQ tNE tGT tLT tDIV tMUL tSUB tADD tERROR
%left tADD tSUB tOR tAND
%left tMUL tDIV tLE tGE tEQ tNE tGT tLT
%%

totals : total {printTable() ;}
    |totals total {printTable() ;}
;

total :
    tVOID tID tLPAR arguments tRPAR tLBRACE structure tRBRACE
    | tINT tID tLPAR arguments tRPAR tLBRACE structure retour tRBRACE
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

tandis : tWHILE tLPAR condition tRPAR tLBRACE {addProfondeur() ;} structure tRBRACE {delProfondeur() ; delVariable(getProfondeur())  ;}
;


sinon : tELSE tLBRACE {addProfondeur() ;} structure tRBRACE {delProfondeur() ; delVariable(getProfondeur())  ;}
;

si : 
    tIF tLPAR condition tRPAR tLBRACE {addProfondeur() ;} structure tRBRACE {delProfondeur() ; delVariable(getProfondeur())  ;}
;

condition : condition tOR condition 
    |condition tAND condition 
    |condition tLE condition
    |condition tGE condition
    |condition tEQ condition
    |condition tNE condition
    |condition tGT condition
    |condition tLT condition
    |variable
    |tNOT variable
    |tNOT tLPAR condition tRPAR
;

action : newVariable tSEMI //{printf("Int declaration\n") ;} 
    |assignation  tSEMI //{printf("Assignment\n") ;}
    |afficher tSEMI    //{printf("Print\n") ;}
;


newVariable : tINT valeur
    |tINT valeur tASSIGN calcul {int adrs2 = lastOffset() ;
                                int adrs1 = adrs2-1 ;
                                printf("COP %d, %d\n", adrs1, adrs2) ;
                                init(adrs1) ;
                                delTemporaire() ;}
;

valeur : tID {addVariable($1, 0, 0, getProfondeur()) ;}
    |valeur tCOMMA tID {addVariable($3, 0, 0, getProfondeur()) ;}

assignation : tID tASSIGN calcul    {initialiser($1) ;
                                    int adrs2 = lastOffset() ;
                                    int adrs1 = findOffset($1) ;
                                    printf("COP %d, %d\n", adrs1, adrs2) ;
                                    delTemporaire() ;}
;

afficher :
    tPRINT tLPAR tID tRPAR 
;



variable : tID
    |tNB 
    |fonction
; 


/*comparateur : tOR    {printf("comparateur\n") ;}
    |tAND   {printf("comparateur\n") ;}
    |tLE    {printf("comparateur\n") ;}
    |tGE    {printf("comparateur\n") ;}
    |tEQ    {printf("comparateur\n") ;}
    |tNE    {printf("comparateur\n") ;}
    |tGT    {printf("comparateur\n") ;}
    |tLT    {printf("comparateur\n") ;}
;*/


//Faire même struct pour NB, voir ensuite
calcul : tID {int adrs = findOffset($1) ;
            addTemporaire() ;
            int adrsTempo = lastOffset() ;
            printf("COP %d, %d\n", adrsTempo, adrs);}
    |tNB {int adrs = atoi($1) ;
          addTemporaire() ;
            int adrsTempo = lastOffset() ;
            printf("PUT %d, %d\n", adrsTempo, adrs);}
    |calcul tDIV calcul {int adrs2 = lastOffset(); int adrs1 = adrs2-1 ;
                        printf("DIV %d, %d\n", adrs1, adrs2) ;
                        delTemporaire() ;}
    |calcul tMUL calcul {int adrs2 = lastOffset(); int adrs1 = adrs2-1 ;
                        printf("MUL %d, %d\n", adrs1, adrs2) ;
                        delTemporaire() ;}
    |calcul tSUB calcul {int adrs2 = lastOffset(); int adrs1 = adrs2-1 ;
                        printf("SUB %d, %d\n", adrs1, adrs2) ;
                        delTemporaire() ;}
    |calcul tADD calcul {int adrs2 = lastOffset(); int adrs1 = adrs2-1 ;
                        printf("ADD %d, %d\n", adrs1, adrs2) ;
                        delTemporaire() ;}
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
;


%%

void yyerror(const char *msg) {
  fprintf(stderr, "error: %s\n", msg);
  exit(1);
}

int main(void) {
  yyparse();
}
