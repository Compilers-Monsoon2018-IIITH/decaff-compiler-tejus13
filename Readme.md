													README

STRUCTURE:

main.cpp- Starting point of the project. Contains the main method.

ast.h- Contains Defintion of all AST Nodes

scanner.l- Defines the lexer class Scanner for tokenizing

Parser.y- Contains grammer of decaf program=

Makefile: Contains the logic to compile and build the binaries.



RUN:

Compile -make
run - ./parser

DESCRIPTION:

Tokenization is done in scanner.l
All Classes defines in ast.h
Parsing File in parser.y

Yet to implement- LLVM code generation.