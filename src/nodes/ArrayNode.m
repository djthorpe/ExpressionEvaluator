//
//  ArrayNode.m
//  ExpressionEvaluator
//
//  Created by David Thorpe on 05/06/2006.
//  Copyright 2006 Somethin' Else Sound Directions Limited.
//  All rights reserved.
//
//  You may use and copy in accordance to the BSD License
//  included with this computer code.
//

#import "ArrayNode.h"

@implementation ArrayNode

-(id)initWithNodes:(NSArray* )theNodes {
  self = [super init];
  if(self) {
    m_theNodes = theNodes;
  }
  return self;
}

-(NSArray* )array {
  return m_theNodes;
}

+(ArrayNode* )arrayWithNode:(Node* )theArrayOrNode withNode:(Node* )theNode {
  if([theArrayOrNode isKindOfClass:[ArrayNode class]]) {
    NSMutableArray* theNewArray = [NSMutableArray arrayWithArray:[(ArrayNode* )theArrayOrNode array]];
    [theNewArray addObject:theNode];
    return [[ArrayNode alloc] initWithNodes:theNewArray];
  } else {
    NSArray* theNewArray = [NSArray arrayWithObjects:theArrayOrNode,theNode,nil];
    return [[ArrayNode alloc] initWithNodes:theNewArray];
  }
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
  NSMutableArray* theEvaluatedArray = [NSMutableArray arrayWithCapacity:[m_theNodes count]];
  for(unsigned i = 0; i < [m_theNodes count]; i++) {
    Node* theNode = [m_theNodes objectAtIndex:i];
    [theEvaluatedArray addObject:[theNode evaluateWithDictionary:theDictionary]];
  }
  return theEvaluatedArray;
}

@end
