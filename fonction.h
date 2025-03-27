#include <stdio.h>
#include <stdlib.h>
#include  "TS.h"
#include <string.h>

//------------------------------------------------------------------------------------------------//
void initialization(){
    int i;
    // TS des IDF
    for (i=0;i<200; i++) TIDF[i]. state=0;
    // TS des Mots clés & Separateurs
    for (i=0;i<50;i++)
    {
    TSS[i].state=0;
    TSM[i].state=0;
    }
}
//------------------------------------------------------------------------------------------------//
void inserer(char entite[], char code[], char type[], char val[], int index, int table) {
    if (table == 1) {
        strcpy(TIDF[index].name, entite);
        strcpy(TIDF[index].code, code);
        strcpy(TIDF[index].type, type);
        strcpy(TIDF[index].val, val);
        TIDF[index].state = 1;
    } else if (table == 2) {
        strcpy(TSM[index].nomEntite, entite);
        strcpy(TSM[index].Code, code);
        TSM[index].state = 1;
    } else if (table == 3) {
        strcpy(TSS[index].nomEntite, entite);
        strcpy(TSS[index].Code, code);
        TSS[index].state = 1;
    }
}
//------------------------------------------------------------------------------------------------//

void Rechercher(char entite[], char code[], char type[], char val[], int y) {
    int i;
    
    switch (y) {
        case 1: // Recherche dans la table des IDF 
            for (i = 0; i < 200 && TIDF[i].state == 1 && strcmp(entite, TIDF[i].name) != 0; i++);
            
            if (i < 200 && strcmp(entite, TIDF[i].name) != 0) {
                inserer(entite, code, type, val, i, 1);
            } else {
                printf(">>>> L'entité %s existe déjà\n", entite);
            }
            break;

        case 2: // Recherche dans la table des mots clés
            for (i = 0; i < 50 && TSM[i].state == 1 && strcmp(entite, TSM[i].nomEntite) != 0; i++);
            
            if (i < 50 && strcmp(entite, TSM[i].nomEntite) != 0) {
                inserer(entite, code, type, val, i, 2);
            } else {
                printf(">>>> L'entité %s existe déjà\n", entite);
            }
            break;

        case 3: // Recherche dans la table des séparateurs
            for (i = 0; i < 50 && TSS[i].state == 1 && strcmp(entite, TSS[i].nomEntite) != 0; i++);
            
            if (i < 50 && strcmp(entite, TSS[i].nomEntite) != 0) {
                inserer(entite, code, type, val, i, 3);
            } else {
                printf(">>>> L'entité %s existe déjà\n", entite);
            }
            break;

        default:
            printf(">>>> Erreur : Type de recherche invalide\n");
            break;
    }
}
//------------------------------------------------------------------------------------------------//
void afficher() {
    int i;

    // Afficher la table des symboles IDF
    printf("/*********Table des symboles IDF*********/\n");
    printf("---\n");
    printf("\t|Nom_Entite | Code_Entite | Type_Entite | Val_Entite \n");
    printf("---\n");

    for (i = 0; i < 200; i++) {
        if (TIDF[i].state == 1) {
            printf("\t|%10s |%15s | %12s | %12s \n", TIDF[i].name, TIDF[i].code, TIDF[i].type, TIDF[i].val);
        }
    }

    // Afficher la table des symboles mots-clés
    printf("\n/*********Table des symboles mots clés**********/\n");
    printf("---\n");
    printf("\t|NomEntite |CodeEntite | \n");
    printf("---\n");

    for (i = 0; i < 50; i++) {
        if (TSM[i].state == 1) {
            printf("\t|%10s |%12s | \n", TSM[i].nomEntite, TSM[i].Code);
        }
    }

    // Afficher la table des symboles séparateurs
    printf("\n/*********Table des symboles séparateurs**********/\n");
    printf("---\n");
    printf("\t|NomEntite |CodeEntite | \n");
    printf("---\n");

    for (i = 0; i < 50; i++) {
        if (TSS[i].state == 1 ) {
            printf("\t|%10s |%12s | \n", TSS[i].nomEntite, TSS[i].Code);
        }
    }
}
//------------------------------------------------------------------------------------------------//
int rechercher_idf(char entite[]){
    // cette fonction utiliser pour rechercher les idfs pour regler le prbllm idf nn declarer 
    int i; 
    for (i = 0; i < 200 && TIDF[i].state == 1 && strcmp(entite, TIDF[i].name) != 0; i++);
        
        if (i < 200 && strcmp(entite, TIDF[i].name) != 0) {
            return 0;// si on a pas trouver l'idf 
        } else {
            return 1;// si on a  trouver l'idf
        }
    
}
