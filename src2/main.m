
//  Created by David Thorpe on 05/06/2006.
//  Copyright 2006 Somethin' Else Sound Directions Limited.
//  All rights reserved.
//
//  You may use and copy in accordance to the BSD License
//  included with this computer code.
//

#import <Foundation/Foundation.h>

#import "ExpressionEvaluator.h"
#import "Node.h"

int main (int argc, const char * argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

  // create a dictionary of variables
  NSMutableDictionary* theDictionary = [NSMutableDictionary dictionary];  
  [theDictionary setObject:[NSNumber numberWithInt:42] forKey:@"fortytwo"];  
  [theDictionary setObject:[NSNumber numberWithDouble:3.141592654] forKey:@"pi"];  

  @try {
    // this is the expression to evaluate
    NSString* theString = @"2 + pi + fortytwo";
    // create a parse tree
    Node* theExpression = [[ExpressionEvaluator sharedEvaluator] parse:theString];  
    // evaluate the expression
    NSLog(@"evaluate %@ => %@",theString,[theExpression evaluateWithDictionary:theDictionary]);
  }
  @catch(NSException* theException) {
    NSLog(@"Error: %@",theException);    
  }

  [pool release];
  return 0;
}
