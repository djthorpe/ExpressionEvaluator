
#import <Foundation/Foundation.h>

@interface Node : NSObject {
	
}

//+(Node* )stringNodeWithQuotedValue:(const char* )value;
+(Node* )numberNodeWithValue:(const char* )value;
+(Node* )booleanNodeWithValue:(BOOL)value;
+(Node* )variableNodeWithName:(const char* )name;
+(Node* )stringNodeWithQValue:(const char* )quoted;
+(Node* )functionNode:(NSString* )name,...;

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary;

@end
