//
//  PGStateMachine.m
//  ExpressionEvaluator
//
//  Created by David Thorpe on 08/04/2013.
//
//

#import "PGStateMachine.h"
#import "PGStateMachine+Tokens.h"
#import "PGLexer+Private.h"

enum {
	PGStateMachineStateINIT,
	PGStateMachineStateCOMMENT
};

@implementation PGStateMachine

// properties
@synthesize state = _state;

////////////////////////////////////////////////////////////////////////////////
// private methods

-(void)_stateInitConsumeToken:(PGLexerToken* )token context:(PGLexerContext* )context {
	switch(token->type) {
		case PGParserHash:
			[self setState:PGStateMachineStateCOMMENT];
			return;
		case PGParserWhitespace:
		case PGParserNewline:
			return;
		default:
			[context errorCode:PGLexerSyntaxError message:@"Unexpected text '%s' at line %d",token->text,token->lineno];
			return;
	}
}

-(void)_stateCommentConsumeToken:(PGLexerToken* )token context:(PGLexerContext* )context {
	switch(token->type) {
		case PGParserNewline:
			[self setState:PGStateMachineStateINIT];
			return;
		default:
			return;
	}
}

////////////////////////////////////////////////////////////////////////////////
// public methods

-(NSArray* )tokenizeInputStream:(NSInputStream* )stream error:(NSError** )error {
	// set initial state
	[self setState:PGStateMachineStateINIT];
	// tokenize input stream
	return [super tokenizeInputStream:stream error:error];
}

-(void)emitToken:(PGLexerToken* )token context:(PGLexerContext* )context {
	switch([self state]) {
		case PGStateMachineStateINIT:
			[self _stateInitConsumeToken:token context:context];
			break;
		case PGStateMachineStateCOMMENT:
			[self _stateCommentConsumeToken:token context:context];
			break;
		default:
			[context errorCode:PGLexerSyntaxError message:@"Unexpected state at line %d",token->lineno];
	}
}

@end
