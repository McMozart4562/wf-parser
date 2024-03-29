%{

  /*
   * Parser.y file
   * To generate the parser run: "bison Parser.y"
   */
  
#include "Expression.h"
#include "Parser.h"
#include "Lexer.h"
  
int yyerror(SExpression **expression, yyscan_t scanner, const char *msg){
  printf("Error%s\n", msg);
  return 1;
}

%}

%code requires {
  typedef void* yyscan_t;
 }

%output "Parser.c"
%defines "Parser.h"

%define api.pure
%lex-param { yyscan_t scanner }
%parse-param { SExpression **expression }
%parse-param { yyscan_t scanner }


%union {
  int value;
  SExpression *expression;
}

%token TOKEN_LPAREN "("
%token TOKEN_RPAREN ")"
%token TOKEN_PLUS "+"
%token TOKEN_STAR "*"
%token <value> TOKEN_NUMBER "number"

%type <expression> expr

%left "+"
%left "*"

%%

input
	: expr { *expression = $1; }
;

expr
	: expr[L] "+" expr[R] { $$ = createOperation( eADD, $L, $R); }
	| expr[L] "*" expr[R] { $$ = createOperation( eMULTIPLY, $L, $R); }
	| "(" expr[E] ")"     { $$ = $E; }
	| "number"    	      { $$ = createNumber($1);}
	;

%%
  
