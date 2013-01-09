
#import <Foundation/Foundation.h>
#import "Node.h"

@interface StringNode : Node {
	NSString* _value;
}

// constructors
-(id)initWithValue:(NSString* )value;

// properties
@property (readonly) NSString* value;

@end
