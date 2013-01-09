
#import <Foundation/Foundation.h>
#import "Node.h"

@interface NumberNode : Node {
  double _value;
}

// constructor
-(id)initWithString:(NSString* )string;

// properties
@property (readonly) double value;

@end
