%{
#include "parser.tab.h"
int lineno = 0;
%}

%%
"true"              {return TRUE;}
"false"             {return FALSE;}
"callout"           {return CALLOUT;}
"int"               {return INT;}
"if"                {return IF;}
"else"              {return ELSE;}
"for"               {return FOR;}
"return"            {return RETURN;}
"continue"          {return CONTINUE;}
"break"             {return BREAK;}
[a-zA-Z][a-zA-Z]*	{return ID;}
"+"					{return '+';}
"-"					{return '-';}
"*"					{return '*';}
"/"					{return '/';}
"%"                 {return '%';}
"="                 {return '=';}
"(" 				{return '(';}
")"					{return ')';}
"!"                 {return '!';}

"&&"                {return AND;}
"||"                {return OR;}
"!="                {return NET;}
"<"                 {return GT;}
">"                 {return LT;}
"<="                {return GTE;}
">="                {return LTE;}
"=="                {return IET;}
0x[a-fA-F0-9]*      {return HEX_LITERAL;}
[0-9][0-9]*         {return DIGIT;}
[ \t]				{ }
\n		     		{++lineno;}
.					{ printf("Line No %d: Unrecognized Character\n", lineno); }
%%
