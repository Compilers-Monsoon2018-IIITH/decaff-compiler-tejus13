%{
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
\'[A-Za-z]\'        {return CHAR;}
\"[A-Za-z]*\"       {return STRING;}
[a-zA-Z]([a-zA-Z]|[0-9])*	{return ID;}
[ \t\r]				/* comment */
\n		     		/* comment */
"(" 				{return OPEN_PAREN;}
")" 				{return CLOSED_PAREN;}
"{"                 {return LEFT_BRACES;}
"}"                 {return RIGHT_BRACES;}
"["                 {return SQ_OPEN_BRAC;}
"]"                 {return SQ_CLOSED_BRAC;}
","                 {return COMMA;}
"!"                 {return NOT;}
"+"                 {return PLUS;}
"-"                 {return MINUS;}
"*"                 {return MULTIPLY;}
"/"                 {return DIVIDE;}
"%"                 {return MOD;}
"="                 {return EQUAL;}
"+="                {return PLUSEQUAL;}
"*="                {return MULEQUAL;}
"-="                {return MINUSEQUAL;}
"&&"                {return AND;}
"\\"                {return COMMENTS;}
"||"                {return OR;}
"!="                {return NET;}
"<"                 {return GT;}
">"                 {return LT;}
"<="                {return GTE;}
">="                {return LTE;}
"=="                {return IET;}
";"                 {return SEMI_COLON;}
0x[a-fA-F0-9]+      {return HEX_LITERAL;}
[0-9][0-9]*         {return DIGIT;}


%%
