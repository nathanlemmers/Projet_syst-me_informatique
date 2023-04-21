#include <stdio.h>
#include <stdlib.h>
#include "ts.h"
#include <string.h>


pile* p = NULL;
int profondeur = 1 ;

//Renvoie 0 si PAS initialisé, 1 sinon
int isInit(char* name) {
    if (p == NULL) return 0;
    pile *t = p ;
    if(strcmp(p->contenu.nom,name)==0) {
        p = t ;
        if(p->contenu.init!=0) {
            return 1 ;
        }
    }
    while(p->suivant!= NULL) {
        if(strcmp(p->suivant->contenu.nom, name)==0) {
            p = t ;
            return (p->suivant->contenu.init!=0);
        }
        p = p->suivant ;
    }
    p = t ;
    return 0 ;
}

void addVariable(char* n, int i,int type, int profondeur) {
    if (strcmp(n,"")==0 || exist(n)==0) {
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
    } else {
        printf("WARNING : La variable %s existe déja, impossible de la créer, elle n'a pas été modifié\n", n) ;
    }
}

int exist(char*n) {
    pile* t= p ;
    if (t!=NULL) {
        if(strcmp(t->contenu.nom, n)==0){
            return 1 ;
        }
        while(t->suivant!=NULL) {
            t=t->suivant ;
            if(strcmp(t->contenu.nom, n)==0){
            return 1 ;
            }
        }
    }
    return 0 ;
}



void delVariable() {
    pile **n = &p;
    while (*n && (*n)->contenu.profondeur <= profondeur) {
        n = &((*n)->suivant);
    }
    while (*n) {
        pile **s = &((*n)->suivant);
        free(*n);
        *n = NULL;
        n = s;
    }
}


int findOffset(char* name) {
    pile *t = p ;
    if(strcmp(t->contenu.nom, name)==0) {
        return t->contenu.offset ;
    }
    while(t->suivant!= NULL) {
        if(strcmp(t->suivant->contenu.nom, name)==0) {
            return t->suivant->contenu.offset ;
        }
        t = t->suivant ;
    }
    return -1 ;
}

//Renvoie 1 si ça a fonctionné, -1 sinon
int initialiser(char* name) {
    if (isInit(name)==0) {
        if(strcmp(p->contenu.nom,name)==0) {
            p->contenu.init = 1 ;
            return 1 ;
        }
        pile *t = p ;
        while(p->suivant!= NULL) {
            if(strcmp(p->suivant->contenu.nom, name)==0) {
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


void init(int offset) {
    pile*t = p ;
    if (t->contenu.offset==offset) {
        t->contenu.init=1 ;
    } else {
        while(t->suivant!=NULL) {
            t = t->suivant ;
            if (t->contenu.offset==offset) {
                t->contenu.init=1 ;
                break ;
            }
        }
    }
}

void printTable() {
    printf("TABLE:\n");
    pile* t= p ;
    if(t!=NULL) {
        printf("nom : %s ; init : %i ; profondeur : %i ; offset : %i \n",t->contenu.nom, t->contenu.init, t->contenu.profondeur, t->contenu.offset) ;
        while(t->suivant!=NULL) {
            t = t->suivant ;
            printf("nom : %s ; init : %i ; profondeur : %i ; offset : %i \n",t->contenu.nom, t->contenu.init, t->contenu.profondeur, t->contenu.offset) ;
        }
    }
    printf("\n");
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
    addVariable("", 1, 0, profondeur) ;
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




int getProfondeur() {
    return profondeur ;
}

void addProfondeur(){
    profondeur++ ;
}

void delProfondeur(){
    profondeur--;
}
