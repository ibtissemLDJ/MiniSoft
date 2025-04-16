#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "synt.tab.h" // Or whatever your Bison-generated header is named
#define MAX_OPERAND_LENGTH 20 // Make sure this matches your Bison file

typedef struct Quadruplet {
    char Operator[10];
    char operand1[MAX_OPERAND_LENGTH];
    char operand2[MAX_OPERAND_LENGTH];
    char result[MAX_OPERAND_LENGTH];
} Quadruplet;
extern Quadruplet quadruplets[];
extern int quad_index;
#define MAX_MEMORY 100

char memory_names[MAX_MEMORY][MAX_OPERAND_LENGTH];
int memory_values[MAX_MEMORY];
int memory_index = 0;
int find_memory_index(const char* name) {
    for (int i = 0; i < memory_index; i++) {
        if (strcmp(memory_names[i], name) == 0) {
            return i;
        }
    }
    return -1; // Not found
}
int get_memory_value(const char* name) {
    int index = find_memory_index(name);
    if (index != -1) {
        return memory_values[index];
    } else {
        fprintf(stderr, "Error: Variable '%s' not found in memory.\n", name);
        exit(EXIT_FAILURE);
    }
}
void set_memory_value(const char* name, int value) {
    int index = find_memory_index(name);
    if (index != -1) {
        memory_values[index] = value;
    } else {
        if (memory_index < MAX_MEMORY) {
            strcpy(memory_names[memory_index], name);
            memory_values[memory_index] = value;
            memory_index++;
        } else {
            fprintf(stderr, "Error: Memory overflow.\n");
            exit(EXIT_FAILURE);
        }
    }
}
void interpret_quadruplets() {
    int current_quad = 0;
    while (current_quad < quad_index) {
        Quadruplet q = quadruplets[current_quad];

        // We'll add the operator handling here

        current_quad++;
    }
}
void interpret_quadruplets() {
    int current_quad = 0;
    while (current_quad < quad_index) {
        Quadruplet q = quadruplets[current_quad];

        if (strcmp(q.Operator, "=") == 0) {
            // Handle assignment
        } else {
            printf("Error: Unknown Operator '%s'\n", q.Operator);
            exit(EXIT_FAILURE);
        }

        current_quad++;
    }
}
#include <ctype.h> // For isdigit

// Function to check if a string represents an integer
int is_integer(const char* str) {
    if (str == NULL || *str == '\0') {
        return 0;
    }
    if (*str == '-' || *str == '+') {
        str++;
    }
    while (*str != '\0') {
        if (!isdigit(*str)) {
            return 0;
        }
        str++;
    }
    return 1;
}

void interpret_quadruplets() {
    int current_quad = 0;
    while (current_quad < quad_index) {
        Quadruplet q = quadruplets[current_quad];

        if (strcmp(q.Operator, "=") == 0) {
            int value;
            if (is_integer(q.operand1)) {
                value = atoi(q.operand1);
            } else {
                value = get_memory_value(q.operand1);
            }
            set_memory_value(q.result, value);
        } else {
            printf("Error: Unknown Operator '%s'\n", q.Operator);
            exit(EXIT_FAILURE);
        }

        current_quad++;
    }
}
void interpret_quadruplets() {
    int current_quad = 0;
    while (current_quad < quad_index) {
        Quadruplet q = quadruplets[current_quad];

        if (strcmp(q.Operator, "=") == 0) {
            int value;
            if (is_integer(q.operand1)) {
                value = atoi(q.operand1);
            } else {
                value = get_memory_value(q.operand1);
            }
            set_memory_value(q.result, value);
        } else if (strcmp(q.Operator, "+") == 0) {
            int operand1_value, operand2_value, result;
            if (is_integer(q.operand1)) {
                operand1_value = atoi(q.operand1);
            } else {
                operand1_value = get_memory_value(q.operand1);
            }
            if (is_integer(q.operand2)) {
                operand2_value = atoi(q.operand2);
            } else {
                operand2_value = get_memory_value(q.operand2);
            }
            result = operand1_value + operand2_value;
            set_memory_value(q.result, result);
        } else if (strcmp(q.Operator, "-") == 0) {
            int operand1_value, operand2_value, result;
            if (is_integer(q.operand1)) {
                operand1_value = atoi(q.operand1);
            } else {
                operand1_value = get_memory_value(q.operand1);
            }
            if (is_integer(q.operand2)) {
                operand2_value = atoi(q.operand2);
            } else {
                operand2_value = get_memory_value(q.operand2);
            }
            result = operand1_value - operand2_value;
            set_memory_value(q.result, result);
        } else if (strcmp(q.Operator, "*") == 0) {
            int operand1_value, operand2_value, result;
            if (is_integer(q.operand1)) {
                operand1_value = atoi(q.operand1);
            } else {
                operand1_value = get_memory_value(q.operand1);
            }
            if (is_integer(q.operand2)) {
                operand2_value = atoi(q.operand2);
            } else {
                operand2_value = get_memory_value(q.operand2);
            }
            result = operand1_value * operand2_value;
            set_memory_value(q.result, result);
        } else if (strcmp(q.Operator, "/") == 0) {
            int operand1_value, operand2_value, result;
            if (is_integer(q.operand1)) {
                operand1_value = atoi(q.operand1);
            } else {
                operand1_value = get_memory_value(q.operand1);
            }
            if (is_integer(q.operand2)) {
                operand2_value = atoi(q.operand2);
            } else {
                operand2_value = get_memory_value(q.operand2);
            }
            if (operand2_value == 0) {
                fprintf(stderr, "Error: Division by zero during interpretation.\n");
                exit(EXIT_FAILURE);
            }
            result = operand1_value / operand2_value;
            set_memory_value(q.result, result);
        } else {
            printf("Error: Unknown Operator '%s'\n", q.Operator);
            exit(EXIT_FAILURE);
        }

        current_quad++;
    }
}
/*
void interpret_quadruplets() {
    int current_quad = 0;
    while (current_quad < quad_index) {
        Quadruplet q = quadruplets[current_quad];

        if (strcmp(q.Operator, "=") == 0) {
            // ... (assignment handling as before) ...
        } else if (strcmp(q.Operator, "+") == 0) {
            // ... (addition handling as before) ...
        } else if (strcmp(q.Operator, "-") == 0) {
            // ... (subtraction handling as before) ...
        } else if (strcmp(q.Operator, "*") == 0) {
            // ... (multiplication handling as before) ...
        } else if (strcmp(q.Operator, "/") == 0) {
            // ... (division handling as before) ...
        } else if (strcmp(q.Operator, "output") == 0) {
            // Handle output
            int value = get_memory_value(q.operand1);
            printf("Output: %d\n", value);
        } else {
            printf("Error: Unknown Operator '%s'\n", q.Operator);
            exit(EXIT_FAILURE);
        }

        current_quad++;
    }
}
*/