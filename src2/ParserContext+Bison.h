
#import "ParserContext.h"

int yyparse(ParserCtx* context);

@interface ParserContext (Bison)
+(ParserContext* )_parserForContext:(ParserCtx* )context;
-(void)_initScanner;
-(void)_deallocScanner;
-(int)_inputToBuffer:(char* )buffer maxBytesToRead:(size_t)maxBytesToRead;
-(void)_raiseError:(const char* )error line:(int)lineno;
@end
