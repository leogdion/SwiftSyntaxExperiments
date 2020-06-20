import SwiftSyntax

let printIdentiferExpr = ExprSyntax(
  SyntaxFactory.makeIdentifierExpr(
    identifier: SyntaxFactory.makeIdentifier("print"),
    declNameArguments: nil))
let exprParameter = ExprSyntax(SyntaxFactory.makeStringLiteralExpr("Hello World"))
let tupleArg = SyntaxFactory.makeTupleExprElement(
  label: nil, colon: nil, expression: exprParameter, trailingComma: nil)
let funcCall = SyntaxFactory.makeFunctionCallExpr(
  calledExpression: printIdentiferExpr,
  leftParen: SyntaxFactory.makeLeftParenToken(),
  argumentList: SyntaxFactory.makeTupleExprElementList([tupleArg]),
  rightParen: SyntaxFactory.makeRightParenToken(),
  trailingClosure: nil)

print(funcCall)
