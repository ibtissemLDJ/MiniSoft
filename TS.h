typedef struct {
    int state; 
    char name[20];
    char code[20];
    char type[20];
    char val[20];
} TS_IDF;

typedef struct { 
    int state;
    char nomEntite[20];
    char Code[20];
} TS_MCS;

typedef struct {
    int state; 
    char name[20];
    char code[20];
    char val[50];
} TS_CHAR; // table de symbole des string

// Global tables
TS_IDF TIDF[200];
TS_MCS TSS[50], TSM[50];
TS_CHAR TSC[50];

// Global counters for each table
int CpTIDF = 0;  // Counter for TIDF table
int CpTSS = 0;   // Counter for TSS table
int CpTSM = 0;   // Counter for TSM table
int CpTSC = 0;   // Counter for TSC table (new string table)

/***************************fonction dinitialisation ******************************** */
void initialization() {
    int i;
    // TS des IDF
    for (i = 0; i < 200; i++) TIDF[i].state = 0;
    // TS des Mots clés & Separateurs
    for (i = 0; i < 50; i++) {
        TSS[i].state = 0;
        TSM[i].state = 0;
        TSC[i].state = 0; // Initialize new string table
    }
}

/* The search function: looks for an entity in the specified table
   Returns its position if found, otherwise -1
   tableType: 0 for TIDF, 1 for TSS, 2 for TSM, 3 for TSC */
int recherche(char entite[], int tableType) {
    int i = 0;
    int max;
    
    switch(tableType) {
        case 0: // TIDF table
            max = CpTIDF;
            while (i < max) {
                if (strcmp(entite, TIDF[i].name) == 0)
                    return i;
                i++;
            }
            break;
            
        case 1: // TSS table
            max = CpTSS;
            while (i < max) {
                if (strcmp(entite, TSS[i].nomEntite) == 0)
                    return i;
                i++;
            }
            break;
            
        case 2: // TSM table
            max = CpTSM;
            while (i < max) {
                if (strcmp(entite, TSM[i].nomEntite) == 0)
                    return i;
                i++;
            }
            break;
            
        case 3: // TSC table (new string table)
            max = CpTSC;
            while (i < max) {
                if (strcmp(entite, TSC[i].name) == 0)
                    return i;
                i++;
            }
            break;
    }
    
    return -1;
}

// Function to insert entities into the appropriate table
void inserer(char entite[], char code[], int tableType) {
    // Check if entity already exists
    if (recherche(entite, tableType) == -1) {
        switch(tableType) {
            case 0: // TIDF table
                strcpy(TIDF[CpTIDF].name, entite);
                strcpy(TIDF[CpTIDF].code, code);
                TIDF[CpTIDF].state = 1; // Mark as active
                CpTIDF++;
                break;      
                
            case 1: // TSS table
                strcpy(TSS[CpTSS].nomEntite, entite);
                strcpy(TSS[CpTSS].Code, code);
                TSS[CpTSS].state = 1; // Mark as active
                CpTSS++;
                break;
                
            case 2: // TSM table
                strcpy(TSM[CpTSM].nomEntite, entite);
                strcpy(TSM[CpTSM].Code, code);
                TSM[CpTSM].state = 1; // Mark as active
                CpTSM++;
                break;
                
            case 3: // TSC table (new string table)
                strcpy(TSC[CpTSC].name, entite);
                strcpy(TSC[CpTSC].code, code);
                TSC[CpTSC].state = 1; // Mark as active
                CpTSC++;
                break;
        }
    }
}

// Function to insert/update the value of an entity
void insererVal(char entite[], char val[], int tableType) {
    int posEntite;
    
    switch(tableType) {
        case 0: // TIDF table
            posEntite = recherche(entite, tableType);
            if (posEntite != -1) {
                strcpy(TIDF[posEntite].val, val);
            }
            break;
            
        case 3: // TSC table (new string table)
            posEntite = recherche(entite, tableType);
            if (posEntite != -1) {
                strcpy(TSC[posEntite].val, val);
            }
            break;
    }
}

// Function to insert/update the type of an entity (only for TIDF)
void insererType(char entite[], char type[], int tableType) {
    if (tableType != 0) return; // Only TIDF has type field
    
    int posEntite = recherche(entite, tableType);
    if (posEntite != -1) {
        strcpy(TIDF[posEntite].type, type);
    }
}

// Function to check if an entity has a type (only for TIDF)
int rechercheType(char entite[], int tableType) {
    if (tableType != 0) return -1; // Only TIDF has type field
    
    int posEntite = recherche(entite, tableType);
    if (posEntite == -1) return -1; // Entity not found
    
    if (strcmp(TIDF[posEntite].type, "") == 0) 
        return 0; // Entity exists but has no type
    else 
        return 1; // Entity exists and has a type
}

/******************************* fonction d'affichage  ***********************************/
void afficher() {
    int i;

    // Afficher la table des symboles IDF
    printf("\n*********Table des symboles IDF*********\n");
    printf("---\n");
    printf("\t|Nom_Entite | Code_Entite | Type_Entite | Val_Entite \n");
    printf("---\n");

    for (i = 0; i < 200; i++) {
        if (TIDF[i].state == 1) {
            printf("\t|%10s |%15s | %12s | %12s \n", TIDF[i].name, TIDF[i].code, TIDF[i].type, TIDF[i].val);
        }
    }

    // Afficher la table des symboles mots-clés
    printf("\n*********Table des symboles mots clés**********\n");
    printf("---\n");
    printf("\t|NomEntite |CodeEntite | \n");
    printf("---\n");

    for (i = 0; i < 50; i++) {
        if (TSM[i].state == 1) {
            printf("\t|%10s |%12s | \n", TSM[i].nomEntite, TSM[i].Code);
        }
    }

    // Afficher la table des symboles séparateurs
    printf("\n*********Table des symboles séparateurs**********\n");
    printf("---\n");
    printf("\t|NomEntite |CodeEntite | \n");
    printf("---\n");

    for (i = 0; i < 50; i++) {
        if (TSS[i].state == 1) {
            printf("\t|%10s |%12s | \n", TSS[i].nomEntite, TSS[i].Code);
        }
    }
    
    // Afficher la table des symboles string (new)
    printf("\n*********Table des symboles string**********\n");
    printf("---\n");
    printf("\t|NomEntite |CodeEntite | Valeur \n");
    printf("---\n");

    for (i = 0; i < 50; i++) {
        if (TSC[i].state == 1) {
            printf("\t|%10s |%12s | %50s \n", TSC[i].name, TSC[i].code, TSC[i].val);
        }
    }
}
