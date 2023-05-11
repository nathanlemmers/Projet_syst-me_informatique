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
JMF = variable(boolean), label de saut ON SAUTE SI C'EST FAUX, DONC variable=0
*/

//Vérifier si le déclage du pointeur de pile doit pas etre de 1 de plus !
%}

%define parse.error verbose

%code provides {
  int yylex (void);
  void yyerror (const char *);


}

%union { char *s; int nb; }

%token <s> tID tNB ;
%token <nb> tIF tLBRACE tWHILE
%token tELSE tPRINT tRETURN tINT tVOID tCOMMA tSEMI tRPAR tLPAR tRBRACE tNOT tOR tAND tASSIGN tLE tGE tEQ tNE tGT tLT tDIV tMUL tSUB tADD tERROR
%left tADD tSUB tOR tAND
%left tMUL tDIV tLE tGE tEQ tNE tGT tLT
%type <nb> si sinon
%%

totals : total
    |totals total
;

total :
    tVOID
        { addProfondeur() ;
          addVariable("!retadr", 0, 0, getProfondeur()) ;
          addVariable("!retval", 0, 0, getProfondeur()) ;
        } 
    tID {printf(":%s\n", $3) ;}
    tLPAR arguments tRPAR tLBRACE structure tRBRACE
    {printf("RET\n") ;  delProfondeur() ; delVariable() ;}

    |tINT 
    {addProfondeur() ;
    addVariable("!retadr", 0, 0, getProfondeur()) ;
    addVariable("!retval", 0, 0, getProfondeur()) ;} 
    tID { printf(":%s\n", $3) ; } tLPAR arguments tRPAR tLBRACE structure retour tRBRACE {printf("RET\n") ; delProfondeur() ; delVariable() ;}
; 

retour : tRETURN calcul tSEMI { printf("COP 0, %d\n", lastOffset()) ; 
                                delTemporaire();
                                initialiser("!retval") ;} 
;

arguments : argument
    |arguments tCOMMA argument
    |tVOID
;

argument : tINT tID {addVariable($2, 0, 0, 1) ;}
;


structure :
     contenu structure
    | contenu
;

contenu : 
    action 
    |Sicomplet
    |tandis
;


Sicomplet : si {printf("L%d:\n", $1);} 
    |si {int i = $1 ;
        $1 = label++ ;
        printf("JMF #0 L%d\n", $1);
        printf("L%d:\n", i);
        } 
    sinon 
        {printf("L%d:\n", $1) ;}
;

tandis : tWHILE tLPAR {$1 = label++ ;
            printf("L%d\n", $1) ;}
        condition tRPAR tLBRACE 
            {$6 = label++ ;
            printf("JMF %d L%d\n", lastOffset(), $6);
            }
        structure tRBRACE {delProfondeur() ; 
            delVariable()  ;
            printf("JMF #0 L%d\n", $1) ;
            printf("L%d\n", $6) ;
        }
;


sinon : tELSE tLBRACE {addProfondeur() ;} structure tRBRACE {delProfondeur() ; delVariable()  ;}
;

si : 
    tIF tLPAR condition tRPAR
        {   $1 = label++;
            printf("JMF %d L%d\n", lastOffset(), $1);
        }
    tLBRACE
        {addProfondeur() ;}
    structure tRBRACE
        {   delProfondeur() ;
            delVariable()  ;
            delTemporaire() ;
            $$ = $1 ;
        }
;

condition : condition tOR condition {int adrs2 = lastOffset() ;
                                    int adrs1 = adrs2-1 ;
                                    printf("OR %d, %d, %d\n",adrs1, adrs1, adrs2) ;
                                    delTemporaire() ;
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
                                    printf("PUT %d, #1\n", adrs1) ;
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
            printf("PUT %d, #%d\n", adrsTempo, adrs);}
    |tNOT tID {int adrs = findOffset($2) ;
            addTemporaire() ;
            int adrsTempo = lastOffset() ;
            printf("PUT %d, #1\n", adrsTempo) ;
            printf("SUB %d, %d\n", adrsTempo, adrs) ; }
    |tNOT tLPAR condition tRPAR {int adrs = lastOffset() ;
                                addTemporaire() ;
                                int adrs1 = adrs+1 ;
                                printf("COP %d, %d\n", adrs1, adrs) ;
                                printf("PUT %d, #1\n", adrs) ;
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
            printf("PUT %d, #%d\n", adrsTempo, adrs);}
    | fonction
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

fonction : tID tLPAR 
        { addProfondeur();
          $<nb>2 = lastOffset();
          addVariable("!retadr'", 0, 0, getProfondeur()) ;
          addVariable("!retval'", 0, 0, getProfondeur()) ;
        }
        agrvs tRPAR
        { delProfondeur();
          delVariable();
          printf("ADDBP %d\n", $<nb>2);
          printf("CALL %s\n", $1) ;
          printf("SUBBP %d\n", $<nb>2);
          addTemporaire();
          printf("COP %d, %d\n", lastOffset(), lastOffset() + 1);
        } ;

agrvs : 
    |agrv
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
