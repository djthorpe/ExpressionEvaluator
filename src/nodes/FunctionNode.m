//
//  FunctionNode.m
//  ExpressionEvaluator
//
//  Created by David Thorpe on 05/06/2006.
//  Copyright 2006 Somethin' Else Sound Directions Limited.
//  All rights reserved.
//
//  You may use and copy in accordance to the BSD License
//  included with this computer code.
//


#import "FunctionNode.h"
#import "IdentifierNode.h"
#import "ArrayNode.h"

@implementation FunctionNode

-(id)initWithFunction:(Node* )theFunction withNodes:(NSArray* )theNodes {
  self = [super init];
  if(self) {
    m_theFunction = theFunction;
    m_theNodes = theNodes;
  }
  return self;
}

+(FunctionNode* )function:(NSString* )theFunction withNodes:(Node* )theNode,... {
  NSMutableArray* theNodes = [NSMutableArray arrayWithCapacity:2];
  if(theNode) {
    va_list ap;  
    va_start(ap,theNode);
    Node* theArg = nil;
    [theNodes addObject:theNode];      
    while(theArg = va_arg(ap,Node* )) {
      [theNodes addObject:theArg];
    }  
    va_end(ap);  
  }
  return [[FunctionNode alloc] initWithFunction:[IdentifierNode identifierWithString:theFunction] withNodes:theNodes];
}

+(FunctionNode* )function:(Node* )theFunction withArray:(Node* )theNode {
  ArrayNode* theArray = (ArrayNode* )theNode;
  return [[FunctionNode alloc] initWithFunction:theFunction withNodes:[theArray array]];  
}

-(SEL)selector {
  if([m_theFunction isKindOfClass:[IdentifierNode class]]==NO) return nil;
  SEL theSelector = NSSelectorFromString([NSString stringWithFormat:@"function_%@:",[m_theFunction identifier]]);  
  if([self respondsToSelector:theSelector]==NO) return nil;
  return theSelector;
}

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary {  
  SEL theSelector = [self selector];
  if(theSelector==nil) {
    [[NSException exceptionWithName:@"InvalidFunctionCall" 
                             reason:[NSString stringWithFormat:@"Function not found: %@",[m_theFunction identifier]]
                           userInfo:nil] raise];  
  }
  return [self performSelector:theSelector withObject:theDictionary];
}

-(NSArray* )evaluateAllNodesWithDictionary:(NSDictionary* )theDictionary {  
  NSMutableArray* theArguments = [NSMutableArray arrayWithCapacity:[m_theNodes count]];  
  for(unsigned i = 0; i < [m_theNodes count]; i++) {
    Node* theNode = [m_theNodes objectAtIndex:i];
    NSObject* theObject = [theNode evaluateWithDictionary:theDictionary];
    [theArguments addObject:theObject];
  }
  return theArguments;
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark -- Type Conversions --
///////////////////////////////////////////////////////////////////////////////

-(BOOL)type_BOOL:(NSObject* )theObject {
  if([theObject isKindOfClass:[NSString class]]) {
    return [(NSString* )theObject length] ? YES : NO;
  }
  if([theObject isKindOfClass:[NSNumber class]]) {
    return [(NSNumber* )theObject boolValue];
  }
  [[NSException exceptionWithName:@"InvalidTypeConversion" 
                           reason:[NSString stringWithFormat:@"Cannot convert %@ to BOOL",[theObject class]]
                         userInfo:nil] raise];    
  return NO;
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark -- Boolean Functions --
///////////////////////////////////////////////////////////////////////////////

-(NSObject* )function_AND:(NSDictionary* )theDictionary {
  NSArray* theArguments = [self evaluateAllNodesWithDictionary:theDictionary];
  for(unsigned i = 0; i < [theArguments count]; i++) {
    BOOL theBoolValue = [self type_BOOL:[theArguments objectAtIndex:i]];
    if(theBoolValue==NO) return [NSNumber numberWithBool:NO];
  }
  return [NSNumber numberWithBool:YES];
}

-(NSObject* )function_OR:(NSDictionary* )theDictionary {
  NSArray* theArguments = [self evaluateAllNodesWithDictionary:theDictionary];
  for(unsigned i = 0; i < [theArguments count]; i++) {
    BOOL theBoolValue = [self type_BOOL:[theArguments objectAtIndex:i]];
    if(theBoolValue==YES) return [NSNumber numberWithBool:YES];
  }
  return [NSNumber numberWithBool:NO];
}

-(NSObject* )function_NOT:(NSDictionary* )theDictionary {
  NSArray* theArguments = [self evaluateAllNodesWithDictionary:theDictionary];
  if([theArguments count] != 1) {
    [[NSException exceptionWithName:@"InvalidArguments" 
                             reason:[NSString stringWithFormat:@"NOT cannot have more than one argument"]
                           userInfo:nil] raise];        
  }
  BOOL theBoolValue = [self type_BOOL:[theArguments objectAtIndex:0]];
  return [NSNumber numberWithBool:(theBoolValue ? NO : YES)];
}

-(NSObject* )function_EQUALS:(NSDictionary* )theDictionary {
  NSArray* theArguments = [self evaluateAllNodesWithDictionary:theDictionary];
  if([theArguments count] < 2) {
    [[NSException exceptionWithName:@"InvalidArguments" 
                             reason:@"EQUALS needs at least two arguments"
                           userInfo:nil] raise];        
  }
  NSObject* theFirstObject = [theArguments objectAtIndex:0];
  for(unsigned i = 1; i < [theArguments count]; i++) {
    NSObject* theNextObject = [theArguments objectAtIndex:i];
    if([theNextObject isKindOfClass:[theFirstObject class]]==NO) {
      return [NSNumber numberWithBool:NO];
    }
    if([theFirstObject isNotEqualTo:theNextObject]) {
      return [NSNumber numberWithBool:NO];
    }
  }
  return [NSNumber numberWithBool:YES];
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark -- Arithmetic Functions --
///////////////////////////////////////////////////////////////////////////////

-(NSObject* )function_PLUS:(NSDictionary* )theDictionary {
  NSArray* theArguments = [self evaluateAllNodesWithDictionary:theDictionary];
  if([theArguments count] < 2) {
    [[NSException exceptionWithName:@"InvalidArguments" 
                             reason:@"PLUS needs at least two arguments"
                           userInfo:nil] raise];        
  }
  double theSum = 0.0;
  for(unsigned i = 0; i < [theArguments count]; i++) {
    NSNumber* theNumber = [theArguments objectAtIndex:i];
    if([theNumber isKindOfClass:[NSNumber class]]==NO) {
      [[NSException exceptionWithName:@"InvalidArguments" 
                               reason:@"PLUS needs number arguments"
                             userInfo:nil] raise];        
    }
    theSum += [theNumber doubleValue];
  }
  return [NSNumber numberWithDouble:theSum];
}

-(NSObject* )function_MINUS:(NSDictionary* )theDictionary {
  NSArray* theArguments = [self evaluateAllNodesWithDictionary:theDictionary];
  if([theArguments count] < 2) {
    [[NSException exceptionWithName:@"InvalidArguments" 
                             reason:@"MINUS needs at least two arguments"
                           userInfo:nil] raise];        
  }
  double theSum;
  for(unsigned i = 0; i < [theArguments count]; i++) {
    NSNumber* theNumber = [theArguments objectAtIndex:i];
    if([theNumber isKindOfClass:[NSNumber class]]==NO) {
      [[NSException exceptionWithName:@"InvalidArguments" 
                               reason:@"MINUS needs number arguments"
                             userInfo:nil] raise];        
    }
    if(i==0) {
      theSum = [theNumber doubleValue];
    } else {
      theSum -= [theNumber doubleValue];
    }
  }
  return [NSNumber numberWithDouble:theSum];
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark -- Assignment Functions --
///////////////////////////////////////////////////////////////////////////////

-(NSObject* )function_ASSIGN:(NSDictionary* )theDictionary {
  NSArray* theArguments = m_theNodes;
  if([theArguments count] != 2) {
    [[NSException exceptionWithName:@"InvalidArguments" 
                             reason:@"ASSIGN needs two arguments"
                           userInfo:nil] raise];        
  }
  if([[theArguments objectAtIndex:0] isKindOfClass:[IdentifierNode class]]==NO) {
    [[NSException exceptionWithName:@"InvalidArguments" 
                             reason:@"ASSIGN invalid l-value"
                           userInfo:nil] raise];            
  }
  IdentifierNode* theLeftNode = (IdentifierNode* )[theArguments objectAtIndex:0];
  Node* theRightNode = (Node* )[theArguments objectAtIndex:1];
  NSObject* theRightValue = [theRightNode evaluateWithDictionary:theDictionary];
  if([theDictionary isKindOfClass:[NSMutableDictionary class]]) {
    [(NSMutableDictionary* )theDictionary setObject:theRightValue forKey:[theLeftNode identifier]];
  } else {
    [[NSException exceptionWithName:@"InvalidArguments" 
                             reason:@"ASSIGN needs mutable dictionary as argument"
                           userInfo:nil] raise];            
  }
  return theRightValue;
}

@end
