
#import <Foundation/Foundation.h>
#import "Node.h"

@interface FunctionNode : Node {
	NSString* _name;
	NSArray* _nodes;
}

@property (readonly,retain) NSString* name;
@property (readonly,retain) NSArray* nodes;

@end
