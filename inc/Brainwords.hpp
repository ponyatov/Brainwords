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
extern int yylineno;                   ///< curren line number
extern char *yytext;                   ///< parsed token literal
extern FILE *yyin;                     ///< input file
extern char *yyfile;                   ///< current file name
extern int yystr(std::string s);       ///< parse string
extern int yyparse();                  ///< parser
extern void yyerror(const char *msg);  ///< syntax error callback
#include "Brainwords.parser.hpp"
#define TOKEN(X)                 \
    {                            \
        yylval.n = atoi(yytext); \
        return X;                \
    }
#define TOKEC                 \
    {                         \
        yylval.c = yytext[0]; \
        return CHAR;          \
    }
#define TOKES(X)                            \
    {                                       \
        yylval.s = new std::string(yytext); \
        return X;                           \
    }
/// @}

/// @defgroup config config
/// @{
extern bool verbose;         ///< verbose output
extern int bits;             ///< 16 or 20 or 24
extern std::string address;  ///< `--inputAddress addresses.txt`
extern std::string phrase;   ///< `--inputPhrase dictionary.txt`
/// @}

/// @}
