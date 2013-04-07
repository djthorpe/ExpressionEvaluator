
#import "PGLexer.h"

@interface PGLexerContext : NSObject {
	NSInputStream* _stream;
	PGLexer* _lexer;
	void* _scanner;
	NSError* _error;
	PGLexerToken* _token;
	NSMutableArray* _tokens;
}

// constructor
-(id)initWithLexer:(PGLexer* )lexer stream:(NSInputStream* )stream scanner:(void* )scanner;

// methods
-(void)errorCode:(NSInteger)code message:(NSString* )message;
-(void)append:(id)object;

// properties
@property (readonly) NSInputStream* stream;
@property (readonly) PGLexer* lexer;
@property (readonly) void* scanner;
@property (readonly) NSError* error;
@property (readonly) PGLexerToken* token;
@property (readonly) NSArray* tokens;

@end

// private C methods which interface with flex
PGLexerContext* _PGLexer_init(PGLexer* lexer,NSInputStream* stream);
void _PGLexer_destroy(PGLexerContext* context);
NSInteger _PGLexer_input(void* void_context,const char* buffer,NSUInteger max_bytes);
PGLexerToken* _PGLexer_token(PGLexerContext* context);
void _PGLexer_fatal_error(const char* message);

