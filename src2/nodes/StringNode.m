//
//  StringNode.m
//  ExpressionEvaluator
//
//  Created by David Thorpe on 05/06/2006.
//  Copyright 2006 Somethin' Else Sound Directions Limited.
//  All rights reserved.
//
//  You may use and copy in accordance to the BSD License
//  included with this computer code.
//

#import "StringNode.h"

@implementation StringNode

-(id)initWithCString:(const char* )cString {
  self = [super init];
  if(self) {
    m_theString = [[NSString alloc] initWithCString:cString];
  }
  return self;
}

-(id)initWithQuotedCString:(const char* )cString {
  self = [super init];
  if(self) {
    m_theString = [[NSMutableString alloc] initWithCString:cString];
    [(NSMutableString* )m_theString deleteCharactersInRange:NSMakeRange(0,1)];
    [(NSMutableString* )m_theString deleteCharactersInRange:NSMakeRange([m_theString length]-1,1)];
  }
  return self;
}

+(StringNode* )stringWithCString:(const char* )cString {
  return [[StringNode alloc] initWithCString:cString];
}

+(StringNode* )stringWithQuotedCString:(const char* )cString {
  return [[StringNode alloc] initWithQuotedCString:cString];
}


-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
  return m_theString;
}

@end
