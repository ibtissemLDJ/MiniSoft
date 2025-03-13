
%{
#include<stdio.h>
%}

%token  MainPrgm idf pnt_virgul var BeginPg accolade_ouvr accolade_ferm EndPg let deux_pnts  const egal virgul float int entier_pos corechet_ouvr corechet_ferm  entier_neg  float_pos float_neg affect chaine if then parenthese_fermante parenthese_ouvrante  input output

%start DEBUT


%%
DEBUT : MainPrgm idf pnt_virgul var DECLARATION BeginPg accolade_ouvr INSTRUCTIONS accolade_ferm EndPg pnt_virgul;

DECLARATION : let VARIABLE1 deux_pnts TYPE1 pnt_virgul | let VARIABLE2 deux_pnts TYPE2 pnt_virgul | const idf deux_pnts TYPE1 egal VALEUR

VALEUR: entier_pos | entier_neg | float_pos | float_neg  

VARIABLE1: idf virgul VARIABLE| idf 

VARIABLE2 : idf

TYPE1 : float | int 

TYPE2 : corechet_ouvr TYPE1 pnt_virgul entier_pos corechet_ferm pnt_virgul

INSTRUCTIONS : idf AFFECTATION_NOR | idf AFFECTATION_TAB | INPUT | OUTPUT | CONDITION | LOOPDO | LOOPFOR 

AFFECTATION_TAB : corechet_ouvr entier_pos corechet_ferm AFFECTATION_NOR

AFFECTATION_NOR : affect VALEUR | affect EXPRESION 

EXPRESION : 

INPUT : input parenthese_ouvrante idf parenthese_fermante pnt_virgul

OUTPUT : output parenthese_ouvrante DANS_OUTPUT parenthese_fermante pnt_virgul 

DANS_OUTPUT: chaine | idf | chaine virgul DANS_OUTPUT | idf vergule DANS_OUTPUT

CONDITION : if parenthese_ouvrante EXPRESSION_COND parenthese_fermante then accolade_ouvr ---------------- SINON

SINON : accolade_ferm | 

EXPRESSION_COND : 

LOOPDO : 

LOOPFOR :


%%
int main() {
    yyparse();
    return 0;
}
yywrap()
{}
int yyerror(char *msg)
{ printf(" Erreur syntaxique");
return 1;
}