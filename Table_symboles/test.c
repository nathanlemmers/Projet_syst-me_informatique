#include "ts.h" 

#include <stdio.h>
#include <stdlib.h>


int main(int argc, char** argv){
    addVariable("a", 1,0, 0) ;
    addVariable("b", 0,0, 0) ;
    addVariable("c", 5,0, 1) ;
    addVariable("d", 1,0, 1) ;

    int b = isInit("a") ;
    int b1 = isInit("b") ;
    printf("1 = %i\n", b) ;
    printf("0 = %i\n", b1) ;

    printf("Offset est de 0 = %i\n", findOffset("a")) ;
    printf("Offset est de 1 = %i\n", findOffset("b")) ;
    printf("Offset est de 0 = %i\n", findOffset("a")) ;

    delVariable(0) ;

    pile* t= p ;
    if(t!=NULL) {
        printf("nom : %s\n",t->contenu.nom) ;
        while(t->suivant!=NULL) {
            t = t->suivant ;
            printf("nom : %s\n",t->contenu.nom) ;
        }
    }
}