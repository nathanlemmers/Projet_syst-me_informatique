%{
#include <stdio.h>
#include <stdlib.h>
#include "./Table_symboles/ts.h"

int label = 0;

/*
%define parse.trace
%verbose
%error-verbose
*/

/*
PUT = Variable, nombre
COP = Variable, Variable
MUL = variable*2
ADD = variable *2
OR = variable*3
LT = variable*3
GT = variable*3
EQU = variable*3
*/
%}



%code provides {
  int yylex (void);
  void yyerror (const char *);


}

%union { char *s; int nb; }

%token <s> tID tNB ;
%token <nb> tIF
%token tELSE tWHILE tPRINT tRETURN tINT tVOID tCOMMA tSEMI tRPAR tLPAR tLBRACE tRBRACE tNOT tOR tAND tASSIGN tLE tGE tEQ tNE tGT tLT tDIV tMUL tSUB tADD tERROR
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
    tIF tLPAR condition tRPAR
        {   $1 = label++;
            printf("JMF %d L%d\n", lastOffset(), $1);
        }
    tLBRACE
        {addProfondeur() ;}
    structure tRBRACE
        {   printf("L%d:\n", $1);
            delProfondeur() ;
            delVariable(getProfondeur())  ;
            delTemporaire() ;
        }
;

condition : condition tOR condition {int adrs2 = lastOffset() ;
                                    int adrs1 = adrs2-1 ;
                                    printf("OR %d, %d, %d\n",adrs1, adrs1, adrs2) ;
                                    delTemporaire() ;
                                    printTable() ;
}
    |condition tAND condition {int adrs2 = lastOffset() ;
                                    int adrs1 = adrs2-1 ;
                                    printf("MUL %d, %d\n", adrs1, adrs2) ;
                                    delTemporaire() ;}
    |condition tLE condition {int adrs2 = lastOffset() ;
                                    int adrs1 = adrs2-1 ;
                                    addTemporaire() ;
                                    int adrs3 = lastOffset() ;
                                    printf("LT %d, %d, %d\n",adrs3, adrs1, adrs2) ;
                                    printf("EQ %d, %d, %d\n",adrs1, adrs1, adrs2) ;
                                    printf("OR %d, %d, %d\n",adrs1, adrs1, adrs3) ;
                                    delTemporaire() ;
                                    delTemporaire() ;}
    |condition tGE condition {int adrs2 = lastOffset() ;
                                    int adrs1 = adrs2-1 ;
                                    addTemporaire() ;
                                    int adrs3 = lastOffset() ;
                                    printf("GT %d, %d, %d\n",adrs3, adrs1, adrs2) ;
                                    printf("EQ %d, %d, %d\n",adrs1, adrs1, adrs2) ;
                                    printf("OR %d, %d, %d\n",adrs1, adrs1, adrs3) ;
                                    delTemporaire() ;
                                    delTemporaire() ;}
    |condition tEQ condition {int adrs2 = lastOffset() ;
                                    int adrs1 = adrs2-1 ;
                                    printf("EQ %d, %d\n", adrs1, adrs2) ;
                                    delTemporaire() ;}
    |condition tNE condition {int adrs2 = lastOffset() ;
                                    int adrs1 = adrs2-1 ;
                                    printf("EQ %d, %d\n", adrs2, adrs1) ;
                                    printf("PUT %d, 1\n", adrs1) ;
                                    printf("SUB %d, %d\n", adrs1, adrs2) ;
                                    delTemporaire() ;}
    |condition tGT condition {int adrs2 = lastOffset() ;
                                    int adrs1 = adrs2-1 ;
                                    printf("GT %d, %d, %d\n", adrs1, adrs1, adrs2) ;
                                    delTemporaire() ;}
    |condition tLT condition {int adrs2 = lastOffset() ;
                                    int adrs1 = adrs2-1 ;
                                    printf("LT %d, %d, %d\n", adrs1, adrs1, adrs2) ;
                                    delTemporaire() ;}
    |tID {int adrs = findOffset($1) ;
            addTemporaire() ;
            int adrsTempo = lastOffset() ;
            printf("COP %d, %d\n", adrsTempo, adrs);}
    |tNB {int adrs = atoi($1) ;
            addTemporaire() ;
            int adrsTempo = lastOffset() ;
            printf("PUT %d, %d\n", adrsTempo, adrs);}
    |tNOT tID {int adrs = findOffset($2) ;
            addTemporaire() ;
            int adrsTempo = lastOffset() ;
            printf("PUT %d, 1\n", adrsTempo) ;
            printf("SUB %d, %d\n", adrsTempo, adrs) ; }
    |tNOT tLPAR condition tRPAR {int adrs = lastOffset() ;
                                addTemporaire() ;
                                int adrs1 = adrs+1 ;
                                printf("COP %d, %d\n", adrs1, adrs) ;
                                printf("PUT %d, 1\n", adrs) ;
                                printf("SUB %d, %d\n", adrs1, adrs1) ;
                                delTemporaire() ;
                                }
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
  //yydebug = 1;
  yyparse();
}
