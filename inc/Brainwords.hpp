/// @file
/// @brief Find Lost Bitcoin Passphrases (Brainwallet)
#pragma once

/// @defgroup bw bw
/// @{

/// @defgroup libc libc
/// @{
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include <iostream>
#include <sstream>
#include <list>
#include <bitset>
/// @}

/// @defgroup main main
/// @{

/// @brief POSIX entry point
/// @param[in] argc number of command line arguments
/// @param[in] argv values (0 = binary program file)
int main(int argc, char *argv[]);
/// @brief print command line argument
void arg(int argc, char *argv);
/// @}

/// @defgroup parser parser
/// @{
extern int yylex();                    ///< lexer
extern int yylineno;                   ///< curren line
extern char *yytext;                   ///< parsed literal
extern FILE *yyin;                     ///< input file
extern char *yyfile;                   ///< file name
extern int yyparse();                  ///< parser
extern void yyerror(const char *msg);  ///< syntax error callback
#include "Brainwords.parser.hpp"
#define TOKEN(C, X)               \
    {                             \
        yylval.o = new C(yytext); \
        return X;                 \
    }
/// @}

/// @}
