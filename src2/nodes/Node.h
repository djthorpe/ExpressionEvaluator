
#import <Foundation/Foundation.h>

@interface Node : NSObject {
	
}

+(Node* )node;
+(Node* )functionNode;
+(Node* )numberNode;
+(Node* )stringNode;
+(Node* )booleanNode;
+(Node* )identifierNode;

-(NSObject* )evaluateWithDictionary:(NSDictionary* )theDictionary;

@end
