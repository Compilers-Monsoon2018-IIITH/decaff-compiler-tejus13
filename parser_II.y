%{
#include <stdio.h>	
#include "ast.hh"
extern union Node yylval;
%}

%start PROGRAM


%%
Program : CLASS PROGRAM LEFT_BRACES field_a RIGHT_BRACES
		{
			$$ = new Program($4,NULL);
			start=$$;
		}
		| CLASS PROGRAM LEFT_BRACES method_a RIGHT_BRACES
		{
			$$ = new Program(NULL,$4);
			start=$$;
		}
		| CLASS PROGRAM LEFT_BRACES field_a method_a RIGHT_BRACES
		{
			$$ = new Program($4,$5);
			start=$$;
		}
		| CLASS PROGRAM LEFT_BRACES RIGHT_BRACES
		{
			$$ = new Program(NULL,NULL);
			start=$$;
		}
		;
		
field_a :
		{
			$$ = new field_a();
		}
		 type field_decl_a SEMI_COLON
		 { $$.push_back(string($1),$2);
		 }
		| field_a type field_decl_a SEMI_COLON 
		{$$.push_back($2,$3);}
	    ;

field_decl_a :field_decl_a COMMA field_decl_b 
			  {$$ = new field_decl_a($3);}
			|field_decl_b
			 {$$.push_back($1);}
			 ;

field_decl_b : ID
			 {$$ = new field_decl_b(string($1));}
			 | ID SQ_OPEN_BRAC int_literal SQ_CLOSED_BRAC
			 {$$.push_back(string($1))}
			 ;

method_a : method_decl
		 {$$ = new method_a(($1);}
		 | method_a method_decl
		 ;
	
method_decl : type ID OPEN_PAREN method_decl_a CLOSED_PAREN block
			{$$=new method_decl(string($1),string($2),$4,$6);}
			| type ID OPEN_PAREN CLOSED_PAREN block
			{$$.push_back(string($1),string($2),$4);}
			| VOID ID OPEN_PAREN CLOSED_PAREN block
			{$$.push_back(string($1),string($2),$4);}
			| VOID ID OPEN_PAREN method_decl_a CLOSED_PAREN block 
			{$$.push_back(string($1),string($2),$4,$6);}
			
			;

method_decl_a : method_decl_b
				{$$=new method_decl_a($3);}
			  | method_decl_a COMMA method_decl_b 
			   {$$.push_back($3);}
			  ; 

method_decl_b : type ID
				{$$=new method_decl_b(string($1),string($2);}	
			  ;

block : LEFT_BRACES var_decl_a statement_decl_a RIGHT_BRACES
		{$$=new block($2,$3);}
	  | LEFT_BRACES var_decl_a RIGHT_BRACES
	   {$$.push_back($2);}
	  | LEFT_BRACES statement_decl_a RIGHT_BRACES
	   {$$.push_back($2);}
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