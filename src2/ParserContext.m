//
//  ParserContext.m
//  ExpressionEvaluator
//
//  Created by David Thorpe on 07/01/2013.
//
//

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
	}
}

-(void)parse:(NSString* )expression {
	int error = yyparse(_scanner);
	NSLog(@"Parse result = %d",error);
}

@end
