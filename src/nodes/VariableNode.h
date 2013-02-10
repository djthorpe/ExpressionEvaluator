
#import <Foundation/Foundation.h>
#import "PTNode.h"

@interface VariableNode : PTNode {
	NSString* _name;
}

// constructors
-(id)initWithName:(NSString* )name;

// properties
@property (readonly) NSString* name;

@end
