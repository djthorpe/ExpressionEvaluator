//
//  ExpressionEvaluator.m
//  ExpressionEvaluator
//
//  Created by David Thorpe on 05/06/2006.
//  Copyright 2006 Somethin' Else Sound Directions Limited.
//  All rights reserved.
//
//  You may use and copy in accordance to the BSD License
//  included with this computer code.
//

#import "ExpressionEvaluator.h"

// external global variable
extern Node* yylastParsedNode;

// forward declarations
void yyparse();
void yyrestart();
void yyreset_state();

// returns more input
int yyYYINPUT(char* theBuffer,int maxSize) {
  return [[ExpressionEvaluator sharedEvaluator] yyinputToBuffer:theBuffer withSize:maxSize];
}

@implementation ExpressionEvaluator

-(id)init {
  self = [super init];
  if(self) {
    m_theLock = [[NSLock alloc] init];  
    m_theData = nil;
  }  
  return self;  
}

+(ExpressionEvaluator* )sharedEvaluator {
  static ExpressionEvaluator* object;  
	if(object==nil) {
		object = [[ExpressionEvaluator alloc] init];
	}
	return object;
}

///////////////////////////////////////////////////////////////////////////////
// properties

-(void)setString:(NSString* )theString {
  m_theData = [theString dataUsingEncoding:NSUTF8StringEncoding];
  m_thePos = 0;
}

///////////////////////////////////////////////////////////////////////////////
// methods

-(int)yyinputToBuffer:(char* )theBuffer withSize:(int)maxSize {
  int theNumberOfBytesRemaining = (int)([m_theData length] - m_thePos);
  int theCopySize = maxSize < theNumberOfBytesRemaining ? maxSize : theNumberOfBytesRemaining;
  [m_theData getBytes:theBuffer range:NSMakeRange(m_thePos,theCopySize)];  
  m_thePos = m_thePos + theCopySize;
  return theCopySize;
}

-(Node* )parse:(NSString* )theString {  
  // Acquire the lock to ensure one thing processing at a time
  [m_theLock lock];

  @try {
    // Reset the parser    
    yyreset_state();
    yyrestart(NULL);    
    // Set up parsing the given C string
    [self setString:theString];
    // Call the parser    
    yyparse();
  }
  @catch(NSException* theException) {
    yylastParsedNode = nil;
    @throw(theException);
  }
  @finally {
    [m_theLock unlock];
  }
  return yylastParsedNode;
}

@end
