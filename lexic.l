
%{

#include<stdio.h>
#include<string.h>
int num_de_lignes = 1 ;

%}


lettre [a-zA-Z]
chiffre [0-9]
chaine \"[^\"]*\"
commentaire_une_ligne "<!-"[^\n]*"-!>"
commentaire_plusieurs_lignes "{--"(.|\n)*"--}" 
idf {lettre}([a-z0-9]*_?[a-z0-9])*
entier_non_signer ([1-9][0-9]*|0)
entier_signer "("[-+]?[0-9]+")"
reel_non_signer ([1-9]*|0)(".")([0-9]+)
reel_signer "("[-+]?([1-9]*|0)(".")([0-9]+)")"


%%

\n {num_de_lignes++ ;  printf("le nombre de linge : %d \n",num_de_lignes);}

MainPrgm {printf("mot cle : %s \n",yytext);}
Var {printf("mot cle : %s \n",yytext);}
BeginPg {printf("mot cle : %s \n",yytext);}
EndPg {printf("mot cle : %s \n",yytext);}
let {printf("mot cle : %s \n",yytext);}
AND {printf("operateur : %s \n",yytext);}
OR {printf("operateur : %s \n",yytext);}
if {printf("mot cle : %s \n",yytext);}
then {printf("mot cle : %s \n",yytext);}
step {printf("mot cle : %s \n",yytext);}
do {printf("mot cle : %s \n",yytext);}
while {printf("mot cle : %s \n",yytext);}
for {printf("mot cle : %s \n",yytext);}
from {printf("mot cle : %s \n",yytext);}
to {printf("mot cle : %s \n",yytext);}
else {printf("mot cle : %s \n",yytext);}
int {printf("mot cle : %s \n",yytext);}
float {printf("mot cle : %s \n",yytext);}
input {printf("mot cle : %s \n",yytext);}
output {printf("mot cle : %s \n",yytext);}
"@define const" {printf("declaration const \n");}


{chiffre} {printf("chiffre \n");
}
{chaine} {printf("chain de car: %s \n",yytext);}
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
    {printf ("erreur lexicale : le IDF depasse 14 caracteres \n");}
    else{
    printf("idf : %s \n",yytext);}
} 
{entier_non_signer} { printf("entier positif\n"); }

{entier_signer} {
        char *varstr=strdup(yytext+1);
        varstr[strlen(varstr)-1]='\0';
        int valeur= atoi(varstr);
          if (valeur >= -32768 && valeur <= 32767) {
        if (valeur < 0) {
            printf("entier signe negatif \n"); 
        } else {
            printf("entier  signe positif \n"); 
        }
    } else {
        printf("erreur : le nombre n'est pas dans la plage des valeurs\n");
    }
}


{reel_non_signer} { printf("reel non signe positif\n"); }
{reel_signer} {
        char *varstr = strdup(yytext+ 1); 
        varstr[strlen(varstr) - 1] = '\0';
        double valeur = strtod(varstr, NULL);

        if (valeur < 0) {
            printf("reel signe negatif\n"); 
        } else {
            printf("reel signe positif \n"); 
        }
}

! {printf("operateur : negation \n" );}
; {printf("pvg\n");}
: {printf("deux points \n");}
, {printf("le vergule \n");}
"("  {printf("parenthese_ouvrante \n");}
")" {printf("parenthese_fermante \n");}  
"{" {printf("accolade_ouvrante \n");}
"}" {printf("accolade_fermante \n");}
"-" {printf("soustract \n");}
"+" {printf("addition \n");}
"*" {printf("multiplication \n");}
"/" {printf("division \n");}
":=" {printf("affectation \n");}
\"  {printf("Guillemets \n");}
"[" {printf("corechets ouvrante \n");}
"]" {printf("corechets fermente \n");}

"<" {printf("inferieur \n");}
">" {printf("superieur \n");}
">=" {printf("superieur_ou_egale \n");}
"<=" {printf("inferieur_ou_egae \n");}
"==" {printf("egale \n");}
"!=" {printf("different_de \n");}


[ \t] {printf("espace \n");}




. {printf("erreur lexicale a la ligne %d \n", num_de_lignes);} 

%%
int main(){
    yylex();
    return 0;
}
