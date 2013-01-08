
#import <Foundation/Foundation.h>
#import "Node.h"

@class ParserContext;

typedef struct {
	void* scanner;
	__unsafe_unretained Node* result;
} ParserCtx;

ParserContext* yy_get_parser(ParserCtx* context);

@interface ParserContext : NSObject {
	ParserCtx* _scanner; // pointer to scanner struct
	NSInputStream* _stream; // input stream
}

+(ParserContext* )parserForContext:(ParserCtx* )context;
-(void)parseString:(NSString* )expression;
-(void)parseInputStream:(NSInputStream* )stream;
@end
