import SwiftSyntax

/*

 #if canImport(PackageConfig)
   import PackageConfig

   let config = PackageConfiguration([
     "komondor": [
       "pre-push": "swift test --enable-code-coverage --enable-test-discovery",
       "pre-commit": [
         "swift test --enable-code-coverage --enable-test-discovery --generate-linuxmain",
         "swift run swiftformat .",
         "swift run swiftlint autocorrect",
         "swift run sourcedocs generate --spm-module eggseed -r",
         "swift run swiftpmls mine",
         "git add .",
         "swift run swiftformat --lint .",
         "swift run swiftlint"
       ]
     ]
   ]).write()
 #endif
 */
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

var ifBegin = CodeBlockItemSyntax { (builder) in
  builder.useItem(Syntax(ifClause))
}
let ifEnd = CodeBlockItemSyntax { (builder) in
  builder.useItem(Syntax(SyntaxFactory.makePoundEndifKeyword()))
}


let preCommitItems = [
        "swift test --enable-code-coverage --enable-test-discovery --generate-linuxmain",
        "swift run swiftformat .",
        "swift run swiftlint autocorrect",
        "swift run sourcedocs generate --spm-module eggseed -r",
        "swift run swiftpmls mine",
        "git add .",
        "swift run swiftformat --lint .",
        "swift run swiftlint"
  ].map{
    SyntaxFactory.makeArrayElement(expression: ExprSyntax(SyntaxFactory.makeStringLiteralExpr($0)), trailingComma: SyntaxFactory.makeCommaToken())
    
}

var array = SyntaxFactory.makeArrayExpr(
  leftSquare: SyntaxFactory.makeLeftSquareBracketToken(),
  elements: SyntaxFactory.makeArrayElementList(preCommitItems),
  rightSquare: SyntaxFactory.makeRightSquareBracketToken())

array.trailingTrivia = .newlines(1)

ifBegin.trailingTrivia = Trivia.newlines(1)





let importPC = CodeBlockItemSyntax { (builder) in
  builder.useItem(Syntax(
    SyntaxFactory.makeImportDecl(attributes: nil, modifiers: nil, importTok: SyntaxFactory.makeImportKeyword(leadingTrivia: .newlines(1), trailingTrivia: .spaces(1)), importKind: nil, path: SyntaxFactory.makeAccessPath([SyntaxFactory.makeAccessPathComponent(name: exprParameter, trailingDot: nil)]))))
}


//icBuilder.useValue(FunctionCallExprSyntax { fceBuilder in
//    fceBuilder.useCalledExpression(SyntaxFactory.makeIdentifierExpr(identifier: SyntaxFactory.makeUnknown(stringRepresentation), declNameArguments: nil))
//    fceBuilder.addFunctionCallArgument(SyntaxFactory.makeBlankFunctionCallArgument())
//    fceBuilder.useLeftParen(SyntaxFactory.makeLeftParenToken())
//    fceBuilder.useRightParen(SyntaxFactory.makeRightParenToken())
//})

let initCfg = InitializerClauseSyntax { (builder) in
  builder.useEqual(SyntaxFactory.makeEqualToken())
  let funcCall = FunctionCallExprSyntax { (builder) in
    
    builder.useCalledExpression(
      ExprSyntax(SyntaxFactory.makeIdentifierExpr(identifier: SyntaxFactory.makeUnknown("PackageConfig"), declNameArguments: nil)))
    builder.addArgument(TupleExprElementSyntax({ (builder) in
      builder.useExpression(ExprSyntax(array))
    }))
    
  }
  builder.useValue(ExprSyntax(funcCall))
}
//SyntaxFactory.makeInitializerClause(equal: SyntaxFactory.makeEqualToken(), value: ExprSyntax(array))
let config = SyntaxFactory.makeIdentifierPattern(identifier: SyntaxFactory.makeIdentifier("config"))
let bindings = SyntaxFactory.makePatternBinding(pattern: PatternSyntax(config), typeAnnotation: nil, initializer: initCfg, accessor: nil, trailingComma: nil)

let variable = SyntaxFactory.makeVariableDecl(attributes: nil, modifiers: nil, letOrVarKeyword: SyntaxFactory.makeLetKeyword(leadingTrivia: .zero, trailingTrivia: .spaces(1)), bindings: SyntaxFactory.makePatternBindingList([bindings]))

let codeBlockItem = CodeBlockItemSyntax { (builder) in
  builder.useItem(Syntax(variable))
}
let codeBlock = SyntaxFactory.makeCodeBlockItemList([ifBegin,importPC, codeBlockItem, ifEnd])

let member = MemberDeclListItemSyntax { (builder) in
  builder.useDecl(DeclSyntax(
    VariableDeclSyntax({ (builder) in
      builder.useLetOrVarKeyword(SyntaxFactory.makeLetKeyword(leadingTrivia: .zero, trailingTrivia: .spaces(1)))
      builder.addBinding(PatternBindingSyntax({ (builder) in
        builder.usePattern(PatternSyntax(config))
        
        builder.useTypeAnnotation(SyntaxFactory.makeTypeAnnotation(colon: SyntaxFactory.makeColonToken(), type: SyntaxFactory.makeTypeIdentifier("PackageConfig")))
        builder.useInitializer(initCfg)
      }))
  })))
}
print(member)
