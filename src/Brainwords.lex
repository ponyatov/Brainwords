%{
    #include "Brainwords.hpp"
    char *yyfile = nullptr;
%}

%option noyywrap yylineno

sign     [+\-]
dec      [0-9]
alpha    [_a-zA-Z]
alphanum [_a-zA-Z0-9]

%%

#[^\n]*             {}      // line comment
[ \t\r\n]+          {}      // drop spaces
{sign}?{dec}+       TOKEN
{alpha}{alphanum}*  TOKES
.                   TOKEC   // any char

%%

int yystr(std::string s) {
    yyfile = "_";
    YY_BUFFER_STATE buf = yy_scan_string(s.c_str());
    int ret = yyparse();
    yy_delete_buffer(buf);
    yyfile = nullptr;
    return ret;
}
