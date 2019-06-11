%{
/*
 * Lexer.l
 * To generate the lexical analyzer flex Lexer.l
 */

#include "Expression.h"
#include "Parser.h"

#include <stdio.h>

%}


%option outfile="Lexer.c" header-file="Lexer.h"
%option warn nodefault

%option reentrant noyywrap never-interactive nounistd
%option bison-bridge

%%

[ \r\n\t]*	{ continue; /*Skips blanks*/ }
[0-9]+		{ scanf(yytext, "%d", &yylval->value);
		  return TOKEN_NUMBER;}

"*"		{ return TOKEN_STAR; }
"+"		{ return TOKEN_PLUS; }
"("		{ return TOKEN_LPAREN; }
")"		{ return TOKEN_RPAREN; }

.		{ continue; }

%%

/* int yyerror(const char *msg){
*     fprintf(stderr, "Error:%s\n", msg);
*     return 0;
*      }
*/



