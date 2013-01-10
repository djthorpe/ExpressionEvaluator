
#import "ParserContext.h"
#import "ParserContext+Bison.h"

@implementation ParserContext

NSMutableDictionary* _parsers = nil;

+(void)initialize {
	_parsers = [NSMutableDictionary dictionary];
}

+(ParserContext* )parserForContext:(ParserCtx* )context {
	return [_parsers objectForKey:[NSValue valueWithPointer:context]];
}

-(id)init {
	self = [super init];
	if(self) {
		_scanner = (ParserCtx* )malloc(sizeof(ParserCtx));
		NSParameterAssert(_scanner);
		_stream = nil;
		[self _initScanner];
		[_parsers setObject:self forKey:[NSValue valueWithPointer:_scanner]];
	}
	return self;
}

-(void)dealloc {
	if(_scanner) {
		[_parsers removeObjectForKey:[NSValue valueWithPointer:_scanner]];
		[self _deallocScanner];
		free(_scanner);
		_scanner = nil;
	}
}

-(Node* )parseInputStream:(NSInputStream* )stream error:(NSError** )error {
	NSParameterAssert(stream);
	NSParameterAssert(_scanner);
	NSParameterAssert(_stream==nil);
	_stream = stream;
	_scanner->result = nil;
	if(error) (*error) = nil;
	if(yyparse(_scanner)) {
		// error
		if(error) {
			// set error message
			NSString* description = [NSString stringWithFormat:@"Error at line %d: %s",(_scanner->error_line),(_scanner->error_text)];
			(*error) = [NSError errorWithDomain:@"ParseError" code:-1 userInfo:[NSDictionary dictionaryWithObject:description forKey:NSLocalizedDescriptionKey]];
		}
		return nil;
	} else {
		return _scanner->result;
	}
}

-(Node* )parseString:(NSString* )expression error:(NSError** )error {
	NSParameterAssert(expression);
	NSParameterAssert(_stream==nil);
	NSData* data = [expression dataUsingEncoding:NSUTF8StringEncoding];
	NSInputStream* stream = [NSInputStream inputStreamWithData:data];
	[stream open];
	Node* parseTree = [self parseInputStream:stream error:error];
	[stream close];
	return parseTree;
}

-(NSObject* )evaluate:(Node* )parseTree error:(NSError** )error {
	NSMutableDictionary* variables = [NSMutableDictionary dictionary];
	return [parseTree evaluateWithDictionary:variables];
}

@end
