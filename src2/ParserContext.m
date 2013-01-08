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

NSMutableDictionary* parsers = nil;

+(void)initialize {
	parsers = [NSMutableDictionary dictionary];
}

+(ParserContext* )_parserForContext:(ParserCtx* )context {
	return [parsers objectForKey:context];
}

-(id)init {
	self = [super init];
	if(self) {
		_scanner = (ParserCtx* )malloc(sizeof(ParserCtx));
		NSParameterAssert(_scanner);
		[self _initScanner];
		[parsers setObject:self forKey:_scanner];
	}
	return self;
}

-(void)dealloc {
	if(_scanner) {
		[parsers removeObjectForKey:_scanner];
		[self _deallocScanner];
		free(_scanner);
	}
}

-(void)parse:(NSString* )expression {
	int error = yyparse(_scanner);
	NSLog(@"Parse result = %d",error);
}

@end
