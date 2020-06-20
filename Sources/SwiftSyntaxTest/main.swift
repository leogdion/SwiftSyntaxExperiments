
import SwiftSyntax

let printIdentifer = SyntaxFactory.makeIdentifierExpr(identifier: SyntaxFactory.makeIdentifier("print"), declNameArguments: nil)

let exprSyntax = ExprSyntax(printIdentifer)
let funcCall = SyntaxFactory.makeFunctionCallExpr(calledExpression: exprSyntax, leftParen: nil, argumentList: SyntaxFactory.makeTupleExprElementList([]), rightParen: nil, trailingClosure: nil)


let structKeyword = SyntaxFactory.makeStructKeyword(trailingTrivia: .spaces(1))

let identifier = SyntaxFactory.makeIdentifier("Example", trailingTrivia: .spaces(1))

let leftBrace = SyntaxFactory.makeLeftBraceToken()
let rightBrace = SyntaxFactory.makeRightBraceToken(leadingTrivia: .newlines(1))
let members = MemberDeclBlockSyntax { builder in
    builder.useLeftBrace(leftBrace)
    builder.useRightBrace(rightBrace)
}

let structureDeclaration = StructDeclSyntax { builder in
  
    builder.useStructKeyword(structKeyword)
    builder.useIdentifier(identifier)
    builder.useMembers(members)
}

print(funcCall)
