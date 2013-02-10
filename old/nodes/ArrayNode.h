//
//  ArrayNode.h
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

@interface ArrayNode : Node {
  NSArray* m_theNodes;
}

+(ArrayNode* )arrayWithNode:(Node* )theArrayOrNode withNode:(Node* )theNode;
-(NSArray* )array;


@end
