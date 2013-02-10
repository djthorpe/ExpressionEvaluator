
//  Created by David Thorpe on 05/06/2006.
//  Copyright 2006 Somethin' Else Sound Directions Limited.
//  All rights reserved.
//
//  You may use and copy in accordance to the BSD License
//  included with this computer code.
//

#import <Foundation/Foundation.h>
#import "ParserContext.h"

int main (int argc, const char * argv[]) {
	@autoreleasepool {
		ParserContext* parser = [[ParserContext alloc] init];
		NSError* error = nil;
		NSString* expression = @"david := 'hello'";
		PTNode* node = [parser parseString:expression error:&error];
		if(node==nil) {
			fprintf(stderr,"%s: %s",[[error domain] UTF8String],[[error localizedDescription] UTF8String]);
		} else {
			NSObject* obj = [parser evaluate:node error:&error];
			if(obj==nil) {
				fprintf(stderr,"%s: %s\n",[[error domain] UTF8String],[[error localizedDescription] UTF8String]);				
			} else {
				fprintf(stdout,"expression: %s\n",[expression UTF8String]);
				fprintf(stdout,"result: %s\n",[[obj description] UTF8String]);
				fprintf(stdout,"variables: %s\n",[[[parser variables] description] UTF8String]);
			}
		}
	}
	return 0;
}
