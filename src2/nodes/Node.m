
#import "Node.h"

@implementation Node

-(id)init {
	self = [super init];
	if(self) {
		// do stuff
	}
	return self;
}

+(Node* )node {
	NSLog(@"return node");
	return [[Node alloc] init];
}

+(Node* )functionNode {
	NSLog(@"return function");
	return [[Node alloc] init];
}

+(Node* )numberNode {
	NSLog(@"return number");
	return [[Node alloc] init];
}

+(Node* )stringNode {
	NSLog(@"return string");
	return [[Node alloc] init];
}

+(Node* )booleanNode {
	NSLog(@"return boolean");
	return [[Node alloc] init];
}

+(Node* )identifierNode {
	NSLog(@"return identifier");
	return [[Node alloc] init];
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
	return nil;
}

@end
