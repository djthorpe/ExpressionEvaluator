
#import "NumberNode.h"

@implementation NumberNode

@synthesize value = _value;

-(id)init {
	self = [super init];
	if(self) {
		_value = 0.0;
	}
	return self;
}

-(id)initWithString:(NSString* )string {
  self = [super init];
  if(self) {
	  _value = [string doubleValue];
  }
  return self;
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
	return [NSNumber numberWithDouble:[self value]];
}

-(NSString* )description {
	return [NSString stringWithFormat:@"<NumberNode:%lf>",[self value]];
}

@end
