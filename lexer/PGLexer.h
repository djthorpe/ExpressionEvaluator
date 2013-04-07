
#import <Foundation/Foundation.h>

typedef struct {
	NSInteger type;
	const char* text;
	NSInteger lineno;
} PGLexerToken;

extern NSString* PGLexerErrorDomain;
typedef enum {
	PGLexerFileReadError = 100,
	PGLexerFatalError = 101
} PGLexerErrorCode;

@interface PGLexer : NSObject
-(NSArray* )tokenizeInputStream:(NSInputStream* )stream error:(NSError** )error;
-(NSArray* )tokenizeFile:(NSString* )path error:(NSError** )error;
-(NSArray* )tokenizeString:(NSString* )string error:(NSError** )error;
@end
