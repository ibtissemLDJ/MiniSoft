flex lexic.l
bison -d syntax.y
gcc lex.yy.c syntax
