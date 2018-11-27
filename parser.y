%{
	#include <stdio.h>	
	int yylex();
%}
using namespace std ;

extern "C" int yylex();
extern "C" int yyparse();
extern ASTProgram* AstRoot;

%start Program
%token CLASS
%token PROGRAM
%token <str_val> ID
%token <str_val> VOID
%token <str_val> TRUE
%token <str_val> FALSE

%token CALLOUT
%token INT
%token BOOL
%token IF
%token ELSE
%token FOR 
%token RETURN
%token CONTINUE
%token BREAK
%token <str_val> AND
%token <str_val> OR
%token <str_val> NOT
%token <str_val> NET
%token <str_val> GT
%token <str_val> LT
%token <str_val> GTE
%token <str_val> LTE
%token <str_val> IET
%token <int_val> HEX_LITERAL
%token <int_val> DIGIT
%token <str_val> CHAR
%token <str_val> STRING
%token <str_val> PLUS
%token <str_val> MINUS
%token <str_val> EQUAL
%token <str_val> MULTIPLY
%token <str_val> DIVIDE
%token <str_val> MOD
%token <str_val> PLUSEQUAL
%token <str_val> MINUSEQUAL
%token <str_val> MULEQUAL
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
%left NOT
%left OR
%left AND 
%left NET IET
%left LTE GTE LT GT
%left PLUS MINUS
%left MULTIPLY DIVIDE MOD


%type<str_val> type;
%type<_program> Program;
%type<_field_declaration> field_declaration;
%type<_field_decl> field_decl;
%type<_field_decl_a_iden> field_decl_a;
%type<_arrayIdentifier> Array;
%type<_method_declaration> method_declaration;
%type<_method_decl> method_decl;



%%
Program : CLASS PROGRAM LEFT_BRACES field_declaration method_declaration RIGHT_BRACES {$$ = new ASTProgram($4,$5); AstRoot=$$;}
		| CLASS PROGRAM LEFT_BRACES field_declaration RIGHT_BRACES {$$ = new ASTProgram($4,NULL); AstRoot=$$;}
		| CLASS PROGRAM LEFT_BRACES method_declaration RIGHT_BRACES {$$ = new ASTProgram(NULL,$5); AstRoot=$$;}
		| CLASS PROGRAM LEFT_BRACES RIGHT_BRACES {$$ = new ASTProgram(NULL,NULL); AstRoot=$$;}
		;
		

field_declaration : field_decl {$$ = new vector<FieldDeclaration*>(); $$->push_back($1);}
				  | field_declaration field_decl {$$=$1 ;$$->push_back($2);}
				  ;


field_decl : type field_decl_a SEMI_COLON {$$ = new FieldDeclaration($1, $2);}
		   ;


field_decl_a : 	ID {$$ = new vector <Identifier*>(); $$->push_back(new SimpleIdentifier($1));}
				| ID COMMA field_decl_a { $$ = $3; $$->push_back(new SimpleIdentifier($1));}
				| Array {$$ = new vector <Identifier*>(); $$->push_back($1);}
				| Array COMMA field_decl_a {$$ = $3; $$->push_back($1);}
				;


Array 	: ID SQ_OPEN_BRAC int_literal SQ_CLOSED_BRAC {$$=new ArrayIdentifier($1,$3);}
		;

method_declaration : method_decl  {$$-new vector<MethodDeclaration *>(); $$->push_back($1);}
		 | method_declaration method_decl {$$=$1 ;$$->push_back($2);}
		 ;
	
method_decl : type ID OPEN_PAREN method_decl_a CLOSED_PAREN block {$$=new MethodDeclaration($1,$2,$4,$6);}
			| type ID OPEN_PAREN CLOSED_PAREN block {$$=new MethodDeclaration($1,$2,NULL,$5);}
			| VOID ID OPEN_PAREN CLOSED_PAREN block {$$=new MethodDeclaration($1,$2,NULL,$5);}
			| VOID ID OPEN_PAREN method_decl_a CLOSED_PAREN block {$$=new MethodDeclaration($1,$2,$4,$6);}
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