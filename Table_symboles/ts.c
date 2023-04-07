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
    if (p->contenu.profondeur>profondeur) {
        p = p->suivant ;
    }
    pile* t = p ;
    while(p->suivant!=NULL) {
        pile* s = p->suivant ;
        if (s->contenu.profondeur>profondeur) {
            p->suivant = s->suivant ;
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


