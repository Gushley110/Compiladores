%{
#include "parser.h"
%}

NUM [0-9]+
%%

{NUM}           {
                printf("Número entero: %s\n",yytext);
                yylval.entero = atoi(yytext);
                return ENTERO;
                }

[0-9]*"."[0-9]+ {
                printf("Número decimal: %s\n",yytext);
                yylval.decimal = atof(yytext);
                return DECIMAL;
                }

"+"|"-"|"*"|"/"|"("|")"|","|"\"" {
                printf("carácter: %s\n",yytext);
                return (yytext[0]);
                }

[pP][oO][wW]    {
                printf("es: ",yytext);
                return POW;
                }

[A-Za-z]+       {
                printf("palabra: %s\n",yytext);
                yylval.palabra = strdup(yytext);
                return PALABRA;
                }



"\n"            {
                printf("Salto de línea\n");
                return (yytext[0]);
                }

.               ;
%%
