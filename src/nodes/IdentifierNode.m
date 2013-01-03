//
//  IdentifierNode.m
//  ExpressionEvaluator
//
//  Created by David Thorpe on 05/06/2006.
//  Copyright 2006 Somethin' Else Sound Directions Limited.
//  All rights reserved.
//
//  You may use and copy in accordance to the BSD License
//  included with this computer code.
//

#import "IdentifierNode.h"

@implementation IdentifierNode

-(id)initWithString:(NSString* )theString {
  self = [super init];
  if(self) {
    m_theValue = theString;
  }
  return self;  
}

+(IdentifierNode* )identifierWithCString:(const char* )cString {
  return [[IdentifierNode alloc] initWithString:[NSString stringWithCString:cString encoding:NSUTF8StringEncoding]];
}

+(IdentifierNode* )identifierWithString:(NSString* )theString {
  return [[IdentifierNode alloc] initWithString:theString];
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {
  NSObject* theValue = [theDictionary objectForKey:[self identifier]];
  if(theValue==nil) {
    [[NSException exceptionWithName:@"VariableNotFoundException" 
                             reason:[NSString stringWithFormat:@"Variable not found: %@",[self identifier]]
                           userInfo:nil] raise];
  }
  return theValue;
}

-(NSString* )description {
  return [NSString stringWithFormat:@"<IdenfifierNode:%@>",m_theValue];
}

-(NSString* )identifier {
  return m_theValue;
}

@end
