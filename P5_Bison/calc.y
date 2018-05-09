%{
#include <stdio.h>
//#include <math.h>
int yylex(void);
void yyerror (char *);
%}
             
/* Declaraciones de BISON */
%union{
	int entero;
	double decimal;
	char * cadena;
}

%token DIV
%token <entero> ENTERO
%type <entero> exp_entera
%token <decimal> DECIMAL
%type <decimal> exp_decimal
%token <cadena> CADENA
%type <cadena> exp_cadena      

%left '+'
%left '*' DIV
             
/* Gramática */
%%
             
input:    /* cadena vacía */
        | input line             
;

line:     '\n'
        | exp_entera '\n'  { printf ("\tresultado: %d\n", $1); }
        | exp_decimal '\n'  { printf ("\tresultado: %f\n", $1); }
;
             
exp_entera:     ENTERO	{ $$ = $1; }
	| exp_entera '+' exp_entera        { $$ = $1 + $3;    }
	| exp_entera '*' exp_entera        { $$ = $1 * $3;    }
	| exp_entera DIV exp_entera        { $$ = $1 / $3;    }
;
exp_decimal:     DECIMAL	{ $$ = $1; }
	| exp_decimal '+' exp_decimal        { $$ = $1 + $3;    }
	| exp_decimal '*' exp_decimal        { $$ = $1 * $3;    }
;

             
%%

int main() {
  yyparse();
  return 0;
}
             
void yyerror (char *s)
{
  printf ("--%s--\n", s);
}
            
int yywrap()  
{  
  return 1;  
}  
