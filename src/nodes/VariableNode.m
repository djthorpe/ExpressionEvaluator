
#import "VariableNode.h"

@implementation VariableNode

@synthesize name = _name;

-(id)init {
	return nil;
}

-(id)initWithName:(NSString* )name {
	NSParameterAssert(name);
	self = [super init];
	if(self) {
		_name = name;
	}
	return self;
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
  NSObject* theValue = [theDictionary objectForKey:[self name]];
  if(theValue==nil) {
    [[NSException exceptionWithName:@"VariableNotFoundException" 
                             reason:[NSString stringWithFormat:@"Variable not found: %@",[self name]]
                           userInfo:nil] raise];
  }
  return theValue;
}

-(NSString* )description {
	return [NSString stringWithFormat:@"<VariableNode:%@>",[self name]];
}

@end
