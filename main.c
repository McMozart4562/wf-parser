/*
 * main.c file
 */

#include "Expression.h"
#include "Parser.h"
#include "Lexer.h"

#include <stdio.h>

int yyparse(SExpression **expression, yyscan_t scanner);


SExpression *getAST(const char *expr)
{
  SExpression *expression;
  yyscan_t scanner;
  YY_BUFFER_STATE state;

  if(yylex_init(&scanner)) {
    return NULL;
  }

  state = yy_scan_string(expr, scanner);

  if (yyparse(&expression, scanner)){
    return NULL;
  }

  yy_delete_buffer(state, scanner);
  yylex_destroy(scanner);

  return expression;
}

int evaluate(SExpression *e)
{
  switch(e->type) {
  case eVALUE:
    return e->value;
  case eMULTIPLY:
    return evaluate(e->left) * evaluate(e->right);
  case eADD:
    return evaluate(e->left) + evaluate(e->right);
  default:
    return 0;
  }
}

int main(void)
{
  char test[] = "4+2*10+3*(5+1)";
  SExpression *e = getAST(test);
  int result = evaluate(e);
  printf("Result of '%s' is %d\n", test, result);
  deleteExpression(e);
  return 0;
} 
