
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
		[parser parseString:@"Hello world"];
	}
	return 0;
}
