//
//  ParserContext.h
//  ExpressionEvaluator
//
//  Created by David Thorpe on 07/01/2013.
//
//

#import <Foundation/Foundation.h>

@class ParserContext;

typedef struct {
	void* scanner;
} ParserCtx;

ParserContext* yy_get_parser(ParserCtx* context);

@interface ParserContext : NSObject {
	ParserCtx* _scanner; // pointer to scanner struct
}

-(void)parse:(NSString* )expression;

@end
