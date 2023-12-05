import std/[macros]

#[
dumpAstGen:
    var a: int

OUTPUT
    nnkStmtList.newTree(
        nnkVarSection.newTree(
            nnkIdentDefs.newTree(
            newIdentNode("a"),
            newIdentNode("int"),
            newEmptyNode()
            )
        )
    )
]#

# With macros and templates, you can pass variables as either typed or untyped
# Typed variables are type checked before the macro is expanded
# Untyped variables are type checked after the macro is expanded

# Macros modify the AST

macro astDeclare(name, varType: typed) =
    let stmtList = newNimNode(nnkStmtList)
    let varSect = newNimNode(nnkVarSection)
    var identDefs = newNimNode(nnkIdentDefs)
    stmtList.add varSect
    varSect.add identDefs
    identDefs.add newIdentNode(name.strVal)
    identDefs.add newIdentNode(varType.strVal)
    identDefs.add newEmptyNode()
    return stmtList

# Quote accepts a block of code and returns an AST partial tree

macro init(i) = quote do:
    let `i` = 0

# Templates simply insert code where they are called

template log(msg: untyped) =
    echo msg
    a = 12

expandMacros:
    astDeclare("a", "int")
    a = 45
    init b
    log b == 0
    echo a # 12

# Macros are extremely powerful and can be used to implement new language features
# By principle, we should try to use first a procedure, then a template, and only
# if those are not enough, a macro

# Type of things macros can do:

macro public*(stmtlist: typed) =
    ## Makes all types defined inside it have public variables.
    ##
    ## ```
    ## public:
    ##   type
    ##     A = object
    ##       a*: int
    ##       b: int
    ## ```
    ##  is transformed into
    ## ```
    ## type
    ##   A = object
    ##     a*: int
    ##     b*: int
    for typeSection in stmtlist:
        for typeDef in typeSection:
            let objTy = typeDef[2]
            objTy.expectKind(nnkObjectTy)
            let recList = objTy[2]
            recList.expectKind(nnkRecList)
            for iDefs in recList:
                if iDefs[0].kind != nnkPostfix:
                    var prototype = newNimNode(nnkPostfix, iDefs[0])
                    prototype.add ident("*")
                    prototype.add iDefs[0]
                    iDefs[0] = prototype
    return stmtlist
