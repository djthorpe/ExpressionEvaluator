//
//  NumberNode.m
//  ExpressionEvaluator
//
//  Created by David Thorpe on 05/06/2006.
//  Copyright 2006 Somethin' Else Sound Directions Limited.
//  All rights reserved.
//
//  You may use and copy in accordance to the BSD License
//  included with this computer code.
//

#import "NumberNode.h"

@implementation NumberNode

-(id)initWithCString:(const char* )cString {
  self = [super init];
  if(self) {
    m_theValue = [[NSString stringWithUTF8String:cString] doubleValue];
  }
  return self;
}

+(NumberNode* )numberWithCString:(const char* )cString {
  return [[NumberNode alloc] initWithCString:cString];
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
  return [NSNumber numberWithDouble:m_theValue];
}

@end
