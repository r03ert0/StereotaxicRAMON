//
//  MyIntValueTransformer.h
//  StereotaxicEditorRAMON
//
//  Created by roberto on 27/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyIntValueTransformer: NSValueTransformer {}
@end
@implementation MyIntValueTransformer
+ (Class)transformedValueClass { return [NSString class]; }
+ (BOOL)allowsReverseTransformation { return YES; }
- (id)transformedValue:(id)value
{
    return [NSNumber numberWithInt:[value intValue]];
}
- (id)reverseTransformedValue:(id)value
{
    return [NSNumber numberWithInt:[value intValue]];
}
@end