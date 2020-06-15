%{
#include "calc.tab.h"
%}

INTEGER [0-9]+
NINT "-"INTEGER
FLOAT [0-9]*"."[0-9]+
NFLOAT "-"FLOAT
STR \"([^"]*)\"
POW [Pp][Oo][Ww]
DIV [Dd][Ii][Vv]
%%

{INTEGER}       {
		printf("\tNumero entero %s\n",yytext);
                yylval.entero = atoi(yytext);
                return ENTERO;
                }
{STR}           {
                
                int i, j;
                char c = yytext[0];

                for(i=0;c!='\0';i++){
                        c=yytext[i+1];
                }

                yylval.cadena = (char*)malloc((sizeof(char)*i)-(sizeof(char)*2));

                for(j=0;j<(sizeof(char)*i)-(sizeof(char)*2);j++){
                        yylval.cadena[j]=yytext[j+1];
                }

                printf("\tCadena %s\n",yylval.cadena);

                return (CADENA);
                }

{POW}           {
                printf("\tPOW");
                return (POW);
                }
{DIV}           {
                printf("\tDIV");
                return (DIV)
                }
[0-9]*"."[0-9]+ {
                printf("\tNumero decimal %s\n",yytext);
                yylval.decimal = atof(yytext);
                return DECIMAL;
                }

"+"|"*"|"-"|"/"|"("|")"|","     {
                		printf("\tSigno %s\n",yytext);
                                return (yytext[0]);
                                }

"\n"            {
		printf("\tSalto de linea\n");
                return (yytext[0]);
                }


.               ;

%%
