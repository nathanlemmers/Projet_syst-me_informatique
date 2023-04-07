#include <stdio.h>
#include <stdlib.h>
#include "ts.h"

//Renvoie 0 si PAS initialisé, 1 sinon
int isInit(char* name) {
    pile *t = p ;
    if(p->contenu.nom==name) {
        p = t ;
        if(p->contenu.init!=0) {
            return 1 ;
        }
    }
    while(p->suivant!= NULL) {
        if(p->suivant->contenu.nom == name) {
            p = t ;
            if (p->suivant->contenu.init!=0){
                return 1 ;
            }
        }
        p = p->suivant ;
    }
    p = t ;
    return 0 ;
}

void addVariable(char* n, int i,int type, int profondeur) {
    pile *t = p ;
    if (p==NULL) {
        contenu c= {nom:n , init:i , profondeur:profondeur , offset: 0,  type : type} ;
        p= malloc(sizeof(pile)) ;
        p->contenu = c ;
        p->suivant = NULL ;
    }
    else {
        while(p->suivant!=NULL) {
            p = p->suivant ;
        }
        int o = p->contenu.offset ;
        contenu c= {nom:n , init:i , profondeur:profondeur , offset: o+1,  type : type} ;
        p->suivant = malloc(sizeof(pile)) ;
        p->suivant->contenu = c ;
        p->suivant->suivant = NULL ;
        p = t ;
    }
}

void delVariable(int profondeur) {
    int i = 0 ;
    if (p->contenu.profondeur>profondeur) {
        p = p->suivant ;
        i ++ ;
    }
    pile* t = p ;
    while(p->suivant!=NULL) {
        pile* s = p->suivant ;
        s->contenu.offset = s->contenu.offset - i ;
        if (s->contenu.profondeur>profondeur) {
            p->suivant = s->suivant ;
            free(s) ;
            i ++ ;
        }
        else {
            p = p->suivant ;
        }
    }
    p = t ;
}


int findOffset(char* name) {
    pile *t = p ;
    if(p->contenu.nom==name) {
        p = t ;
        return p->contenu.offset ;
    }
    while(p->suivant!= NULL) {
        if(p->suivant->contenu.nom == name) {
            p = t ;
            return p->suivant->contenu.offset ;
        }
        p = p->suivant ;
    }
    p = t ;
    return -1 ;
}

//Renvoie 1 si ça a fonctionné, -1 sinon
int initialiser(char* name) {
    if (isInit(name)==0) {
        if(p->contenu.nom==name) {
            p->contenu.init = 1 ;
            return 1 ;
        }
        pile *t = p ;
        while(p->suivant!= NULL) {
            if(p->suivant->contenu.nom == name) {
                p->suivant->contenu.init = 1 ;
                p = t ;
                return 1 ;
            }
            p = p->suivant ;
        }
        p = t ;
        return -1 ;
    } else {
        return 1 ;
    }
    
}

void printTable() {
    pile* t= p ;
    if(t!=NULL) {
        printf("nom : %s ; init : %i ; profondeur : %i ; offset : %i \n",t->contenu.nom, t->contenu.init, t->contenu.profondeur, t->contenu.offset) ;
        while(t->suivant!=NULL) {
            t = t->suivant ;
            printf("nom : %s ; init : %i ; profondeur : %i ; offset : %i \n",t->contenu.nom, t->contenu.init, t->contenu.profondeur, t->contenu.offset) ;
        }
    }
}


void delTemporaire() {
    pile *t = p  ;
    if(t->suivant == NULL) {
        p = NULL ;
    } 
    else {
        while(t->suivant->suivant!=NULL) {
            t = t->suivant ;
        }
        t->suivant = NULL ;  
    }
}


void addTemporaire() {
    addVariable("", 1, 0, 0) ;
}

int lastOffset() {
    pile *t = p  ;
    int i = 0 ;
    while(t->suivant!=NULL) {
        i ++;
        t = t->suivant ;
    }  
    return i ;
}