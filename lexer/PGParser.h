//
//  PGParser.h
//  ExpressionEvaluator
//
//  Created by David Thorpe on 07/04/2013.
//
//

#import "PGLexer.h"
#import "PGStateMachine.h"

@interface PGParser : PGLexer {
	PGStateMachine* _statemachine;
}

+(PGParser* )parserWithStateMachine:(NSString* )path error:(NSError** )error;

@end
