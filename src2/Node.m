
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
	return [[Node alloc] init];
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
	return nil;
}

@end
