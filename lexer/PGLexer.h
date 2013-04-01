
#import <Foundation/Foundation.h>

void PGLexerInput(const char* buffer,unsigned long numBytesRead,unsigned long maxBytesToRead);

typedef enum {
	PGLexerSQString,PGLexerDQString,
	PGLexerFloat,PGLexerOctal,
	PGLexerDecimal,PGLexerHash,
	PGLexerEquals,PGLexerComma,
	PGLexerKeyword,
	PGLexerIP4Addr,PGLexerIP6Addr,PGLexerIPMask,
	PGLexerHostname,PGLexerGroupMap,
	PGLexerWhitespace,PGLexerNewline,
	PGLexerOther
} PGLexerType;


@interface PGLexer : NSObject

@end
