%{
    #include "Brainwords.hpp"
%}

%defines %union { int n; std::string *s; char c; }

%token<n> INT
%token<c> CHAR
%token<s> STR DIR FILENAME

%token VERBOSE BITS ADDRESS PHRASE

%type<s> file

%%
ini: | ini ex

ex: INT             { std::cout << " int:" <<  $1 << std::endl; }
  | CHAR            { std::cout << "char:" <<  $1 << std::endl; }
  | STR             { std::cout << " str:" << *$1 << std::endl; }
  | VERBOSE         { verbose = true;
                        std::cout << "verbose:" << verbose << std::endl; }
  | BITS INT        { bits = $2;
                        std::cout << "bits:" << bits << std::endl;
                        switch (bits) {
                            case 16: case 20: case 24: break;
                            default: yyerror("bad bits");
                        }}
  | ADDRESS file    { address = *$2;
                       std::cout << "address:" << address << std::endl; }
  | PHRASE  file    { phrase  = *$2;
                       std::cout << "phrase:" << phrase << std::endl; }
  | file            { std::cout << "file:" << *$1 << std::endl; }

file : DIR FILENAME { $$ = new std::string(*$1 + *$2); }
     |     FILENAME { $$ = $1;      }
%%

void yyerror(const char *msg) {
    fprintf(stderr, "\n%s:%i %s [%s]\n\n", yyfile, yylineno, msg, yytext);
    exit(-1);
}
