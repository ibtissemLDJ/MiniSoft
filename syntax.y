%{
#include<stdio.h>
#include "fonction.h"

extern int num_de_lignes;
int nb_ligne=1;
int col=1;
void yyerror(char *msg);
%}
%union {
int entier;
char* str;
float reel;
}
%token MainPrgm <str>idf pnt_virgul var BeginPg accolade_ouvr accolade_ferm EndPg let deux_pnts constante egal virgul reel entier <entier>entier_pos corechet_ouvr corechet_ferm <entier>entier_neg <reel>reel_pos <reel>reel_neg affect <str>chaine if_cond then parenthese_ferm parenthese_ouvr lire output add soustract division multipl inf sup inf_ou_egal sup_ou_egal neg and or diff boucle_for from to step boucle_do boucle_while comment_une comment_plsr else_cond  identiq Guillemets 

%start DEBUT

%left or 
%left and 
%left neg 
%left inf sup sup_ou_egal inf_ou_egal identiq diff 
%left add soustract 
%left multipl division
 

%%
DEBUT : MainPrgm idf pnt_virgul var DECLARATION BeginPg accolade_ouvr INSTRUCTIONS accolade_ferm EndPg pnt_virgul
{ Rechercher($2, "IDF", "", "", 1);
  printf ("Programme syntaxiquement correcte . \n"); YYACCEPT;};
DECLARATION : let VARIABLE1 deux_pnts TYPE1 pnt_virgul | let idf deux_pnts TYPE2 pnt_virgul{Rechercher($2, "IDF", "", "", 1);} | constante idf deux_pnts TYPE1 egal VALEUR ;

VALEUR: entier_pos | entier_neg | reel_pos | reel_neg  ;

VARIABLE1: idf virgul VARIABLE1 | idf ;

TYPE1 : reel | entier ;

TYPE2 : corechet_ouvr TYPE1 pnt_virgul entier_pos corechet_ferm pnt_virgul ;

INSTRUCTIONS :  | idf AFFECTATION_NOR INSTRUCTIONS {if (rechercher_idf($1)==0){printf("Erreur semantique: %s non declare a la ligne %d\n",$1,nb_ligne);}}| idf AFFECTATION_TAB INSTRUCTIONS | INPUT INSTRUCTIONS | OUTPUT INSTRUCTIONS | CONDITION INSTRUCTIONS | LOOP_DO INSTRUCTIONS | LOOP_FOR INSTRUCTIONS ;

AFFECTATION_TAB : corechet_ouvr entier_pos corechet_ferm AFFECTATION_NOR ;

AFFECTATION_NOR : affect EXPRESSION pnt_virgul ;

EXPRESSION :  parenthese_ouvr EXPRESSION parenthese_ferm | EXPRESSION OPERATEUR_ARITHM EXPRESSION | OPERAND | VALEUR ;

OPERAND : idf | VALEUR | neg OPERAND ;

OPERATEUR_ARITHM : add | soustract | division | multipl ;

INPUT : lire parenthese_ouvr idf parenthese_ferm pnt_virgul ;

OUTPUT : output parenthese_ouvr DANS_OUTPUT parenthese_ferm pnt_virgul ;

DANS_OUTPUT: chaine | idf | chaine virgul DANS_OUTPUT | idf virgul DANS_OUTPUT ;

CONDITION : if_cond parenthese_ouvr EXPRESSION_COND parenthese_ferm then accolade_ouvr INSTRUCTIONS accolade_ferm SINON ; 

SINON : else_cond accolade_ouvr INSTRUCTIONS accolade_ferm |  ;

EXPRESSION_COND : OPERAND OPERATEUR_COND OPERAND | EXPRESSION_COND and EXPRESSION_COND | EXPRESSION_COND or EXPRESSION_COND ;   

OPERATEUR_COND : inf | sup | inf_ou_egal | sup_ou_egal | identiq | diff ;

LOOP_DO : boucle_do accolade_ouvr INSTRUCTIONS accolade_ferm boucle_while parenthese_ouvr EXPRESSION_COND parenthese_ferm pnt_virgul ;

LOOP_FOR : boucle_for idf from entier_pos to entier_pos step entier_pos accolade_ouvr INSTRUCTIONS accolade_ferm ; 



%%
int main() {
    initialization();
    yyparse();
    afficher();
}
yywrap()
{}
int yyerror(char *msg)
{ 
    printf(" Erreur syntaxique a la ligne %s " , num_de_lignes);
}