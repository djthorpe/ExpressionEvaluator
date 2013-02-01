
#import "PTNode.h"
#import "VariableNode.h"
#import "BooleanNode.h"
#import "NumberNode.h"
#import "StringNode.h"
#import "FunctionNode.h"

@implementation PTNode

+(PTNode* )numberNodeWithValue:(const char* )value {
	NSParameterAssert(value);
	return [[NumberNode alloc] initWithString:[NSString stringWithUTF8String:value]];
}

+(PTNode* )booleanNodeWithValue:(BOOL)value {
	return [[BooleanNode alloc] initWithValue:value];
}

+(PTNode* )variableNodeWithName:(const char* )name {
	NSParameterAssert(name);
	return [[VariableNode alloc] initWithName:[NSString stringWithUTF8String:name]];
}

+(PTNode* )stringNodeWithQValue:(const char* )quoted {
	NSMutableString* string = [[NSMutableString alloc] initWithUTF8String:quoted];
	[string deleteCharactersInRange:NSMakeRange(0,1)];
	[string deleteCharactersInRange:NSMakeRange([string length]-1,1)];
	return [[StringNode alloc] initWithValue:string];
}

+(PTNode* )functionNode:(NSString* )name,... {
	NSParameterAssert(name);
	NSMutableArray* nodes = [NSMutableArray arrayWithCapacity:2];
	va_list ap;
	va_start(ap,name);
	PTNode* node = nil;
	while((node = va_arg(ap,PTNode* ))) {
		[nodes addObject:node];
	}
	va_end(ap);
	return [[FunctionNode alloc] initWithName:name nodes:nodes];
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
	return nil;
}

@end
