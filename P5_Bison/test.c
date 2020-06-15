#include <stdio.h>
#include <stdlib.h>

char * strconcat(char*, char*);
char * strpow(char*,int);
char * strdiv(char*, char *);
char * removeSpaces(char*);
int containsStr(char *,char *);
int strlength(char*);

int main(){

	char * a = "holaholahola";
	char * b = "la";

	printf("%s\n", a);
	printf("%s\n", b);

	printf("%s\n", removeSpaces("ho la"));
	printf("%d\n",containsStr(a,b));

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

    int finished = 0;
    int s = 0;

    char * r = malloc(sizeA + 1);

    for(int i = 0; i < sizeA ; i++){
    	r[i] = a[i];
    }

    for(int i = 0; i < sizeA; i++){
    	for(int j = 0; j < sizeB; j++){
    		if(a[i] == b[j]){
    			finished++;
    			printf("%c\n", b[j]);
    		}
    	}
    }

    s = (finished == strlength(b)) ? 1 : 0;

    return s;
}

char * strdiv(char * a, char * b) {

	int sizeA = strlength(a);
    int sizeB = strlength(b);

    int finished = 0;
    int s = 0;

    char * r = malloc(sizeA + 1);

    for(int i = 0; i < sizeA ; i++){
    	r[i] = a[i];
    }

    for(int i = 0; i < sizeA; i++){
    	for(int j = 0; j < sizeB; j++){
    		if(a[i] == b[j]){
    			finished++;
    		}
    	}
    }

    return r;

}

char * removeSpaces(char * a){

	int sizeA = strlength(a);
	char * r = malloc(sizeA);

	printf("%s\n", a);

	for(int i = 0; i < sizeA; i++){
		if(r[i] == ' '){
			printf("%c\n", r[i+1]);
			r[i] = r[i+1];
		}
	}

	return r;
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