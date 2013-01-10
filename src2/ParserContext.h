
#import <Foundation/Foundation.h>
#import "PTNode.h"

@class ParserContext;

typedef struct {
	void* scanner;
	__unsafe_unretained PTNode* result;
	const char* error_text;
	int error_line;
} ParserCtx;

ParserContext* yy_get_parser(ParserCtx* context);

@interface ParserContext : NSObject {
	ParserCtx* _scanner; // pointer to scanner struct
	NSInputStream* _stream; // input stream
}

+(ParserContext* )parserForContext:(ParserCtx* )context;
-(PTNode* )parseString:(NSString* )expression error:(NSError** )error;
-(PTNode* )parseInputStream:(NSInputStream* )stream error:(NSError** )error;
-(NSObject* )evaluate:(PTNode* )parseTree error:(NSError** )error;

@end
