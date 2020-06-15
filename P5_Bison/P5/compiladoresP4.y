%{
	#include <stdio.h>
	#include <math.h>
	int yylex ( void );
	void yyerror (char *);
%}

%union
{
	int entero;
	float flotante;
	char *cadena;
}

%token <entero> ENTERO
%token <flotante> FLOTANTE
%token <cadena> CADENA
%token MOD RAIZ
%type <entero> expresionEntera
%type <flotante> expresionFlotante
%type <cadena> cadenaTexto

%left '+' '-'
%left '*' '/' MOD
%left '^' RAIZ

%start inicial

%%

inicial: input
;

input: 
		|	input line
;

line:	'\n'
		|	expresionEntera '\n' { printf ( "\tResultado: %d\n", $1); }
		|	expresionFlotante '\n' { printf ( "\tResultado: %f\n", $1); }
		|	cadenaTexto '\n' { printf ( "\tResultado: %s\n", $1); }
;

expresionEntera:		ENTERO { $$ = $1; }
					|	'-' expresionEntera { $$ = -1 * $2; }
					|	expresionEntera '+' expresionEntera { $$ = $1 + $3; }
					|	expresionEntera '-' expresionEntera { $$ = $1 - $3; }
					|	expresionEntera '*' expresionEntera { $$ = $1 * $3; }
					|	expresionEntera '/' expresionEntera { $$ = $1 / $3; }
					|	expresionEntera '^' expresionEntera { $$ = pow($1, $3); }
					|	MOD '(' expresionEntera ',' expresionEntera ')' { $$ = $3 % $5; }
;

expresionFlotante:		FLOTANTE { $$=$1; }
					|	'-' expresionFlotante { $$ = -1 * $2; }
					|	expresionFlotante '+' expresionEntera { $$ = $1 + $3; }
					|	expresionEntera '+' expresionFlotante { $$ = $1 + $3; }
					|	expresionFlotante '+' expresionFlotante { $$ = $1 + $3; }
					|	expresionFlotante '-' expresionEntera { $$ = $1 - $3; }
					|	expresionEntera '-' expresionFlotante { $$ = $1 - $3; }
					|	expresionFlotante '-' expresionFlotante { $$ = $1 - $3; }
					|	expresionFlotante '*' expresionEntera { $$ = $1 * $3; }
					|	expresionEntera '*' expresionFlotante { $$ = $1 * $3; }
					|	expresionFlotante '*' expresionFlotante { $$ = $1 * $3; }
					|	expresionFlotante '/' expresionEntera { $$ = $1 / $3; }
					|	expresionEntera '/' expresionFlotante { $$ = $1 / $3; }
					|	expresionFlotante '/' expresionFlotante { $$ = $1 / $3; }
					|	expresionFlotante '^' expresionEntera { $$ = pow($1, $3); }
					|	expresionEntera '^' expresionFlotante { $$ = pow($1, $3); }
					|	expresionFlotante '^' expresionFlotante { $$ = pow($1, $3); }
					|	MOD '(' expresionEntera ',' expresionFlotante ')' { $$ = fmodf($3, $5); }
					|	MOD '(' expresionFlotante ',' expresionEntera ')' { $$ = fmodf($3, $5); }
					|	MOD '(' expresionFlotante ',' expresionFlotante ')' { $$ = fmodf($3, $5); }
					|	RAIZ '(' expresionEntera ')' { $$ = sqrt($3); }
					|	RAIZ '(' expresionFlotante ')' { $$ = sqrt($3); }
;

cadenaTexto:	CADENA { $$=$1; }
				|	cadenaTexto '+' cadenaTexto 
					{
						int i, j, n, c;
						for(i=0;$1[i]!='\0';i++);
						for(j=0;$3[j]!='\0';j++);
						$$=(char*)malloc((sizeof(char)*i)+(sizeof(char)*j));
						for(n=0;n<i;n++)
							$$[n]=$1[n];
						for(c=0;c<j;c++)
							$$[n++]=$3[c];
					}
				|	cadenaTexto '-' cadenaTexto
					{
						int i, j, n, c, bandera, tam;

						for(i=0; $1[i]!='\0'; i++)
						{
							for(j=0;$1[i+j]!='\0' && $3[j]!='\0';j++)
							{
								if($1[i+j] == $3[j])
									bandera=1;
								else
								{
									bandera = 0;
									break;
								}
							}
							if(bandera==1&&$3[j]=='\0')
							{
								for(n=0;$1[n]!='\0';n++);
								for(c=0;$3[c]!='\0';c++);
								tam=(sizeof(char)*n)-(sizeof(char)*c);
								$$=(char*)malloc(tam);
								for(n=0;n<i;n++)
									$$[n]=$1[n];
								for(i+=c;$1[i]!='\0';i++)
									$$[n++]=$1[i];
							}
						}
					}
;

%%

int main()
{
	yyparse();
}

void yyerror (char *s)
{
	printf ("--%s--\n", s);
}

int yywrap()
{
	return 1;
}
