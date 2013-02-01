
#import <Foundation/Foundation.h>
#import "PTNode.h"

@interface BooleanNode : PTNode {
  BOOL _value;
}

// constructors
-(id)initWithValue:(BOOL)value;
+(BooleanNode* )trueNode;
+(BooleanNode* )falseNode;

// properties
@property (readonly) BOOL value;

@end
