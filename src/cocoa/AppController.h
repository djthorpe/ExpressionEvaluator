//
//  AppController.h
//  ExpressionEvaluator
//
//  Created by David Thorpe on 10/02/2013.
//
//

#import <Cocoa/Cocoa.h>

#import "ParserContext.h"

@interface AppController : NSObject {
	ParserContext* _parser;
	NSString* _expression;
}

@property (readonly) ParserContext* parser;
@property (readonly) NSDictionary* variables;
@property NSString* expression;
@property IBOutlet NSTextView* ibTextView;

// IBActions
-(IBAction)ibEvaluateExpression:(id)sender;

@end
