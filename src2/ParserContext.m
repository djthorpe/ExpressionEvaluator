
#import "ParserContext.h"
#import "ParserContext+Bison.h"
#import "PTNode.h"

@implementation ParserContext

NSMutableDictionary* _parsers = nil;

////////////////////////////////////////////////////////////////////////////////

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
		_variables = [NSMutableDictionary dictionary];
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
	_variables = nil;
}

////////////////////////////////////////////////////////////////////////////////

@synthesize stream = _stream;
@synthesize variables = _variables;

////////////////////////////////////////////////////////////////////////////////
// get and set variables

-(void)setValue:(id)value forKey:(NSString *)key {
	NSParameterAssert(key && [key length]);
	// value can be NSNumber, NSString or nil 
	NSParameterAssert(value==nil || [value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]);

	// add or remove value
	if(value==nil) {
		// remove value from the dictionary
		[_variables removeObjectForKey:key];
	} else {
		[_variables setObject:value forKey:key];
	}
}

-(id)valueForKey:(NSString *)key {
	NSParameterAssert(key && [key length]);
	return [_variables objectForKey:key];
}

////////////////////////////////////////////////////////////////////////////////

-(PTNode* )parseInputStream:(NSInputStream* )stream error:(NSError** )error {
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

-(PTNode* )parseString:(NSString* )expression error:(NSError** )error {
	NSParameterAssert(expression);
	NSParameterAssert(_stream==nil);
	NSData* data = [expression dataUsingEncoding:NSUTF8StringEncoding];
	NSInputStream* stream = [NSInputStream inputStreamWithData:data];
	[stream open];
	PTNode* parseTree = [self parseInputStream:stream error:error];
	[stream close];
	_stream=nil;
	return parseTree;
}

-(NSObject* )evaluate:(PTNode* )parseTree error:(NSError** )error {
	NSObject* obj = nil;
	@try {
		obj = [parseTree evaluateWithDictionary:[self variables]];
	} @catch(NSException* e) {
		if(error) {
			// set error message
			(*error) = [NSError errorWithDomain:@"ParseError" code:-1 userInfo:[NSDictionary dictionaryWithObject:[e description] forKey:NSLocalizedDescriptionKey]];
		}
	}	
	return obj;
}

@end
