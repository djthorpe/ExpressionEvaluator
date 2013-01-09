
#import "StringNode.h"

@implementation StringNode

@synthesize value = _value;

-(id)init {
	self = [super init];
	if(self) {
		_value = @"";
	}
	return self;
}

-(id)initWithValue:(NSString* )value {
	self = [super init];
	if(self) {
		_value = value;
	}
	return self;
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
	return [self value];
}

-(NSString* )description {
	return [NSString stringWithFormat:@"<StringNode:'%@'>",[self value]];
}

@end
