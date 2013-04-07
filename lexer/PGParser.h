//
//  PGParser.h
//  ExpressionEvaluator
//
//  Created by David Thorpe on 07/04/2013.
//
//

#import "PGLexer.h"

@interface PGParserState : NSObject {
	NSString* _name;
}

@end

@interface PGParser : PGLexer {
	NSMutableArray* _states;
}

@end
