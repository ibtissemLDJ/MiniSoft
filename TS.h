typedef struct {
    int state; 
    char name[20];
    char code[20];
    char type[20];
    char  val[20];
}TS_IDF ;

typedef struct
{ 
    int state;
    char nomEntite[20];
    char Code[20];
} TS_MCS;
extern TS_IDF TIDF[200];
extern TS_MCS TSS[50], TSM[50];

