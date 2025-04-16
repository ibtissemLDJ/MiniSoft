#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_QUADS 1000
#define MAX_TEMP_VARS 100
#define MAX_LABEL_LENGTH 20
#define MAX_OPERAND_LENGTH 20

typedef struct Quadruplet {
    char  Operator [10];
    char operand1[MAX_OPERAND_LENGTH];
    char operand2[MAX_OPERAND_LENGTH];
    char result[MAX_OPERAND_LENGTH];
} Quadruplet;

Quadruplet quadruplets[MAX_QUADS];
int quad_index = 0;

int temp_var_counter = 0;
int label_counter = 0;

// Symbol table (for simplicity, just stores variable names)
char symbols[100][20];
int symbol_count = 0;

// Function to check if a symbol exists
int symbol_exists(const char* name) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbols[i], name) == 0) {
            return 1;
        }
    }
    return 0;
}

// Function to add a symbol
void add_symbol(const char* name) {
    if (!symbol_exists(name) && symbol_count < 100) {
        strcpy(symbols[symbol_count++], name);
    }
}

// Function to generate a new temporary variable name
char* new_temp() {
    char* temp_name = (char*)malloc(sizeof(char) * (MAX_OPERAND_LENGTH + 1));
    if (temp_name == NULL) {
        fprintf(stderr, "Error: Memory allocation failed for temporary variable.\n");
        exit(EXIT_FAILURE);
    }
    sprintf(temp_name, "t%d", temp_var_counter++);
    return temp_name;
}

// Function to generate a new label name
char* new_label() {
    char* label_name = (char*)malloc(sizeof(char) * (MAX_LABEL_LENGTH + 1));
    if (label_name == NULL) {
        fprintf(stderr, "Error: Memory allocation failed for label.\n");
        exit(EXIT_FAILURE);
    }
    sprintf(label_name, "L%d", label_counter++);
    return label_name;
}

// Function to add a new quadruplet
void emit(const char* op, const char* arg1, const char* arg2, const char* res) {
    if (quad_index < MAX_QUADS) {
        strncpy(quadruplets[quad_index].Operator, op, sizeof(quadruplets[quad_index].Operator) - 1);
        quadruplets[quad_index].Operator[sizeof(quadruplets[quad_index].Operator) - 1] = '\0';
        strncpy(quadruplets[quad_index].operand1, arg1, sizeof(quadruplets[quad_index].operand1) - 1);
        quadruplets[quad_index].operand1[sizeof(quadruplets[quad_index].operand1) - 1] = '\0';
        strncpy(quadruplets[quad_index].operand2, arg2, sizeof(quadruplets[quad_index].operand2) - 1);
        quadruplets[quad_index].operand2[sizeof(quadruplets[quad_index].operand2) - 1] = '\0';
        strncpy(quadruplets[quad_index].result, res, sizeof(quadruplets[quad_index].result) - 1);
        quadruplets[quad_index].result[sizeof(quadruplets[quad_index].result) - 1] = '\0';
        quad_index++;
    } else {
        fprintf(stderr, "Error: Maximum number of quadruplets reached!\n");
        exit(EXIT_FAILURE);
    }
}

// Function to print the generated quadruplets
void print_quadruplets() {
    printf("\n--- Generated Quadruplets ---\n");
    for (int i = 0; i < quad_index; i++) {
        printf("%d: (%s, %s, %s, %s)\n", i,
               quadruplets[i].Operator,
               quadruplets[i].operand1,
               quadruplets[i].operand2,
               quadruplets[i].result);
    }
    printf("-----------------------------\n");
}
