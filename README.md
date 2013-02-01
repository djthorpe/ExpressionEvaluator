ExpressionEvaluator
===================

Using Lex and Yacc with Objective-C

Lex and Yacc are tools which allow you to create text scanners and parsers. If you're looking
to develop a calculator, compiler or anything which needs to decompose a series of text
statements into something a computer can understand, you can use Lex and Yacc to do this.

 * Lex will accept a sequence of characters and use rules you specify to spit out a series of
   symbolic tokens. 
 * Yacc will take the symbolic tokens and will construct a semantic tree (or simply execute 
   code) based on matching rules that you specify.

If you simply want a Lexical analyser, the `NSScanner` class could be used. But if you want to
be able to parse more complex things then the Lex and Yacc combination is a good choice and can
be used directly within XCode. There's plenty of documentation available on making the rules,
which I won't cover here. But I will cover how it works with Objective-C. There is also an
O'Reilly book called "Building Cocoa Applications" (BookBuildingCocoaApplications) which
describes how to create a calculator parser, but they completely chicken out of integrating it
directly into Objective C for some reason, and pipe the input and output through to a C program
instead.

I firstly define a "Node" class which is the superclass of the following kinds of node:
StringNode, BooleanNode, NumberNode, IdentifierNode, FunctionNode and ArrayNode. Each of these
has a class method to create an autoreleased class instance:

```objc +(StringNode )stringWithQuotedCString:(const char )cString; +(BooleanNode )trueNode;
+(BooleanNode )falseNode; +(NumberNode )numberWithCString:(const char )cString;
+(IdentifierNode )identifierWithCString:(const char )cString; +(FunctionNode )function:(Node
)theFunction withArray:(Node )theNode; +(ArrayNode )arrayWithNode:(Node )theArrayOrNode
withNode:(Node )theNode; ```

My expression parser is very simple and will accept the following kinds of expressions:

``` (a AND b) (a OR b) NOT(a) AND(a,b) 1 + 2 4 - 3 a := 100 a = 100 (a = 'foo') OR (b = TRUE)
```

These will end up being expressed in the following manner when passed through Lex and Yacc:

```objc FunctionNode(@"AND",ArrayNode(IdentifierNode(@"a"),IdentifierNode(@"b"),nil))
FunctionNode(@"OR",ArrayNode(IdentifierNode(@"a"),IdentifierNode(@"b"),nil))
FunctionNode(@"NOT",ArrayNode(IdentifierNode(@"a"),nil))
FunctionNode(@"AND",ArrayNode(IdentifierNode(@"a"),IdentifierNode(@"b"),nil))
FunctionNode(@"PLUS",ArrayNode(NumberNode(1),NumberNode(2),nil))
FunctionNode(@"MINUS",ArrayNode(NumberNode(4),NumberNode(3),nil))
FunctionNode(@"ASSIGN",ArrayNode(IdentifierNode(@"a"),NumberNode(100),nil))
FunctionNode(@"EQUALS",ArrayNode(IdentifierNode(@"a"),NumberNode(100),nil))
FunctionNode(@"OR",ArrayNode(FunctionNode(@"EQUALS",ArrayNode(IdentifierNode(@"a"),StringNode(@"foo"))),FunctionNode(@"EQUALS",ArrayNode(IdentifierNode(@"b"),BooleanNode(YES)))
```

These look much more complicated, but are trival for the computer to evaluate programmatically.
To achieve this, create your two "rules" files. The file extensions contain "m" to indicate
they are Objective-C files rather than plain old C.

ExpressionLexer.lm will contain the rules for converting the input into the symbolic tokens.
ExpressionParser.ym contains the rules and actions for creating a parsed tree of nodes.

Finally, an Objective-C class called ExpressionEvaluator.m will contain the important method
yyYYINPUT which is called by the lex/yacc combination to read the input. Note there is one
global variable which contains the current parsed node. Because lex and yacc use global
variables, there can only be one evaluator running at any one time. You can return a shared
evaluator object [ExpressionEvaluator sharedEvaluator] which includes thread-level locking to
ensure that the parsing is done serially. So, you can now parse an expression:

```objc Node theExpression = [[ExpressionEvaluator sharedEvaluator] parse:@"(a_variable =
'test') AND (b_variable = 102)"]; ```

The parse method will return a nil value and throw an exception in the case of a syntax error.
When an expression is parsed successfully, a Node object is returned, which may be a
BooleanNode, FunctionNode, NumberNode or StringNode. At this point, you may want to cache away
your parse trees or you may want to evaluate them. Create the following abstract method in the
Node class:

```objc @implementation Node ... -(NSObject )evaluateWithDictionary:(NSDictionary
)theDictionary { return nil; } ... @end ```

Each Node subclass will need to implement this abstract method. The method should return an
NSObject (which will likely be an NSNumber or NSString). I have included a "dictionary"
argument so that a dictionary of variable key/value pairs can be used when evaluating the
IdentifierNode instances. Here is an evaluator for identifiers:

```objc @implementation IdentifierNode ... -(NSObject )evaluateWithDictionary:(NSDictionary
)theDictionary { NSObject theValue = [theDictionary objectForKey:[self identifier]];
if(theValue==nil) { [[NSException exceptionWithName:@"VariableNotFoundException"
reason:[[[NSString]] stringWithFormat:@"Variable not found: %@",[self identifier]]
userInfo:nil] raise]; } return theValue; } ... @end ```

The only complicated method is the FunctionNode evaluator, which will need to evaluate
differently depending on both the class types of arguments and the function called. Ideally,
the evaluate method will also either raise an exception or return nil on error (depending on
your own view of exceptions).

This includes a "TestApplication" which is a half-baked cocoa-application calculator and
expression parser. Would be grateful if you let me know if there are errors, thanks.

- David Thorpe, January 2007
