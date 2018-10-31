%{
#include<bits/stdc++.h>
#include "parser.tab.h"
%}

%%

"class"             {return CLASS;}
"Program"           {return PROGRAM;}
"true"              {return TRUE;}
"false"             {return FALSE;}
"callout"           {return CALLOUT;}
"int"               {return INT;}
"bool"              {return BOOL;}
"void"              {return VOID;}
"if"                {return IF;}
"else"              {return ELSE;}
"for"               {return FOR;}
"return"            {return RETURN;}
"continue"          {return CONTINUE;}
"break"             {return BREAK;}

[a-zA-Z][a-zA-Z0-9]*	{return ID;}
\'[A-Za-z]\'        {yylval.value = strdup(yytext);return CHAR;}
\"[A-Za-z]*\"       {yylval.value = strdup(yytext);return STRING;}
\/\/.*\n            
\t
[ ]				/* comment */
\n		     		/* comment */
"(" 				{return OPEN_PAREN;}
")" 				{return CLOSED_PAREN;}
"{"                 {return LEFT_BRACES;}
"}"                 {return RIGHT_BRACES;}
"["                 {return SQ_OPEN_BRAC;}
"]"                 {return SQ_CLOSED_BRAC;}
","                 {return COMMA;}
"!"                 {return NOT;}
"+"                 {yylval.value = strdup(yytext);return PLUS;}
"-"                 {yylval.value = strdup(yytext);return MINUS;}
"*"                 {yylval.value = strdup(yytext);return MULTIPLY;}
"/"                 {yylval.value = strdup(yytext);return DIVIDE;}
"%"                 {yylval.value = strdup(yytext);return MOD;}
"="                 {yylval.value = strdup(yytext);return EQUAL;}
"+="                {yylval.value = strdup(yytext);return PLUSEQUAL;}
"*="                {yylval.value = strdup(yytext);return MULEQUAL;} 
"-="                {yylval.value = strdup(yytext);return MINUSEQUAL;}
"&&"                {yylval.value = strdup(yytext);return AND;}

"||"                {yylval.value = strdup(yytext);return OR;}
"!="                {yylval.value = strdup(yytext);return NET;}
"<"                 {yylval.value = strdup(yytext);return GT;}
">"                 {yylval.value = strdup(yytext);return LT;}
"<="                {yylval.value = strdup(yytext);return GTE;}
">="                {yylval.value = strdup(yytext);return LTE;}
"=="                {yylval.value = strdup(yytext);return IET;}

";"                 {return SEMI_COLON;}
0x[a-fA-F0-9]+      {return HEX_LITERAL;}
[0-9][0-9]*         {return DIGIT;}
"//".*                {return COMMENTS;}
%%
