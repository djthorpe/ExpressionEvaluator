
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
	NSMutableDictionary* _variables; // variables
}

// properties
@property NSInputStream* stream;
@property NSDictionary* variables;

// constructor
+(ParserContext* )parserForContext:(ParserCtx* )context;

// get and set variables
-(void)setValue:(id)value forKey:(NSString *)key;
-(id)valueForKey:(NSString *)key;

// parse and evaluate
-(PTNode* )parseString:(NSString* )expression error:(NSError** )error;
-(PTNode* )parseInputStream:(NSInputStream* )stream error:(NSError** )error;
-(NSObject* )evaluate:(PTNode* )parseTree error:(NSError** )error;

@end
