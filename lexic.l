


%{

#include<stdio.h>
#include<string.h>
# include "syntax.tab.h"
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

MainPrgm {printf("mot cle : %s \n",yytext); return MainPrgm ;}
Var {printf("mot cle : %s \n",yytext); return var;}
BeginPg {printf("mot cle : %s \n",yytext); return BeginPg ;}
EndPg {printf("mot cle : %s \n",yytext); return EndPg ;}
let {printf("mot cle : %s \n",yytext); return let ;}
AND {printf("operateur : %s \n",yytext); return and ;}
OR {printf("operateur : %s \n",yytext); return or ;}
if {printf("mot cle : %s \n",yytext); return if ;}
then {printf("mot cle : %s \n",yytext); return then ;}
step {printf("mot cle : %s \n",yytext); return step ;}
do {printf("mot cle : %s \n",yytext); return do ;}
while {printf("mot cle : %s \n",yytext); return while ;}
for {printf("mot cle : %s \n",yytext); return for ;}
from {printf("mot cle : %s \n",yytext); return from ;}
to {printf("mot cle : %s \n",yytext); return to ;}
else {printf("mot cle : %s \n",yytext); return else ;}
int {printf("mot cle : %s \n",yytext); return int ;}
float {printf("mot cle : %s \n",yytext); return float ;}
input {printf("mot cle : %s \n",yytext); return input ;}
output {printf("mot cle : %s \n",yytext); return output ;}
"@define const" {printf("declaration const \n"); return const}


{chaine} {printf("chain de car: %s \n",yytext); return chaine ;}
{commentaire_une_ligne} {printf("un commentaire une ligne \n"); return comment_une ;}
{commentaire_plusieurs_lignes} { return comment_plsr ;
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
    {printf ("erreur lexicale : le IDF depasse 14 caracteres \n"); return idf ;}
    else{
    printf("idf : %s \n",yytext);}
} 
{entier_non_signer} { printf("entier positif\n"); return entier_pos}

{entier_signer} {
        char *varstr=strdup(yytext+1);
        varstr[strlen(varstr)-1]='\0';
        int valeur= atoi(varstr);
          if (valeur >= -32768 && valeur <= 32767) {
        if (valeur < 0) {
            printf("entier signe negatif \n");  return entier_neg ;
        } else {
            printf("entier  signe positif \n"); return entier_neg ;
        }
    } else {
        printf("erreur : le nombre n'est pas dans la plage des valeurs\n");
    }
}


{reel_non_signer} { printf("reel non signe positif\n"); return reel_pos ;}
{reel_signer} {
        char *varstr = strdup(yytext+ 1); 
        varstr[strlen(varstr) - 1] = '\0';
        double valeur = strtod(varstr, NULL);

        if (valeur < 0) {
            printf("reel signe negatif\n"); return reel_neg ; 
        } else {
            printf("reel signe positif \n");  return reel_pos ;
        }
}

! {printf("operateur : negation \n" ); return neg ;}
; {printf("pvg\n"); return pnt_virgul ;}
: {printf("deux points \n"); return deux_pnts ;}
, {printf("le vergule \n"); return virgul ;}
"("  {printf("parenthese_ouvrante \n"); return parenthese_ouvr ;}
")" {printf("parenthese_fermante \n"); return parenthese_ferm ;}  
"{" {printf("accolade_ouvrante \n"); return accolade_ouvr ;}
"}" {printf("accolade_fermante \n"); return accolade_ferm ;}
"-" {printf("soustract \n"); return soustract ;}
"+" {printf("addition \n"); return add ;}
"*" {printf("multiplication \n"); return multipl ;}
"/" {printf("division \n"); return div ;}
":=" {printf("affectation \n"); return affect ;}
\"  {printf("Guillemets \n"); }
"[" {printf("corechets ouvrante \n"); return corechet_ouvr ;}
"]" {printf("corechets fermente \n"); return corechet_ferm ;}
"=" { printf("egale\n"); return egal ;}

"<" {printf("inferieur \n"); return inf ;}
">" {printf("superieur \n"); return sup ;}
">=" {printf("superieur_ou_egale \n"); return sup_ou_egal ;}
"<=" {printf("inferieur_ou_egae \n"); return inf_ou_egal ;}
"==" {printf("egale \n"); return identiq ;}
"!=" {printf("different_de \n"); return diff ;}

[ \t] {printf("espace \n");}



. {printf("erreur lexicale a la ligne %d \n", num_de_lignes);} 

%%
int main(){
    yylex();
    return 0;
}