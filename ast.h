#include <vector>
#include <string>
#include <iostream>
#include "visitor.h"

using namespace std;

class ASTNode;
class ASTProgram;
class FieldDeclaration;
class Identifier;
class IntLitExpression;
class ArrayIdentifier;
class MethodDeclaration;

enum DataType {
    int_type,
    bool_type,
    void_type
};

union NODE {
    int int_val;
    char *str_val;
    ASTProgram *_program;
    vector<FieldDeclaration *> * _field_declaration;
    FieldDeclaration * _field_decl;
    vector<Identifier *> * _field_decl_a_iden;
    ArrayIdentifier* _arrayIdentifier;
    vector<SimpleIdentifier *> * _simpleIdentifier;
    vector<MethodDeclaration *> *_method_declaration;
    MethodDeclaration * _method_decl;
    IntLitExpression* _literal;

    DataType _type;
};

typedef union NODE YYSTYPE;

class ASTNode 
{
public:
    ASTNode() {}
    ~ASTNode() {}
};

class ASTProgram : public ASTNode 
{
    vector<FieldDeclaration *> * field_declaration;
    vector<MethodDeclaration *> * method_declaration;
public:
    //constructor defining

    ASTProgram(vector<FieldDeclaration *> *field_declaration, vector<MethodDeclaration *> * method_declaration) 
    {
        this->field_declaration = field_declaration;
        this->method_declaration = method_declaration;
    }

    //destructor
    ~ASTProgram(){}
};



class FieldDeclaration : public ASTNode {
    string type;
    vector<Identifier *> * Identifiers;
public:
    FieldDeclaration(string type, vector<Identifier *> * Identifiers){
        this->type = type;
        this->Identifiers = Identifiers;
    }
    ~FieldDeclaration(){}
};


class Identifier :public ASTNode {
public:
    Identifier() {}
    ~Identifier() {}
};

class SimpleIdentifier : public Identifier {
    string id;
public:
    SimpleIdentifier(string id) {
        this->id = id;
    }
    ~SimpleIdentifier(){}
};

class ArrayIdentifier  : public Identifier {
    string id;
    int arr_size;
public:
    ArrayIdentifier(string id, string size) {
        this->id = id;
        this->arr_size = stol(size);
    }
    ~ArrayIdentifier(){}
};
class IntLitExpression : public ASTNode {
    int value;
public:
    IntLitExpression(string val) {
        this->value = stol(val);
    }    ~IntLitExpression() {}
};

class MethodDeclaration : public ASTNode {
    /* field declarations */
public:
    MethodDeclaration(){}
    ~MethodDeclaration(){}

};




