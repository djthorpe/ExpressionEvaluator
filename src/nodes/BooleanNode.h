//
//  BooleanNode.h
//  ExpressionEvaluator
//
//  Created by David Thorpe on 05/06/2006.
//  Copyright 2006 Somethin' Else Sound Directions Limited.
//  All rights reserved.
//
//  You may use and copy in accordance to the BSD License
//  included with this computer code.
//

#import "Node.h"

@interface BooleanNode : Node {
  BOOL m_theValue;
}

-(id)initWithBoolean:(BOOL)theValue;
+(BooleanNode* )trueNode;
+(BooleanNode* )falseNode;

@end
