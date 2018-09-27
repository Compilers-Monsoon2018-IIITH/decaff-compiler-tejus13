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

expr : location
	 | method_call
	 | literal
	 | expr bin_op expr
	 | '-' expr
	 | '!' expr
	 | '(' expr ')'
	 |
	 ;

location : ID
		 | ID '[' expr ']'
		 ;

temp : expr | expr ',' expr
			;
method_call :method_name '(' temp ')'
			// callout
			;

method_name : ID
			;
literal : int_literal
		| char_literal
		| bool_literal
		;
int_literal : DIGIT
			| HEX_LITERAL
			;
bool_literal : TRUE
			 | FALSE
			 ;
// char_literal :  

bin_op : arith_op
		| rel_op
		| eq_op
		| cond_op
		;

arith_op : +
		 | -
		 | *
		 | /
		 | %
		 ;

rel_op : GT
		| GTE
		| LT
		| LTE
		;

eq_op : IET
	  | NET
	  ;

cond_op : AND
		| OR
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