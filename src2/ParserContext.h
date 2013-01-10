
#import <Foundation/Foundation.h>
#import "Node.h"

@class ParserContext;

typedef struct {
	void* scanner;
	__unsafe_unretained Node* result;
	const char* error_text;
	int error_line;
} ParserCtx;

ParserContext* yy_get_parser(ParserCtx* context);

@interface ParserContext : NSObject {
	ParserCtx* _scanner; // pointer to scanner struct
	NSInputStream* _stream; // input stream
}

+(ParserContext* )parserForContext:(ParserCtx* )context;
-(Node* )parseString:(NSString* )expression error:(NSError** )error;
-(Node* )parseInputStream:(NSInputStream* )stream error:(NSError** )error;
-(NSObject* )evaluate:(Node* )parseTree error:(NSError** )error;

@end
