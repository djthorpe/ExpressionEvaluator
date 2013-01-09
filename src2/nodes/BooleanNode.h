
#import <Foundation/Foundation.h>
#import "Node.h"

@interface BooleanNode : Node {
  BOOL _value;
}

// constructors
-(id)initWithValue:(BOOL)value;
+(BooleanNode* )trueNode;
+(BooleanNode* )falseNode;

// properties
@property (readonly) BOOL value;

@end
