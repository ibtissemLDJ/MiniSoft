
%{
#include<stdio.h>

%}

%token  MainPrgm var BeginPg EndPg let AND OR if then step do while for from to else int float input output const chiffre chaine comment_une comment_plsr idf exclamation pnt_virgul deux_pnts virgul par_ouvr par_ferm accolade_ouvr accolade_ferm soustract addition multipl division affect Guillemets inf sup inf_egal sup_egal egal diff {printf ("synatxe correcte"); YYACCEPT;}
%start debut
debut : MainPrgm idf pnt_virgul var declaration BeginPg accolade_ouvr instructions accolade_ferm EndPg pnt_virgul ; 
declaration : let variables deux_pnts type pnt_virgul;
variables: idf virgul variables| idf 
type : float | int |corechet_ouvr type pnt_virgul corechet_ferm
instructions :
%%
debut : MainPrgm | declaration | 


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