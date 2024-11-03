%{
    #include "Brainwords.hpp"
%}

%defines %union { int n; std::string *s; char c; }

%token<n> INT
%token<c> CHAR
%token<s> STR

%%
ini: | ini ex

ex: INT  { std::cout << " int:" << $1 << std::endl; }
  | CHAR { std::cout << "char:" << $1 << std::endl; }
  | STR  { std::cout << " str:" << *$1 << std::endl; delete $1; }

%%

void yyerror(const char *msg) {
    fprintf(stderr, "\n%s:%i %s [%s]\n\n", yyfile, yylineno, msg, yytext);
    exit(-1);
}
