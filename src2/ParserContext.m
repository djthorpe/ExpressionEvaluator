//
//  ParserContext.m
//  ExpressionEvaluator
//
//  Created by David Thorpe on 07/01/2013.
//
//

#import "ParserContext.h"

@interface ParserContext ()
-(void)_initScanner;
-(void)_deallocScanner;
@end

@implementation ParserContext

-(id)init {
	self = [super init];
	if(self) {
		_scanner = (ParserCtx* )malloc(sizeof(ParserCtx));
		NSParameterAssert(_scanner);
		[self _initScanner];
	}
	return self;
}

-(void)dealloc {
	if(_scanner) {
		[self _deallocScanner];
		free(_scanner);
	}
}

-(void)parse:(NSString* )expression {
	NSLog(@"TODO");
}

@end
