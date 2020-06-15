raiz [R|r][A|a][I|i][Z|z]
%%
{raiz}\([0-9]+","[0-9]+\)";" {printf("Es raiz con entero");}
{raiz}\([0-9]+["."?][0-9]*","[0-9]+\)";" {printf("Es raiz con decimal");}
{raiz}\(-?[0-9]+"."?[0-9]+","[0-9]+\)";" {printf("Raiz imaginaria");}
[A-Za-z_]([A-Za-z0-9_]+)? {printf("Variable");}
%%