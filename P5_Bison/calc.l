%{
#include "ejemplo2.tab.h"
%}

NUM [0-9]+
CAD "([^"]*)"
%%

{NUM}           {
		printf("Numero entero %s\n",yytext);
                yylval.entero = atoi(yytext);
                return ENTERO;
                }
{CAD}           {
                printf("Cadena %s\n",yytext);
                
                }
[0-9]*"."[0-9]+ {
                printf("Numero decimal %s\n",yytext);
                yylval.decimal = atof(yytext);
                return DECIMAL;
                }

"+"|"*"|"-" 	{
		printf("Signo %s\n",yytext);
                return (yytext[0]);
                }
"/"       {
                printf("Signo %s\n",yytext);
                return DIV;
                }
"\n"            {
		printf("Salto de linea\n");
                return (yytext[0]);
                }
.               ;
%%
