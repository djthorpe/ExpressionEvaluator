//
//  PGParser.h
//  ExpressionEvaluator
//
//  Created by David Thorpe on 07/04/2013.
//
//

#import "PGLexer.h"

@interface PGParser : PGLexer {
	NSMutableArray* _states;
}

+(PGParser* )parserWithStateMachine:(NSString* )path;

@end
