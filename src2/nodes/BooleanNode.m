
#import "BooleanNode.h"

@implementation BooleanNode

@synthesize value = _value;

-(id)init {
	self = [super init];
	if(self) {
		_value = NO;
	}
	return self;
}

-(id)initWithValue:(BOOL)value {
  self = [super init];
  if(self) {
    _value = value;
  }
  return self;
}

+(BooleanNode* )trueNode {
  return [[BooleanNode alloc] initWithValue:YES];
}

+(BooleanNode* )falseNode {
  return [[BooleanNode alloc] initWithValue:NO];
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
	return [NSNumber numberWithBool:[self value]];
}

-(NSString* )description {
	return [NSString stringWithFormat:@"<BooleanNode:%@>",[self value] ? @"TRUE" : @"FALSE"];
}

@end
