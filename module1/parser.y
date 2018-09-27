%{
#include <stdio.h>	
%}

%token ID
%token TRUE
%token FALSE
%token CALLOUT
%token INT
%token IF
%token ELSE
%token FOR
%token RETURN
%token CONTINUE
%token BREAK
%token AND
%token OR
%token NET
%token GT
%token LT
%token GTE
%token LTE
%token IET
%token HEX_LITERAL
%token DIGIT

%left '+''-'
%left '*' '/'

%%
expr : '(' expr ')'
	 | '!' expr
	 |  expr '+' expr
	 |  expr '-' expr
	 |  expr '*' expr
	 |  expr '/' expr
	 |	
	 |  ID
	 | 
	 ;

%%
main(int argc, char **argv)
{
	yyparse();
	printf("Parsing Over\n");
}

yyerror(char *s)
{
	fprintf(stderr, "error: %s\n", s);
}