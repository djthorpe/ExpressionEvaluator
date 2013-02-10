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
which I won't cover here. But I will cover how it works with Objective-C.

I firstly define a "PTNode" class (see the ```src2/nodes`` folder)
which is the superclass of a number of node implementations. There are a number of
PTNode class methods to create instances of the node implementations:

```objc
+(PTNode* )numberNodeWithValue:(const char* )value;
+(PTNode* )booleanNodeWithValue:(BOOL)value;
+(PTNode* )variableNodeWithName:(const char* )name;
+(PTNode* )stringNodeWithQValue:(const char* )quoted;
+(PTNode* )functionNode:(NSString* )name,...;
```

The expression parser is very simple and will accept the following kinds of expressions. For example,

```objc
(a AND b) (a OR b) NOT(a) AND(a,b) 1 + 2 4 - 3 a := 100 a = 100 (a = 'foo') OR (b = TRUE)
```

To achieve this, create your two "rules" files, the tokenizer ```lexer.lm``` and the parser ```parser.lm```.
The file extensions contain "m" to indicate they are Objective-C files rather than plain old C.

An Objective-C class called ```ParserContext``` contains two methods which return the parse tree:

```objc
@interface ParserContext
-(PTNode* )parseString:(NSString* )expression error:(NSError** )error;
-(PTNode* )parseInputStream:(NSInputStream* )stream error:(NSError** )error;
@end
```

These return a ```PTNode``` parse tree from a string and file stream respectively,
and will return ```nil``` when there is either a lexical or parse error. You can optionally
provide an NSError pointer which can return an NSError object giving further information
on the error condition.

Finally, to actually execute the expression, use the following ```ParserContext``` method:

```objc
@interface ParserContext
-(NSObject* )evaluate:(PTNode* )parseTree error:(NSError** )error;
@end
```

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
