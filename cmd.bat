flex lex.l
bison -d synt.y
gcc lex.yy.c synt.tab.c interpreter.c -lfl -ly -o Mini_Soft
Mini_Soft.exe<testCorrect.txt
Mini_Soft.exe<testErrors.txt
