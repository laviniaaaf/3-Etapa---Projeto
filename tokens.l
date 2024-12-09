%{
#include <stdio.h>
#include "bison.tab.h"

%}

VARIAVEL            [A-Za-z][A-Za-z0-9]{0,9}
FLOAT               0,[0-9]{1,2}|[+-]?[1-9][0-9]*,[0-9]{1,2}
STRING              \"[^\"]*\"
CARACTERE           \'([@_#\+\-*/.: A-Za-z0-9$]|\\n)\'

%%

"="                         { yylval.str = strdup(yytext); return T_ASSIGN; }
";"                         { yylval.str = strdup(yytext); return T_SEMICOLON; }
","                         { yylval.str = strdup(yytext); return T_COMMA; }

"FLOAT"                     { printf("\tfloat "); yylval.str = strdup(yytext); return T_KEYWORD; }
"CHAR"                      { printf("char "); yylval.str = strdup(yytext); return T_KEYWORD; }
"BOOL"                      { printf("boolean "); yylval.str = strdup(yytext); return T_KEYWORD; }

"LER"                       { yylval.str = strdup(yytext); return T_ENTRADA; }
"ESCREVER"                  { yylval.str = strdup(yytext); return T_SAIDA; }

"PROGRAMA"                  { printf("int "); yylval.str = strdup(yytext); return T_PROGRAMA; }

"PREX"                      { printf("main() "); yylval.str = strdup(yytext); return T_PREX; }

{FLOAT}                     { yylval.str = strdup(yytext); return T_FLOAT; }

{CARACTERE}                 { printf("%s", yytext); yylval.str = strdup(yytext); return T_CHAR; }

"+"                         { yylval.str = strdup(yytext); return T_OPARI; }
"-"                         { yylval.str = strdup(yytext); return T_OPARI; }
"*"                         { yylval.str = strdup(yytext); return T_OPARI; }
"/"                         { yylval.str = strdup(yytext); return T_OPARI; }


"{"                         { printf("{\n"); yylval.str = strdup(yytext); return T_CHAVESOPEN; }
"}"                         { printf("\treturn 0;\n}\n"); yylval.str = strdup(yytext); return T_CHAVESCLOSE; }

"("                         { yylval.str = strdup(yytext); return T_PARENTESISOPEN; }
")"                         { yylval.str = strdup(yytext); return T_PARENTESISCLOSE; }


{VARIAVEL}                  { yylval.str = strdup(yytext); return T_VAR; }

{STRING}                    { printf("%s", yytext); yylval.str = strdup(yytext); return T_STRING; }

[ \t\n\r]+                  { /* Ignora espaços, tabulações e quebras de linha */ }

.                           { printf("Caractere não reconhecido: '%s'\n", yytext); return -1; }

%%

int yywrap(void) {
    return 1;
}
