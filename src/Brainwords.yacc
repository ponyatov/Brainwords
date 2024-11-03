%{
    #include "Brainwords.hpp"
%}

%defines %union { int n; char *s; char c; }

%%
ini:
%%

void yyerror(const char *msg) {
    fprintf(stderr, "\n%s:%i %s [%s]\n\n", yyfile, yylineno, msg, yytext);
    exit(-1);
}
