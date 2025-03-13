
%{
#include<stdio.h>
%}

%token  MainPrgm idf pnt_virgul var BeginPg accolade_ouvr accolade_ferm EndPg let deux_pnts const egal virgul float int entier_pos corechet_ouvr corechet_ferm entier_neg float_pos float_neg affect chaine if then parenthese_fermante parenthese_ouvrante input output add soustract div multipl inf sup inf_ou_egal sup_ou_egal neg and or diff for from to step do while comment_une comment_plsr else reel_pos reel_neg identiq 

%start DEBUT
 

%%
DEBUT : MainPrgm idf pnt_virgul var DECLARATION BeginPg accolade_ouvr INSTRUCTIONS accolade_ferm EndPg pnt_virgul;

DECLARATION : let VARIABLE1 deux_pnts TYPE1 pnt_virgul | let idf deux_pnts TYPE2 pnt_virgul | const idf deux_pnts TYPE1 egal VALEUR ;

VALEUR: entier_pos | entier_neg | float_pos | float_neg  ;

VARIABLE1: idf virgul VARIABLE1 | idf ;



TYPE1 : float | int ;

TYPE2 : corechet_ouvr TYPE1 pnt_virgul entier_pos corechet_ferm pnt_virgul ;

INSTRUCTIONS :  | idf AFFECTATION_NOR INSTRUCTIONS | idf AFFECTATION_TAB INSTRUCTIONS | INPUT INSTRUCTIONS | OUTPUT INSTRUCTIONS | CONDITION INSTRUCTIONS | LOOP_DO INSTRUCTIONS | LOOP_FOR INSTRUCTIONS ;

AFFECTATION_TAB : corechet_ouvr entier_pos corechet_ferm AFFECTATION_NOR ;

AFFECTATION_NOR : affect EXPRESSION pnt_virgul ;


EXPRESSION :  parenthese_ouvrante EXPRESSION parenthese_fermante | EXPRESSION OPERATEUR_ARITHM EXPRESSON | OPERAND | VALEUR ;

OPERAND : idf | VALEUR | neg OPERAND ;

OPERATEUR_ARITHM : add | soustract | div | multipl ;

INPUT : input parenthese_ouvrante idf parenthese_fermante pnt_virgul ;

OUTPUT : output parenthese_ouvrante DANS_OUTPUT parenthese_fermante pnt_virgul ;

DANS_OUTPUT: chaine | idf | chaine virgul DANS_OUTPUT | idf virgul DANS_OUTPUT ;

CONDITION : if parenthese_ouvrante EXPRESSION_COND parenthese_fermante then accolade_ouvr INSTRUCTIONS accolade_fermante SINON ; 

SINON : else accolade_ouvr INSTRUCTIONS accolade_ferm |  ;

EXPRESSION_COND : OPERAND OPERATEUR_COND OPERAND | EXPRESSION_COND and EXPRESSION_COND | EXPRESSION_COND or EXPRESSION_COND ;   

OPERATEUR_COND : inf | sup | inf_ou_egal | sup_ou_egal | identiq | diff ;

LOOP_DO : do accolade_ouvr INSTRUCTIONS accolade_ferm while parenthese_ouvrante EXPRESSION_COND parenthese_fermante pnt_virgul ;

LOOP_FOR : for idf from entier_pos to entier_pos step entier_pos accolade_ouvr INSTRUCTIONS accolade_ferm ; 

%%
int main() {
    yyparse();

}
yywrap()
{}
int yyerror(char *msg)
{ 
    printf(" Erreur syntaxique a la ligne %s " , num_de_lignes);
}