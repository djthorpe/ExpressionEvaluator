
#import <Foundation/Foundation.h>
#import "PTNode.h"

@interface NumberNode : PTNode {
  double _value;
}

// constructor
-(id)initWithString:(NSString* )string;

// properties
@property (readonly) double value;

@end
