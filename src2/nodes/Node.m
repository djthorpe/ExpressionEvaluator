
#import "Node.h"
#import "BooleanNode.h"
#import "NumberNode.h"
#import "StringNode.h"
#import "BooleanNode.h"
#import "VariableNode.h"
#import "FunctionNode.h"

@implementation Node

+(Node* )functionNode:(NSString* )operation,... {
	
}

+(Node* )numberNodeWithValue:(const char* )value {
	
}

+(Node* )stringNodeWithQuotedValue:(const char* )value {
	
}

+(Node* )booleanNodeWithValue:(BOOL)value {
	
}

+(Node* )variableNodeWithName:(const char* )name {
	
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
	return nil;
}

@end
