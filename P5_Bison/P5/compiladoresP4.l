%{
	#include "compiladoresP4.tab.h"
%}

ENTERO [0-9]+
ENTERONEGATIVO "-"ENTERO
FLOTANTE [0-9]*"."[0-9]+
FLOTANTENEGATIVO "-"FLOTANTENEGATIVO
RAIZ [Rr][Aa][Ii][Zz]
MODULO [Mm][Oo][Dd]
CADENA \"[A-Z_a-z0-9 ]+\"

%%

{ENTERO}	{
				printf("\tNumero Entero %s\n",yytext);
				yylval.entero=atoi(yytext);
				return (ENTERO);
			}


{FLOTANTE}	{
				printf("\tNumero Decimal %s\n",yytext);
                yylval.flotante = atof(yytext);
                return (FLOTANTE);
			}

"+"	{
		printf("\tSigno mas\n");
		return (yytext[0]);
	}

"-"	{
		printf("\tSigno menos\n");
		return (yytext[0]);
	}



"*"	{
		printf("\tSigno por\n");
		return (yytext[0]);
	}

"/"	{
		printf("\tSigno entre\n");
		return (yytext[0]);
	}

"^"	{
		printf("\tSigno potencia\n");
		return (yytext[0]);
	}

{MODULO}	{
				printf("\tModulo\n");
				return (MOD);
			}

{RAIZ}	{
			printf("\tRaiz\n");
			return (RAIZ);
		}

"("	{
		printf("\tParentesis de apertura\n");
		return (yytext[0]);
	}

,	{
		printf("\tComa\n");
		return (yytext[0]);	
	}

")"	{
		printf("\tParentesis de cierre\n");
		return (yytext[0]);
	}

{CADENA}	{
				printf("\tCadena\n");
				int i, j;
				char c=yytext[0];
				for(i=0;c!='\0';i++)
					c=yytext[i+1];
				yylval.cadena=(char*)malloc((sizeof(char)*i)-(sizeof(char)*2));
				for(j=0;j<(sizeof(char)*i)-(sizeof(char)*2);j++)
					yylval.cadena[j]=yytext[j+1];
				return (CADENA);
			}

"\n"	{
			printf("\tSalto de linea\n");
			return (yytext[0]);
		}

.	;
%%
