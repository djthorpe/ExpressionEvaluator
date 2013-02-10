
#import <Foundation/Foundation.h>
#import "PTNode.h"

@interface StringNode : PTNode {
	NSString* _value;
}

// constructors
-(id)initWithValue:(NSString* )value;

// properties
@property (readonly) NSString* value;

@end
