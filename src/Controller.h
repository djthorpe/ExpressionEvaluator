//
//  Controller.h
//  ExpressionEvaluator
//
//  Created by David Thorpe on 07/01/2007.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Controller : NSObject {
  NSMutableDictionary* m_theDictionary;
  IBOutlet NSTextView* m_theTextView;
  IBOutlet NSTextField* m_theTextField;  
  IBOutlet NSTableView* m_theTableView;
}

-(IBAction)doEvaluate:(id)sender;

@end
