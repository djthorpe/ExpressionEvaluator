//
//  BooleanNode.m
//  ExpressionEvaluator
//
//  Created by David Thorpe on 05/06/2006.
//  Copyright 2006 Somethin' Else Sound Directions Limited.
//  All rights reserved.
//
//  You may use and copy in accordance to the BSD License
//  included with this computer code.
//

#import "BooleanNode.h"


@implementation BooleanNode

-(id)initWithBoolean:(BOOL)theValue {
  self = [super init];
  if(self) {
    m_theValue = theValue;
  }
  return self;
}

+(BooleanNode* )trueNode {
  return [[BooleanNode alloc] initWithBoolean:YES];
}

+(BooleanNode* )falseNode {
  return [[BooleanNode alloc] initWithBoolean:NO];
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
  return [NSNumber numberWithBool:m_theValue];
}

@end
