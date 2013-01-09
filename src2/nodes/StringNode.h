//
//  StringNode.h
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

@interface StringNode : Node {
  NSString* m_theString;
}

-(id)initWithCString:(const char* )cString;
-(id)initWithQuotedCString:(const char* )cString;
+(StringNode* )stringWithCString:(const char* )cString;
+(StringNode* )stringWithQuotedCString:(const char* )cString;

@end
