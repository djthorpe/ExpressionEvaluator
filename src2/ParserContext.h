//
//  ParserContext.h
//  ExpressionEvaluator
//
//  Created by David Thorpe on 07/01/2013.
//
//

#import <Foundation/Foundation.h>

typedef struct {
	void* scanner;
} ParserCtx;

@interface ParserContext : NSObject {
	ParserCtx* _scanner; // pointer to scanner struct
}

-(void)parse:(NSString* )expression;

@end
