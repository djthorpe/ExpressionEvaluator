
#import "PGLexer.h"
#import "PGLexer+Private.h"

// The domain for errors
NSString* PGLexerErrorDomain = @"PGLexerError";

////////////////////////////////////////////////////////////////////////////////
#pragma mark PGLexer implementation
////////////////////////////////////////////////////////////////////////////////

@implementation PGLexer

////////////////////////////////////////////////////////////////////////////////
// Private Methods

-(void)_raiseError:(NSError** )error code:(NSInteger)code message:(NSString* )format,... {
	NSDictionary* userInfo = nil;
	if(format && error) {
		va_list args;
		va_start(args,format);
		userInfo = [NSDictionary dictionaryWithObject:[[NSString alloc] initWithFormat:format arguments:args] forKey:NSLocalizedDescriptionKey];
		va_end(args);
	}
	if(error) {
		(*error) = [NSError errorWithDomain:PGLexerErrorDomain code:code userInfo:userInfo];
	}
}

-(void)emitToken:(PGLexerToken* )token context:(PGLexerContext* )context {
	// add token value to the array
	[context append:[NSNumber numberWithInteger:token->type]];
}

////////////////////////////////////////////////////////////////////////////////
// Public Methods

-(NSArray* )tokenizeFile:(NSString* )path error:(NSError** )error {
	NSParameterAssert(path);
	NSInputStream* stream = [[NSInputStream alloc] initWithFileAtPath:path];
	if(stream==nil) {
		[self _raiseError:error code:PGLexerFileReadError message:nil];
		return nil;
	}
	[stream open];
	NSArray* tokens = [self tokenizeInputStream:stream error:error];
	[stream close];
	return tokens;
}

-(NSArray* )tokenizeString:(NSString* )string error:(NSError** )error {
	NSParameterAssert(string);
	NSInputStream* stream = [[NSInputStream alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
	if(stream==nil) {
		[self _raiseError:error code:PGLexerFileReadError message:nil];
		return nil;
	}
	[stream open];
	NSArray* tokens = [self tokenizeInputStream:stream error:error];
	[stream close];
	return tokens;
}

-(NSArray* )tokenizeInputStream:(NSInputStream* )stream error:(NSError** )error {
	NSParameterAssert(stream);
	if([stream streamStatus] != NSStreamStatusOpen) {
		[self _raiseError:error code:PGLexerFileReadError message:nil];
		return nil;
	}
	PGLexerContext* context = _PGLexer_init(self,stream);
	PGLexerToken* token = nil;
	do {
		token = _PGLexer_token(context);
		if([context error]==nil && token) {
			[self emitToken:token context:context];
		}
	} while([context error]==nil && token);
	if(error) {
		(*error) = [context error];
	}
	_PGLexer_destroy(context);
	return (*error) ? nil : [context tokens];
}

@end

////////////////////////////////////////////////////////////////////////////////
#pragma mark PGLexerContext implementation
////////////////////////////////////////////////////////////////////////////////

@implementation PGLexerContext

////////////////////////////////////////////////////////////////////////////////
// Constructors

-(id)init {
	return nil;
}

-(id)initWithLexer:(PGLexer* )lexer stream:(NSInputStream* )stream scanner:(void* )scanner {
	self = [super init];
	if(self) {
		_scanner = scanner;
		_stream = stream;
		_lexer = lexer;
		_error = nil;
		_token = malloc(sizeof(PGLexerToken));
		if(_token==nil) {
			return nil;
		}
		_tokens = [[NSMutableArray alloc] init];
	}
	return self;
}

-(void)dealloc {
	[_tokens removeAllObjects];
	if(_token) {
		free(_token);
	}
}

-(void)append:(id)object {
	NSParameterAssert(object);
	[_tokens addObject:object];
}

-(void)errorCode:(NSInteger)code message:(NSString* )message {
	NSError* error = nil;
	[[self lexer] _raiseError:&error code:code message:message];
	_error = error;
}

////////////////////////////////////////////////////////////////////////////////
// Properties

@synthesize scanner = _scanner;
@synthesize stream = _stream;
@synthesize lexer = _lexer;
@synthesize tokens = _tokens;

@end

////////////////////////////////////////////////////////////////////////////////
#pragma mark yylex methods implementation
////////////////////////////////////////////////////////////////////////////////

typedef void* yyscan_t;
int yylex_init_extra(void* void_context,yyscan_t scanner);
void yylex_destroy(yyscan_t scanner);
int yylex(yyscan_t scanner);
const char* yyget_text(yyscan_t scanner);
int yyget_lineno(yyscan_t scanner);

void _PGLexer_fatal_error(const char* message) {
	fprintf(stderr,"FATAL: %s",message);
}

NSInteger _PGLexer_input(void* void_context,const char* buffer,NSUInteger max_bytes) {
	PGLexerContext* context = (__bridge PGLexerContext* )void_context;
	if([[context stream] streamStatus]==NSStreamStatusAtEnd) {
		return 0;
	}
	if([[context stream] streamStatus] != NSStreamStatusOpen) {
		[context errorCode:PGLexerFileReadError message:nil];
		return 0;
	}
	return [[context stream] read:(uint8_t* )buffer maxLength:max_bytes];
}

PGLexerContext* _PGLexer_init(PGLexer* lexer,NSInputStream* stream) {
	NSCParameterAssert(lexer && stream);
	// create a scanner and context
	yyscan_t* scanner = malloc(sizeof(yyscan_t));
	if(scanner==nil) {
		return nil;
	}
	PGLexerContext* context = [[PGLexerContext alloc] initWithLexer:lexer stream:stream scanner:scanner];
	// convert to bridged version
	void* _void_context = (__bridge void* )context;
	// init the scanner with the context
	int err = yylex_init_extra(_void_context,scanner);
	if(err) {
		free(scanner);
		return nil;
	}
	// return context
	return context;
}

void _PGLexer_destroy(PGLexerContext* context) {
	NSCParameterAssert(context);
	yyscan_t* scanner = [context scanner];
	yylex_destroy(*(scanner));
	free(scanner);
}

PGLexerToken* _PGLexer_token(PGLexerContext* context) {
	NSCParameterAssert(context && [context token]);
	yyscan_t* scanner = [context scanner];
	[context token]->type = yylex(*scanner);
	[context token]->text = yyget_text(*scanner);
	[context token]->lineno = yyget_lineno(*scanner);
	if([context token]->type==0) {
		return nil;
	}
	return [context token];
}


