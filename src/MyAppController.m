//
//  MyAppController.m
//  StereotaxicEditorRAMON
//
//  Created by roberto on 17/4/13.
//
//

#import "MyAppController.h"

@implementation MyAppController
-(IBAction)myRealUndo:(id)sender
{
    [[[NSDocumentController sharedDocumentController] currentDocument] undo];
}
@end
