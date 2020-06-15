%{
#include <stdio.h>
int yylex(void);
void yyerror (char *);
char * restarCadena(char*, char*);
char * sumarCadena(char*, char*);
char isBinA(char*,char*);
char *powCadena(char*,int);
int longitudCadena(char*);
%}
             
/* Declaraciones de BISON */
%union{
	int entero;
	double decimal;
    char* palabra;
}

%token POW
%token <entero> ENTERO
%token <decimal> DECIMAL
%token <palabra> PALABRA

%type <entero> exp_entera
%type <decimal> exp_decimal exp_entera_decimal exp_decimal_entera
%type <palabra> exp_string

%left '"'
%left '+' '-'
%left '*' '/'
%left UNARYMINUS
             
/* Gramática */
%%
             
input:    /* cadena vacía */
        | input line             
        ;

line:     '\n'
        | exp_entera '\n'  { printf ("\tresultado: %d\n", $1); }
        | exp_decimal '\n' { printf ("\tresultado: %f\n", $1); }
        | exp_string '\n'  { printf ("\tresultado: %s\n", $1); }
        ;

//cadena
exp_string:     '"' PALABRA  '"' {  $$ = $2; }
                | exp_string '+' exp_string        { $$ = sumarCadena($1,$3);}
                | exp_string '-' exp_string        { $$ = restarCadena($1,$3); }
                | POW '(' exp_string ',' ENTERO ')' { if( $5 <= 0) { printf("debe ser un número positivo\n"); $$ = $3; } $$ = powCadena($3,$5); }
                ;

//entero con entero
exp_entera:      ENTERO	{ $$ = $1; }
                | exp_entera '+' exp_entera        { $$ = $1 + $3; }
                | exp_entera '-' exp_entera        { $$ = $1 - $3; }
                | exp_entera '*' exp_entera        { $$ = $1 * $3; }
                | exp_entera '/' exp_entera        { if($3 == 0)  { printf("El denominador no debe ser cero\n"); $$=0; } else { $$ = $1 / $3; }    }
                | '-' exp_entera  %prec UNARYMINUS { $$ = -$2; }
                ;

//decimal con decimal
exp_decimal:    DECIMAL	{ $$ = $1; }
                | exp_entera_decimal
                | exp_decimal_entera
                | exp_decimal '+' exp_decimal        { $$ = $1 + $3;    }
                | exp_decimal '-' exp_decimal        { $$ = $1 - $3;    }
                | exp_decimal '*' exp_decimal        { $$ = $1 * $3;    }
                | exp_decimal '/' exp_decimal        { if( $3 == 0.0f ) { printf("El denominador no debe ser cero\n"); $$=0; } else { $$ = $1 / $3; } }
                | '-' exp_decimal  %prec UNARYMINUS { $$ = -$2; }
                ;

//entero con decimal
exp_entera_decimal: exp_entera '+' exp_decimal        { $$ = $1 + $3;    }
                | exp_entera '-' exp_decimal        { $$ = $1 - $3;    }
                | exp_entera '*' exp_decimal        { $$ = $1 * $3;    }
                | exp_entera '/' exp_decimal        { if( $3 == 0.0f ) { printf("El denominador no debe ser cero\n"); $$=0; } else { $$ = $1 / $3; } }
                ;

//decimal con entero
exp_decimal_entera:exp_decimal '+' exp_entera       { $$ = $1 + $3;    }
                | exp_decimal '-' exp_entera        { $$ = $1 - $3;    }
                | exp_decimal '*' exp_entera        { $$ = $1 * $3;    }
                | exp_decimal '/' exp_entera        { if( $3 == 0 ) { printf("El denominador no debe ser cero\n"); $$=0; } else { $$ = $1 / $3; } }
                ;
             
%%

int main() {
  yyparse();
  return 0;
}

int longitudCadena(char *a) {
    int i;
    for ( i = 0; a[i] != '\0'; i++)
        ;
    return i;
}

char isBinA(char*a, char*b){
    int sizeA = longitudCadena(a);
    int sizeB = longitudCadena(b);

    if ( sizeB > sizeA )//es mayor la longitud de b, terminamos
        return 0;
    //vemos si 'b' completa está al final de 'a'
    for(int i = sizeB-1, j = sizeA-1; i >= 0; i--, j--)
        if (b[i] != a[j]){//no está...
            printf("no está en A\n");
            return 0;
        } else {
            printf("carácter igual: %c,%c\n",b[i],a[j]);
        }

    return 1;
}

char * restarCadena(char *a, char *b) {

    int sizeA = longitudCadena(a);
    int sizeB = longitudCadena(b);
    int size = sizeA+sizeB;

    //no interesa alojar más espacio del necesario
    //total, termina de imprimir la cadena al encontrar el primer '\0'
    char * str = malloc(size+1);

    //limpiamos cadena
    for (int i = 0; i < size; i++)
        str[i] = 0;


    //verificamos que la cadena b esté contenida al final de 'a'
    if (!isBinA(a,b))//si no está, regresamos simplemente 'a'
        return a;

    //copiamos cadena hasta donde debamos
    for (int i = 0; i < sizeA-sizeB; i++)
        *(str+i) = a[i];

    *(str+size-sizeB+1) = '\0';//marcamos el fin de la cadena
    return str;

}

char * sumarCadena(char *a, char *b){

    int sizeA = longitudCadena(a);
    int sizeB = longitudCadena(b);
    int size = sizeA+sizeB;

    char * str = malloc(size+1);

    //limpiamos cadena
    for (int i = 0; i < size; i++)
        str[i] = 0;


    //copiamos primer cadena
    for (int i = 0; i < sizeA; i++)
        *(str+i) = a[i];

    //copiamos segunda cadena
    for (int i = 0; i < sizeB; i++)
        *(str+sizeA+i) = b[i];

    str[size+1] = '\0'; //marcamos el fin de la cadena
    return str;
}

char *powCadena(char*a,int b){
    char * str = a;
    for (int i =0; i<b-1; i++)
        str = sumarCadena(str,a);
    return str;
}

             
void yyerror (char *s) {
  printf ("--%s--\n", s);
}
            
int yywrap() {
  return 1;  
}  
