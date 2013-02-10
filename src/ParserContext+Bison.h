
#import "ParserContext.h"

int yyparse(ParserCtx* context);
int yylex_init(void** scanner);
void yyset_extra(ParserCtx* context,void* scanner);
int yylex_destroy(void* scanner);

@interface ParserContext (Bison)
-(void)_initScanner;
-(void)_deallocScanner;
-(int)_inputToBuffer:(char* )buffer maxBytesToRead:(size_t)maxBytesToRead;
-(void)_raiseError:(const char* )error line:(int)lineno;
@end
