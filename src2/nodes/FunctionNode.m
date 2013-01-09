
#import "FunctionNode.h"

@implementation FunctionNode

@synthesize name = _name;
@synthesize nodes = _nodes;

-(id)init {
	return nil;
}

-(id)initWithName:(NSString* )name nodes:(NSArray* )nodes {
	self = [super init];
	if(self) {
		_name = name;
		_nodes = nodes;
	}
	return self;
}

-(NSString* )description {
	return [NSString stringWithFormat:@"<FunctionNode:'%@',%@>",[self name],[self nodes]];
}

@end
