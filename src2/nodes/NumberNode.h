//
//  NumberNode.h
//  ExpressionEvaluator
//
//  Created by David Thorpe on 05/06/2006.
//  Copyright 2006 Somethin' Else Sound Directions Limited.
//  All rights reserved.
//
//  You may use and copy in accordance to the BSD License
//  included with this computer code.
//


#import <Foundation/Foundation.h>
#import "Node.h"

@interface NumberNode : Node {
  double m_theValue;
}

-(id)initWithCString:(const char* )cString;
+(NumberNode* )numberWithCString:(const char* )cString;

@end
