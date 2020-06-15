#include <stdio.h>
#include <stdlib.h>

char * concatstr(char *, char *);

int main(){
	
	char * string;

	string = malloc(sizeof(char) * 7);

	scanf("%s",string);

	printf("%s %zu\n",string ,sizeof(char));

	return 0;

}

char * concatstr(char * str1, char * str2){

	char * temp;

	temp = "";

	printf("El tamaño de %s es: %zu\n",str1,sizeof(str1));

	return temp;

}