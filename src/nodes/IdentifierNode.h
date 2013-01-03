//
//  IdentifierNode.h
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

@interface IdentifierNode : Node {
  NSString* m_theValue;
}

-(id)initWithString:(NSString* )theString;
+(IdentifierNode* )identifierWithCString:(const char* )cString;
+(IdentifierNode* )identifierWithString:(NSString* )theString;
-(NSString* )identifier;

@end
