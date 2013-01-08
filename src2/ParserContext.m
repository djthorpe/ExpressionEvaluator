
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

-(void)parseInputStream:(NSInputStream* )stream {
	NSParameterAssert(stream);
	NSParameterAssert(_scanner);
	NSParameterAssert(_stream==nil);
	_stream = stream;
	_scanner->result = nil;
	int error = yyparse(_scanner);
	if(error) {
		NSLog(@"Parse result=%@, err=%d",_scanner->result,error);
	} else {
		NSLog(@"Parse result=%@",_scanner->result);		
	}
}

-(void)parseString:(NSString* )expression {
	NSParameterAssert(expression);
	NSParameterAssert(_stream==nil);
	NSData* data = [expression dataUsingEncoding:NSUTF8StringEncoding];
	NSInputStream* stream = [NSInputStream inputStreamWithData:data];
	[stream open];
	[self parseInputStream:stream];
	[stream close];
}

@end
