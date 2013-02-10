//
//  AppController.m
//  ExpressionEvaluator
//
//  Created by David Thorpe on 10/02/2013.
//
//

#import "AppController.h"
#import "ParserContext.h"

@implementation AppController

////////////////////////////////////////////////////////////////////////////////
// properties

@synthesize parser = _parser;
@synthesize expression = _expression;
@synthesize ibTextView;

@dynamic variables;

-(NSDictionary* )variables {
	return [[self parser] variables];
}

////////////////////////////////////////////////////////////////////////////////
// constructors

-(id)init {
	self = [super init];
	if(self) {
		_parser = [[ParserContext alloc] init];
		_expression = nil;
	}
	return self;
}

-(void)awakeFromNib {
	[self willChangeValueForKey:@"variables"];	
	[[self parser] setValue:[NSNumber numberWithInt:42] forKey:@"life"];
	[self didChangeValueForKey:@"variables"];
}

////////////////////////////////////////////////////////////////////////////////
// scroll textview to bottom

-(void)scrollToBottom {
	NSClipView* theClipView = (NSClipView* )[[self ibTextView] superview];
	NSRect docRect = [[self ibTextView] frame];
	NSRect clipRect = [theClipView bounds];
	float theVerticalPoint = docRect.size.height - clipRect.size.height + 30.0f;
	if(theVerticalPoint > 30.0f) {
		[theClipView scrollToPoint:NSMakePoint(0,theVerticalPoint)];
	}
}

////////////////////////////////////////////////////////////////////////////////
// append to log

-(void)outputLine:(NSString* )theString withColor:(NSColor* )theColor {
	NSDictionary* attributes = [NSDictionary dictionaryWithObject:theColor forKey:NSForegroundColorAttributeName];
	NSAttributedString* line = [[NSAttributedString alloc] initWithString:theString attributes:attributes];
	NSTextStorage* log = [[self ibTextView] textStorage];
	[log appendAttributedString:line];
	[log appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
	[self scrollToBottom];
}

////////////////////////////////////////////////////////////////////////////////
// actions

-(IBAction)ibEvaluateExpression:(id)sender {
	NSError* error = nil;

	[self outputLine:[self expression] withColor:[NSColor grayColor]];
	
	PTNode* node = [[self parser] parseString:[self expression] error:&error];
	if(node==nil) {
		[self outputLine:[error localizedDescription] withColor:[NSColor redColor]];
		return;
	}

	// indicate we may update dictionary
	[self willChangeValueForKey:@"variables"];
	
	NSObject* obj = [[self parser] evaluate:node error:&error];
	if(obj==nil) {
		[self outputLine:[error localizedDescription] withColor:[NSColor redColor]];
		return;
	}

	// indicate we updated dictionary
	[self didChangeValueForKey:@"variables"];

	[self outputLine:[obj description] withColor:[NSColor blackColor]];
}

@end
