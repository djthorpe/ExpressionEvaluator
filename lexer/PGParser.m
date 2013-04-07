
#import "PGParser.h"
#import "PGLexer+Tokens.h"
#import "PGLexer+Private.h"

@implementation PGParser

-(void)_loadStateMachine:(NSString* )path error:(NSError** )error {
	[super tokenizeFile:path error:error];
}

+(PGParser* )parserWithStateMachine:(NSString* )path {
	PGParser* parser = [[PGParser alloc] init];
	NSError* error = nil;
	[parser _loadStateMachine:path error:&error];
	if(error) {
		return nil;
	}
	return parser;
}

@end
