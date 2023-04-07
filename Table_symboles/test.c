#include "ts.h" 

#include <stdio.h>
#include <stdlib.h>


int main(int argc, char** argv){
    addVariable("a", 1, 0, 0) ;
    addVariable("b", 0, 0, 1) ;
    addVariable("c", 0, 0, 0) ;
    addVariable("d", 1, 0, 1) ;

    int b = isInit("a") ;
    int b1 = isInit("b") ;
    printf("1 = %i\n", b) ;
    printf("0 = %i\n", b1) ;

    int b3 = initialiser("b") ;
    printf("%i = %i\n",b3 , isInit("b")) ;

    printf("Offset est de 0 = %i\n", findOffset("a")) ;
    printf("Offset est de 1 = %i\n", findOffset("b")) ;
    printf("Offset est de 0 = %i\n", findOffset("a")) ;

    delTemporaire() ;

    printTable() ;
}