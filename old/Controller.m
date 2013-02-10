//
//  Controller.m
//  ExpressionEvaluator
//
//  Created by David Thorpe on 07/01/2007.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "Controller.h"
#import "Node.h"
#import "ExpressionEvaluator.h"

@implementation Controller

////////////////////////////////////////////////////////////////////////////////
// constructors and destructors

-(id)init {
  self = [super init];
  if (self != nil) {
    m_theDictionary = [[NSMutableDictionary alloc] init];
  }
  return self;
}

-(void)dealloc {
  [m_theDictionary release];
  [super dealloc];
}

-(void)awakeFromNib {
  // add in some example variables
  [m_theDictionary setObject:[NSNumber numberWithInt:42] forKey:@"life"];
  [m_theDictionary setObject:@"david" forKey:@"name"];
}

////////////////////////////////////////////////////////////////////////////////
// output a line to the textview

-(void)outputLine:(NSString* )theString withColor:(NSColor* )theColor {
  NSAttributedString* theString2 = 
    [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",theString ]
                                    attributes:[NSDictionary dictionaryWithObject:theColor forKey:NSForegroundColorAttributeName]];
  [[m_theTextView textStorage] appendAttributedString:theString2];
  [theString2 release];
}

////////////////////////////////////////////////////////////////////////////////
// scroll textview to bottom

-(void)scrollToBottom {
  NSClipView* theClipView = (NSClipView* )[m_theTextView superview];
  NSRect docRect = [m_theTextView frame];
  NSRect clipRect = [theClipView bounds];
  float theVerticalPoint = docRect.size.height - clipRect.size.height + 30.0f;
  if(theVerticalPoint > 30.0f) {
    [theClipView scrollToPoint:NSMakePoint(0,theVerticalPoint)];
  }
}

////////////////////////////////////////////////////////////////////////////////
// evaluate an expression

-(IBAction)doEvaluate:(id)sender {
  NSTextField* theTextField = (NSTextField* )sender;
  NSString* theStringValue = [theTextField stringValue];

  // compile an expression for evaluation
  Node* theExpression = nil;
  NSObject* theResult = nil;
  @try {
    theExpression = [[ExpressionEvaluator sharedEvaluator] parse:theStringValue];
  }
  @catch(NSException* theException) {
    [self outputLine:[NSString stringWithFormat:@"> %@",theStringValue] withColor:[NSColor blackColor]];
    [self outputLine:[NSString stringWithFormat:@"%@",theException] withColor:[NSColor redColor]];
  }

  // evaluate the expression
  @try {
    if(theExpression) {    
      theResult = [theExpression evaluateWithDictionary:m_theDictionary];
      [self outputLine:[NSString stringWithFormat:@"> %@",theStringValue] withColor:[NSColor blackColor]];
      [self outputLine:[NSString stringWithFormat:@"%@",theResult] withColor:[NSColor blueColor]];
    }
  }
  @catch(NSException* theException) {
    [self outputLine:[NSString stringWithFormat:@"> %@",theStringValue] withColor:[NSColor blackColor]];
    [self outputLine:[NSString stringWithFormat:@"%@",theException] withColor:[NSColor redColor]];
  }
  
  // empty the field and make it the focus
  [theTextField setStringValue:@""];
  [theTextField becomeFirstResponder];

  // scroll textview to bottom
  [self scrollToBottom];
  
  // reload the variables, they might have changed
  [m_theTableView reloadData];  
}


////////////////////////////////////////////////////////////////////////////////
// dictionary table view source

-(int)numberOfRowsInTableView:(NSTableView *)aTableView {
  return [m_theDictionary count];
}

-(id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex {
  NSArray* theKeys = [[m_theDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
  NSString* theKey = [theKeys objectAtIndex:rowIndex];
  if([[aTableColumn identifier] isEqual:@"name"]) {
    return theKey;
  }
  if([[aTableColumn identifier] isEqual:@"value"]) {
    NSObject* theObject = [m_theDictionary objectForKey:theKey];
    if([theObject isKindOfClass:[NSNumber class]]) {
      return theObject;
    }
    if([theObject isKindOfClass:[NSString class]]) {
      return [NSString stringWithFormat:@"'%@'",theObject];
    }
  }
  return nil;
}

-(void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(int)rowIndex {
  NSArray* theKeys = [[m_theDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
  NSString* theKey = [theKeys objectAtIndex:rowIndex];
  if([[aTableColumn identifier] isEqual:@"value"]) {
    // create an expression
    @try {
      Node* theExpression = [[ExpressionEvaluator sharedEvaluator] parse:(NSString* )anObject];
      [m_theDictionary setObject:[theExpression evaluateWithDictionary:m_theDictionary] forKey:theKey];
    }
    @catch(NSException* theException) {
      [self outputLine:[NSString stringWithFormat:@"> %@",anObject] withColor:[NSColor blackColor]];
      [self outputLine:[NSString stringWithFormat:@"%@",theException] withColor:[NSColor redColor]]; 
    }
  }
}

@end
