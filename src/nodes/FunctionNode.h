//
//  FunctionNode.h
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
#import "IdentifierNode.h"

@interface FunctionNode : Node {
  NSArray* m_theNodes;  
  IdentifierNode* m_theFunction;
}

-(id)initWithFunction:(Node* )theFunction withNodes:(NSArray* )theNodes;
+(FunctionNode* )function:(NSString* )theFunction withNodes:(Node* )theNode,...;
+(FunctionNode* )function:(Node* )theFunction withArray:(Node* )theNode;

// properties
-(SEL)selector;

@end
