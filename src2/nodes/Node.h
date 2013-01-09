
#import <Foundation/Foundation.h>

@interface Node : NSObject {
	
}

+(Node* )functionNode:(NSString* )operation,...;
+(Node* )numberNodeWithValue:(const char* )value;
+(Node* )stringNodeWithQuotedValue:(const char* )value;
+(Node* )booleanNodeWithValue:(BOOL)value;
+(Node* )identifierNodeWithName:(const char* )name;

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary;

@end
