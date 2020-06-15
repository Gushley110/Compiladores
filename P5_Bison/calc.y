%{
#include <stdio.h>
#include <math.h>
int yylex(void);
void yyerror (char *);
char * strsubstract(char*, char*);
char * strconcat(char*, char*);
char * strpow(char*,int);
int strlength(char*);
%}
             
/* Declaraciones de BISON */
%union{
	int entero;
	double decimal;
	char * cadena;
}

%token <entero> ENTERO
%token POW
%token DIV
%type <entero> exp_entera
%token <decimal> DECIMAL
%type <decimal> exp_decimal
%token <cadena> CADENA
%type <cadena> exp_cadena      

%left '+' '-' DIV
%left '*' '/'
%left POW
             
/* Gramática */
%%
             
input:    /* cadena vacía */
        | input line             
;

line:   '\n'
        | exp_entera '\n'  { printf ("\tresultado: %d\n", $1); }
        | exp_decimal '\n'  { printf ("\tresultado: %f\n", $1); }
        | exp_cadena '\n'  { printf ("\tresultado: %s\n", $1); }

;
             
exp_entera:     	ENTERO { $$ = $1; }
				|	'-' exp_entera { $$ = -1 * $2; }
				|	exp_entera '+' exp_entera { $$ = $1 + $3; }
				|	exp_entera '-' exp_entera { $$ = $1 - $3; }
				|	exp_entera '*' exp_entera { $$ = $1 * $3; }
				|	exp_entera '/' exp_entera { $$ = $1 / $3; }
;

exp_decimal:     DECIMAL	{ $$ = $1; }
	| exp_decimal '+' exp_decimal        { $$ = $1 + $3;    }
	| exp_decimal '*' exp_decimal        { $$ = $1 * $3;    }
;

exp_cadena:		CADENA 		{ $$ = $1; }
	|	exp_cadena '+' exp_cadena		{$$ = strconcat($1,$3);}
	|	exp_cadena '-' exp_cadena		{$$ = strsubstract($1,$3);}
;
             
%%

int main() {
  yyparse();
  return 0;
}

int strlength(char *a) {
    int i;
    for ( i = 0; a[i] != '\0'; i++);
    return i;
}

int containsStr(char * a, char * b){
    int sizeA = strlength(a);
    int sizeB = strlength(b);

    if ( sizeB > sizeA )
        return 0;
    
    for(int i = sizeB-1, j = sizeA-1; i >= 0; i--, j--)
        if (b[i] != a[j]){
            printf("no está en A\n");
            return 0;
        } else {
            printf("carácter igual: %c,%c\n",b[i],a[j]);
        }

    return 1;
}

char * strsubstract(char *a, char *b) {

    int sizeA = strlength(a);
    int sizeB = strlength(b);
    int size = sizeA+sizeB;

    char * str = malloc(size+1);

    for (int i = 0; i < size; i++)
        str[i] = 0;

    if (!containsStr(a,b))
        return a;

    for (int i = 0; i < sizeA-sizeB; i++)
        *(str+i) = a[i];

    *(str+size-sizeB+1) = '\0';
    return str;

}

char * strconcat(char * a, char * b){

    int sizeA = strlength(a);
    int sizeB = strlength(b);
    int size = sizeA+sizeB;

    char * str = malloc(size+1);

    for (int i = 0; i < size; i++)
        str[i] = 0;

    for (int i = 0; i < sizeA; i++)
        *(str+i) = a[i];

    for (int i = 0; i < sizeB; i++)
        *(str+sizeA+i) = b[i];

    str[size+1] = '\0';

    return str;
}

char * strpow(char*a,int b){
    char * str = a;
    for (int i =0; i<b-1; i++)
        str = strconcat(str,a);
    return str;
}
             
void yyerror (char *s)
{
  printf ("--%s--\n", s);
}
            
int yywrap()  
{  
  return 1;  
}  
