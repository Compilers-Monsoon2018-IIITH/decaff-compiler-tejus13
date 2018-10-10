parser: parser.y scanner.l
		bison -vd parser.y
		flex scanner.l
		gcc -o parser parser.tab.c lex.yy.c -ll
