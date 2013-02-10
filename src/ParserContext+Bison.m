
#import "ParserContext+Bison.h"

@implementation ParserContext (Bison)

-(void)_initScanner {
	yylex_init(&(_scanner->scanner));
	yyset_extra(_scanner,_scanner->scanner);
	_scanner->error_text = nil;
	_scanner->error_line = -1;
}

-(void)_deallocScanner {
	free((void* )_scanner->error_text);
	yylex_destroy(_scanner->scanner);
}

-(int)_inputToBuffer:(char* )buffer maxBytesToRead:(size_t)maxBytesToRead {
	NSParameterAssert(_stream);
	if([_stream streamStatus]==NSStreamStatusAtEnd) {
		return 0;
	}
	if([_stream streamStatus]==NSStreamStatusClosed) {
		[self _raiseError:"Unexpected state: NSStreamStatusAtEnd" line:-1];
		return 0;
	}
	if([_stream streamStatus]==NSStreamStatusError) {
		[self _raiseError:"Unexpected state: NSStreamStatusError" line:-1];
		return 0;
	}
	if([_stream streamStatus]==NSStreamStatusNotOpen) {
		[self _raiseError:"Unexpected state: NSStreamStatusNotOpen" line:-1];
		return 0;
	}
	NSInteger bytesRead = [_stream read:(uint8_t* )buffer maxLength:(NSUInteger)maxBytesToRead];
	if(bytesRead==0) {
		return 0;
	}
	if(bytesRead < 0) {
		[self _raiseError:"read operation failed" line:-1];
		return 0;
	}
	return (int)bytesRead;
}

-(void)_raiseError:(const char* )error line:(int)lineno {
	_scanner->error_text = strdup(error);
	_scanner->error_line = lineno;
}

@end
