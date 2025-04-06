%{

#include<stdio.h>
#include<string.h>
# include "syntax.tab.h"
#include "fonction.h"

extern YYSTYPE yylval;
int num_de_lignes = 1 ;


%}


lettre [a-zA-Z]

chaine \"[^\"]*\"
commentaire_une_ligne "<!-"[^\n]*"-!>"
commentaire_plusieurs_lignes "{--"(.|\n)*"--}" 
idf {lettre}([a-z0-9]*_?[a-z0-9])*
entier_non_signer ([1-9][0-9]*|0)
entier_signer "("[-+]?[0-9]+")"
reel_non_signer ([1-9]*|0)(".")([0-9]+)
reel_signer "("[-+]?([1-9]*|0)(".")([0-9]+)")"


%%

\n {
    num_de_lignes++ ; 
    printf("le nombre de linge : %d \n",num_de_lignes);
    }

MainPrgm {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return MainPrgm ;}
Var {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2);return var;}
BeginPg {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return BeginPg ;}
EndPg {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return EndPg ;}
let {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return let ;}
AND {printf("operateur : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return and ;}
OR {printf("operateur : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return or ;}
if {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return if_cond ;}
then {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return then ;}
step {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return step ;}
do {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return boucle_do ;}
while {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return boucle_while ;}
for {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return boucle_for ;}
from {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return from ;}
to {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return to ;}
else {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return else_cond ;}
int {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return entier ;}
float {printf("mot cle : %s \n",yytext);recherche(yytext, "MotCle", "", "", 2); return reel ;}
input {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2); return lire ;}
output {printf("mot cle : %s \n",yytext); recherche(yytext, "MotCle", "", "", 2);return output ;}
"@define const" {printf("declaration const \n"); recherche(yytext, "CST", "", yytext, 1);   return constante ;}


{chaine} {printf("chain de car: %s \n",yytext);  yylval.str=strdup(yytext); return chaine ;}
{commentaire_une_ligne} {printf("un commentaire une ligne \n");}
{commentaire_plusieurs_lignes} { 
    printf("un commentaire plusieurs lignes \n");
    char *varchar = strdup(yytext);
    int j;  
    for (j = 0; varchar[j] != '\0'; j++) { 
        if (varchar[j] == '\n') {
            num_de_lignes++;
        }
    }
    
}
{idf} { if (yyleng > 14) 
    {printf ("erreur lexicale : le IDF depasse 14 caracteres \n"); }
    else{
    printf("idf : %s \n",yytext);
    yylval.str=strdup(yytext);
    return idf ;}
} 
{entier_non_signer} { printf("entier positif\n"); yylval.entier=atoi(yytext); return entier_pos ;}

{entier_signer} {
        char *varstr=strdup(yytext+1);
        varstr[strlen(varstr)-1]='\0';
        int valeur= atoi(varstr);
            if (valeur >= -32768 && valeur <= 32767) {
        if (valeur < 0) {
            printf("entier signe negatif \n"); yylval.entier=atoi(yytext); return entier_neg ;
        } else {
            printf("entier  signe positif \n"); yylval.entier=atoi(yytext); return entier_neg ;
        }
    } else {
        printf("erreur : le nombre n'est pas dans la plage des valeurs\n");
    }
}


{reel_non_signer} { printf("reel non signe positif\n"); yylval.reel=atof(yytext); return reel_pos ;}
{reel_signer} {
        char *varstr = strdup(yytext+ 1); 
        varstr[strlen(varstr) - 1] = '\0';
        double valeur = strtod(varstr, NULL);

        if (valeur < 0) {
            printf("reel signe negatif\n"); yylval.reel=atof(yytext); return reel_neg ; 
        } else {
            printf("reel signe positif \n"); yylval.reel=atof(yytext); return reel_pos ;
        }
}

! {printf("operateur : negation \n" );  recherche(yytext, "Separateur", "", "", 3); return neg ;}
; {printf("pvg\n");  recherche(yytext, "Separateur", "", "", 3); return pnt_virgul ;}
: {printf("deux points \n");  recherche(yytext, "Separateur", "", "", 3); return deux_pnts ;}
, {printf("le vergule \n");  recherche(yytext, "Separateur", "", "", 3); return virgul ;}
"("  {printf("parenthese_ouvrante \n");  recherche(yytext, "Separateur", "", "", 3); return parenthese_ouvr ;}
")" {printf("parenthese_fermante \n");  recherche(yytext, "Separateur", "", "", 3); return parenthese_ferm ;}  
"{" {printf("accolade_ouvrante \n");  recherche(yytext, "Separateur", "", "", 3); return accolade_ouvr ;}
"}" {printf("accolade_fermante \n");  recherche(yytext, "Separateur", "", "", 3); return accolade_ferm ;}
"-" {printf("soustract \n");  recherche(yytext, "Separateur", "", "", 3); return soustract ;}
"+" {printf("addition \n");  recherche(yytext, "Separateur", "", "", 3); return add ;}
"*" {printf("multiplication \n"); recherche(yytext, "Separateur", "", "", 3); return multipl ;}
"/" {printf("division \n");  recherche(yytext, "Separateur", "", "", 3); return division ;}
":=" {printf("affectation \n");  recherche(yytext, "Separateur", "", "", 3); return affect ;}
\"  {printf("Guillemets \n");  recherche(yytext, "Separateur", "", "", 3); return Guillemets ;}
"[" {printf("corechets ouvrante \n"); recherche(yytext, "Separateur", "", "", 3); return corechet_ouvr ;}
"]" {printf("corechets fermente \n"); recherche(yytext, "Separateur", "", "", 3); return corechet_ferm ;}
"=" { printf("egale\n"); recherche(yytext, "Separateur", "", "", 3); return egal ;}

"<" {printf("inferieur \n"); recherche(yytext, "Separateur", "", "", 3); return inf ;}
">" {printf("superieur \n"); recherche(yytext, "Separateur", "", "", 3); return sup ;}
">=" {printf("superieur_ou_egale \n"); recherche(yytext, "Separateur", "", "", 3); return sup_ou_egal ;}
"<=" {printf("inferieur_ou_egae \n"); recherche(yytext, "Separateur", "", "", 3); return inf_ou_egal ;}
"==" {printf("egale \n"); recherche(yytext, "Separateur", "", "", 3); return identiq ;}
"!=" {printf("different_de \n"); recherche(yytext, "Separateur", "", "", 3); return diff ;}

[ \t] {printf("espace \n");}



. {printf("erreur lexicale a la ligne %d \n", num_de_lignes);} 

%%
int main(){
    yylex();
    return 0;
}
