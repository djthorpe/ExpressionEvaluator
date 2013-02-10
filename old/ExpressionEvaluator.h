//
//  ExpressionEvaluator.h
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

@interface ExpressionEvaluator : NSObject {
  NSLock* m_theLock;
  NSData* m_theData;
  unsigned m_thePos;
}

// constructor
+(ExpressionEvaluator* )sharedEvaluator;

// methods
-(int)yyinputToBuffer:(char* )theBuffer withSize:(int)maxSize;
-(Node* )parse:(NSString* )theString;

@end
