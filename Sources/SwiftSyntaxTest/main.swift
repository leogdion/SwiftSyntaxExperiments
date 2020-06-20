import SwiftSyntax


let printIdentiferExpr = ExprSyntax(
  SyntaxFactory.makeIdentifierExpr(
    identifier: SyntaxFactory.makeIdentifier("canImport"),
    declNameArguments: nil))

let exprParameter = SyntaxFactory.makeToken(.contextualKeyword("PackageConfig"), presence: .present)


let accessPath = SyntaxFactory.makeAccessPath([])

let syntax = SyntaxFactory.makeImportDecl(attributes: nil, modifiers: nil, importTok: exprParameter, importKind: nil, path: accessPath)

let tupleArg = SyntaxFactory.makeTupleExprElement(
  label: nil, colon: nil, expression: ExprSyntax(SyntaxFactory.makeIdentifierExpr(identifier: exprParameter, declNameArguments: nil)), trailingComma: nil)
let funcCall = SyntaxFactory.makeFunctionCallExpr(
  calledExpression: printIdentiferExpr,
  leftParen: SyntaxFactory.makeLeftParenToken(),
  argumentList: SyntaxFactory.makeTupleExprElementList([tupleArg]),
  rightParen: SyntaxFactory.makeRightParenToken(),
  trailingClosure: nil)

var pundif = SyntaxFactory.makePoundIfKeyword()
pundif.trailingTrivia = .spaces(1)

let ifClause = SyntaxFactory.makeIfConfigClause(poundKeyword: pundif, condition: nil, elements: Syntax(funcCall))
print(ifClause)
