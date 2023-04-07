
typedef struct contenu {
    char* nom ;
    int init ;
    int profondeur ;
    int offset ;
    int type ;
}  contenu ;


typedef struct pile {
    contenu contenu ;
    struct pile* suivant ;
} pile ;

pile* p ;


void addVariable(char* nom, int init, int type , int profondeur) ;

int isInit(char* nom) ;

void delVariable(int profondeur) ;

int findOffset(char* name) ;

int initialiser(char* name) ;

void printTable() ;

void delTemporaire() ;

void  addTemporaire() ;

int lastOffset() ;