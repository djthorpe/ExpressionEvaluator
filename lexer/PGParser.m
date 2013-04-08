
#import "PGParser.h"
#import "PGLexer+Tokens.h"
#import "PGLexer+Private.h"

@implementation PGParser

-(id)init {
	self = [super init];
	if(self) {
		_statemachine = [[PGStateMachine alloc] init];
	}
	return self;
}

-(void)_loadStateMachine:(NSString* )path error:(NSError** )error {
	[_statemachine tokenizeFile:path error:error];
}

+(PGParser* )parserWithStateMachine:(NSString* )path  error:(NSError** )error {
	PGParser* parser = [[PGParser alloc] init];
	[parser _loadStateMachine:path error:error];
	if(error) {
		return nil;
	}
	return parser;
}

@end
