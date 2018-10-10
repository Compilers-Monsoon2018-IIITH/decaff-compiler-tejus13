%{
#include <stdio.h>	
%}

%token CLASS
%token PROGRAM
%token ID
%token VOID
%token TRUE
%token FALSE
%token CALLOUT
%token INT
%token BOOL
%token IF
%token ELSE
%token FOR 
%token RETURN
%token CONTINUE
%token BREAK
%token AND
%token OR
%token NOT
%token NET
%token GT
%token LT
%token GTE
%token LTE
%token IET
%token HEX_LITERAL
%token DIGIT
%token CHAR
%token STRING
%token PLUS
%token MINUS
%token EQUAL
%token MULTIPLY
%token DIVIDE
%token MOD
%token PLUSEQUAL
%token MINUSEQUAL
%token MULEQUAL
%token OPEN_PAREN
%token CLOSED_PAREN
%token LEFT_BRACES
%token RIGHT_BRACES
%token SEMI_COLON
%token COMMA
%token SQ_OPEN_BRAC
%token SQ_CLOSED_BRAC
%token COMMENTS
%left MULEQUAL MINUSEQUAL PLUSEQUAL
%left OR
%left AND 
%left NET IET
%left LTE GTE LT GT
%left PLUS MINUS
%left MULTIPLY DIVIDE MOD


%%
Program : CLASS PROGRAM LEFT_BRACES field_a RIGHT_BRACES
		| CLASS PROGRAM LEFT_BRACES method_a RIGHT_BRACES
		| CLASS PROGRAM LEFT_BRACES field_a method_a RIGHT_BRACES
		| CLASS PROGRAM LEFT_BRACES RIGHT_BRACES
		;
		
field_a : field_decl 
		| field_a field_decl 
	    ;

field_decl : type field_decl_a SEMI_COLON
		   ;

field_decl_a : field_decl_b
	 		 | field_decl_a COMMA field_decl_b 
			 ;

field_decl_b : ID
			 | ID SQ_OPEN_BRAC int_literal SQ_CLOSED_BRAC
			 ;

method_a : method_decl  
		 | method_a method_decl
		 ;
	
method_decl : type ID OPEN_PAREN method_decl_a CLOSED_PAREN block
			| type ID OPEN_PAREN CLOSED_PAREN block
			| VOID ID OPEN_PAREN CLOSED_PAREN block
			| VOID ID OPEN_PAREN method_decl_a CLOSED_PAREN block 
			
			;

method_decl_a : method_decl_b
			  | method_decl_a COMMA method_decl_b 
			  ; 

method_decl_b : type ID			
			  ;

block : LEFT_BRACES var_decl_a statement_decl_a RIGHT_BRACES
	  | LEFT_BRACES var_decl_a RIGHT_BRACES
	  | LEFT_BRACES statement_decl_a RIGHT_BRACES
	  | LEFT_BRACES RIGHT_BRACES
	  ;

var_decl_a : var_decl
		   | var_decl_a var_decl
		   ;

var_decl : type id_a SEMI_COLON
		 ;

id_a : ID
	 | id_a COMMA ID
	 ;

statement_decl_a : statement 
				 | statement_decl_a statement
				 ;

statement : location assign_op expr
		  | method_call SEMI_COLON
		  | IF OPEN_PAREN expr CLOSED_PAREN block
		  | IF OPEN_PAREN expr CLOSED_PAREN block ELSE block
		  | FOR ID EQUAL expr COMMA expr block
		  | RETURN expr SEMI_COLON
		  | RETURN SEMI_COLON
		  | BREAK SEMI_COLON
		  | CONTINUE SEMI_COLON
		  | block
		  ;

type : INT
	 | BOOL
	 ;

expr : location
	 | method_call
	 | literal
	 | expr MULTIPLY expr
	 | expr DIVIDE expr
	 | expr PLUS expr
	 | expr MINUS expr
	 | expr MOD expr
	 | expr GTE expr
	 | expr GT expr
	 | expr LT expr
	 | expr LTE expr
	 | expr IET expr
	 | expr NET expr
	 | expr AND expr
	 | expr OR expr
	 | MINUS expr
	 | NOT expr
	 | OPEN_PAREN expr CLOSED_PAREN
	 ;

location : ID
		 | ID SQ_OPEN_BRAC expr SQ_CLOSED_BRAC
		 ;

method_call_temp : expr 
				 | method_call_temp COMMA expr
	     		 ;

method_call :method_name OPEN_PAREN method_call_temp CLOSED_PAREN
			| CALLOUT OPEN_PAREN str_literal CLOSED_PAREN
			| CALLOUT OPEN_PAREN str_literal callout_temp CLOSED_PAREN
			;

callout_temp : COMMA callout_arg
			 | callout_temp COMMA callout_arg
			 ;

callout_arg : expr
			| str_literal
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

char_literal : CHAR
			 ;

str_literal : STRING
			;

assign_op : MULEQUAL
		  | PLUSEQUAL
		  | MINUSEQUAL
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