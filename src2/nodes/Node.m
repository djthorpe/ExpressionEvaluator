
#import "Node.h"
#import "VariableNode.h"
#import "BooleanNode.h"
#import "NumberNode.h"
#import "StringNode.h"
#import "FunctionNode.h"

@implementation Node

+(Node* )numberNodeWithValue:(const char* )value {
	NSParameterAssert(value);
	return [[NumberNode alloc] initWithString:[NSString stringWithUTF8String:value]];
}

+(Node* )booleanNodeWithValue:(BOOL)value {
	return [[BooleanNode alloc] initWithValue:value];
}

+(Node* )variableNodeWithName:(const char* )name {
	NSParameterAssert(name);
	return [[VariableNode alloc] initWithName:[NSString stringWithUTF8String:name]];
}

+(Node* )stringNodeWithQValue:(const char* )quoted {
	NSMutableString* string = [[NSMutableString alloc] initWithUTF8String:quoted];
	[string deleteCharactersInRange:NSMakeRange(0,1)];
	[string deleteCharactersInRange:NSMakeRange([string length]-1,1)];
	return [[StringNode alloc] initWithValue:string];
}

+(Node* )functionNode:(NSString* )name,... {
	return nil;	
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
	return nil;
}

@end
