import SwiftSyntax


let printIdentiferExpr = ExprSyntax(
  SyntaxFactory.makeIdentifierExpr(
    identifier: SyntaxFactory.makeIdentifier("canImport"),
    declNameArguments: nil))

let exprParameter = SyntaxFactory.makeToken(.contextualKeyword("PackageConfig"), presence: .present)
let accessPath = SyntaxFactory.makeAccessPath([])

let syntax = SyntaxFactory.makeImportDecl(attributes: nil, modifiers: nil, importTok: exprParameter, importKind: nil, path: accessPath)
//let tupleArg = SyntaxFactory.makeTupleExprElement(
//  label: nil, colon: nil, expression: exprParameter, trailingComma: nil)
//let funcCall = SyntaxFactory.makeFunctionCallExpr(
//  calledExpression: printIdentiferExpr,
//  leftParen: SyntaxFactory.makeLeftParenToken(),
//  argumentList: SyntaxFactory.makeTupleExprElementList([tupleArg]),
//  rightParen: SyntaxFactory.makeRightParenToken(),
//  trailingClosure: nil)

//let ifClause = SyntaxFactory.makeIfConfigClause(poundKeyword: SyntaxFactory.makePoundIfKeyword(), condition: nil, elements: funcCall)
print(syntax)
