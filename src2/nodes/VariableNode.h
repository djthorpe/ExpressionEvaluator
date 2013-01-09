
#import <Foundation/Foundation.h>
#import "Node.h"

@interface VariableNode : Node {
	NSString* _name;
}

// constructors
-(id)initWithName:(NSString* )name;

// properties
@property (readonly) NSString* name;

@end
