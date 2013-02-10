
#import <Foundation/Foundation.h>

@interface PTNode : NSObject

+(PTNode* )numberNodeWithValue:(const char* )value;
+(PTNode* )booleanNodeWithValue:(BOOL)value;
+(PTNode* )variableNodeWithName:(const char* )name;
+(PTNode* )stringNodeWithQValue:(const char* )quoted;
+(PTNode* )functionNode:(NSString* )name,...;

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary;

@end
