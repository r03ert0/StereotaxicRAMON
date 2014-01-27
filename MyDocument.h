//
//  MyDocument.h
//  StereotaxicEditorRAMON
//
//  Created by roberto on 01/07/2009.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "DocumentRAMON.h"
#import "MyView.h"
#import "MyCommandView.h"
#import "MyIntValueTransformer.h"
#include "Analyze.h"
#include "Nifti.h"

#define kIntel		1
#define kMotorola	2

@interface MyDocument : DocumentRAMON
{
    IBOutlet NSObjectController	*settings;
	IBOutlet MyView				*view;
	IBOutlet MyCommandView		*text;
	NSString					*path;			// file path
	NSString					*fileType;		// file type
	NSArray						*cmds;
}
// Start RAMON methods
-(void)configureVisualisation;
-(void)cleanVisualisation;
// End RAMON methods

-(void)configureInterface;
-(IBAction)plane:(id)sender;
-(IBAction)slice:(id)sender;
-(IBAction)mouseMode:(id)sender;
-(IBAction)penSize:(id)sender;
-(IBAction)invert:(id)sender;
-(void)undo;

-(BOOL)readDataFromPath:(NSString*)thePath ofType:(NSString*)theType;
-(BOOL)readGZCompressedData:(NSString*)thePath;
-(BOOL)readAnalyzeData:(NSString*)thePath;
-(BOOL)readNiftiData:(NSString*)thePath;
-(BOOL)readVolumeRAMONData:(NSString*)thePath;
-(BOOL)readVolumeRAMONZipData:(NSString*)thePath;

-(BOOL)writeDataToPath:(NSString*)thePath ofType:(NSString*)theType;
-(BOOL)writeGZCompressedData:(NSString*)thePath;
-(BOOL)writeAnalyzeData:(NSString*)thePath;
-(BOOL)writeNiftiData:(NSString*)thePath;
-(BOOL)writeVolumeRAMONData:(NSString*)thePath;
-(BOOL)writeVolumeRAMONZipData:(NSString*)thePath;

-(NSObjectController*)settings;
-(void)initCmds;
-(NSArray*)cmds;
-(void)applyCmd:(NSArray*)theCmd;
-(void)printString:(NSNotification*)n;
-(NSString*)path;
@end
