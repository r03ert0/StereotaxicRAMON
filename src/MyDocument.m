//
//  MyDocument.m
//  StereotaxicEditorRAMON
//
//  Created by roberto on 01/07/2009.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self)
	{
		MyIntValueTransformer *myint;
			
		// create an autoreleased instance of our value transformer
		myint = [[[MyIntValueTransformer alloc] init] autorelease];
			
		// register it with the name that we refer to it with
		[NSValueTransformer setValueTransformer:myint forName:@"MyIntValueTransformer"];
		path=nil;
	}
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];

	[view setApp:self];
	[text setApp:self];
	[self setObjectType:"Volume"];
	[self ramonizeAtLaunch];
	
	[self initCmds];	
	[[NSNotificationCenter defaultCenter]	addObserver:self
											selector:@selector(printString:)
											name:@"MyPrintString"
											object:nil];
	[text insertText:@"> "];
	
	if(path==nil)
		return;
	[self readDataFromPath:path ofType:fileType];
	[self configureInterface];
	[view redraw];
	[view setNeedsDisplay:YES];	
}
- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If the given outError != NULL, ensure that you set *outError when returning nil.

    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.

    // For applications targeted for Panther or earlier systems, you should use the deprecated API -dataRepresentationOfType:. In this case you can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.

    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	return nil;
}

-(BOOL)readFromFile:(NSString*)filename ofType:(NSString*)theType
{
	path=[filename retain];
	fileType=[theType retain];
	
	return YES;
}

//- (BOOL)writeToURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError **)outError
//- (BOOL)saveToURL:(NSURL *)url ofType:(NSString *)typeName forSaveOperation:(NSSaveOperationType)saveOperation error:(NSError **)outError
- (BOOL)writeSafelyToURL:(NSURL *)url ofType:(NSString *)typeName forSaveOperation:(NSSaveOperationType)saveOperation error:(NSError **)outError
{
	
	/*
	if([info objectForKey:@"selection"])
	{
		NSString		*selPath=[info objectForKey:@"selection"];

		if([[NSFileManager defaultManager] fileExistsAtPath:selPath])
		{
			NSString	*root=[selPath stringByDeletingLastPathComponent];
			NSString	*file=[[selPath lastPathComponent] stringByDeletingPathExtension];
			NSString	*srcPath=[NSString stringWithFormat:@"%@/%@.img",root,file];
			NSString	*dstPath=[NSString stringWithFormat:@"%@/~%@.img",root,file];
			int	result;
			
			result=[[NSFileManager defaultManager] movePath:srcPath toPath:dstPath handler:nil];
			if(result==NO)
			[text insertText:@"ERROR: Cannot backup previous selection"];
		}
		[view saveSelection:(char*)[selPath UTF8String]];
	}
	*/
	[self writeDataToPath:[url path] ofType:typeName];
	
	return YES;
}
-(void)dealloc
{
	[self ramonizeAtTerminate];
	[super dealloc];
}
-(void)undo
{
    printf("Hola\n");
    [view undo];
    [view redraw];
    [view setNeedsDisplay:YES];
}
#pragma mark -
#pragma mark [ RAMON methods ]
-(void)configureVisualisation
{
	/*
	int	volSize;
	int	isNii,bpv;
	
	hdr=shm;
	img=shm+sizeof(AnalyzeHeader);
	
	// check if the volume is analyze or nifti1
	isNii=0;
	if(strcmp((*(nifti_1_header*)hdr).magic,"ni1")==0 || strcmp((*(nifti_1_header*)hdr).magic,"n+1")==0)
		isNii=1;
	
	bpv=isNii?NiftiBytesPerVoxel(*(nifti_1_header*)hdr):AnalyzeBytesPerVoxel(*(AnalyzeHeader*)hdr);
	volSize=(*(AnalyzeHeader*)hdr).dim[1]*(*(AnalyzeHeader*)hdr).dim[2]*(*(AnalyzeHeader*)hdr).dim[3]*bpv;
	if(volSize==0)
	{
		printf("ERROR: volume is empty\n");
		return;
	}
	
	[view setAnalyzeData:img dim:((AnalyzeHeader*)hdr)->dim dataType:(*(AnalyzeHeader*)hdr).datatype];
	
	if(volSize<size) // there may be a tailer
	{
		char	*tailer,infoPath[1024];
		tailer=shm+sizeof(AnalyzeHeader)+volSize;
		if(strlen(tailer))
		{
			sscanf(tailer," <tailer> \n %s ",infoPath);
			info=[NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%s",infoPath]];
			[info retain];
			[view loadSelection:(char*)[[info objectForKey:@"selection"] UTF8String]];
		}
	}
	*/

	NSDocumentController	*dc=[NSDocumentController sharedDocumentController];
	NSURL					*url;
	NSString				*ft;
	NSString				*thePath;
	
	thePath=[NSString stringWithUTF8String:shm];
	url=[NSURL fileURLWithPath:thePath];
	ft=[dc typeForContentsOfURL:url error:nil];
	[self readDataFromPath:thePath ofType:ft];
	
	[self configureInterface];
	[view redraw];
	[view setNeedsDisplay:YES];
}
-(void)cleanVisualisation
{
}
#pragma mark -
-(BOOL)readDataFromPath:(NSString*)thePath ofType:(NSString*)theType
{
	int	result=NO;
	
	[thePath retain];
	if(path)
		[path release];
	path=thePath;
	
	[theType retain];
	if(fileType)
		[fileType release];
	fileType=theType;
	
	if([theType isEqualTo:@"GZCompressedType"])
		result=[self readGZCompressedData:thePath];
	else
	if([theType isEqualTo:@"NiftiType"])
		result=[self readNiftiData:thePath];
	else
	if([theType isEqualTo:@"AnalyzeType"])
		result=[self readAnalyzeData:thePath];
	else
	if([theType isEqualTo:@"VolumeRAMONType"])
		result=[self readVolumeRAMONData:thePath];
	else
	if([theType isEqualTo:@"VolumeRAMONZipType"])
		result=[self readVolumeRAMONZipData:thePath];
	
	return result;
}
-(BOOL)readGZCompressedData:(NSString*)thePath
{
	int						result=NO;
	NSDocumentController	*dc=[NSDocumentController sharedDocumentController];
	NSURL					*url;
	NSString				*ft;
	NSString				*cmd,*newFilename,*newPath;
		
	// decompress
	newFilename=[[thePath lastPathComponent] stringByDeletingPathExtension];
	newPath=[NSString stringWithFormat:@"/tmp/TmpRAMON/%@",newFilename];
	cmd=[NSString stringWithFormat:@"/bin/mkdir /tmp/TmpRAMON;/usr/bin/gzip -cd '%@' > '%@'",thePath,newPath];
	system([cmd UTF8String]);

	// load
	url=[NSURL fileURLWithPath:newPath];
	ft=[dc typeForContentsOfURL:url error:nil];
	result=[self readDataFromPath:newPath ofType:ft];

	// remove temporary directory
	system("/bin/rm -r /tmp/TmpRAMON");
	
	return result;
}
-(BOOL)readAnalyzeData:(NSString*)thePath
{
	char	*addr;
	int		sz;
	int		swapped;

	// load data
	Analyze_load((char*)[thePath UTF8String], &addr,&sz,&swapped);
	[view setAnalyzeData:addr];
	
	return YES;
}
-(BOOL)readNiftiData:(NSString*)thePath
{
	char	*addr;
	int		sz;
	int		swapped;
	
	// load data
	Nifti_load((char*)[thePath UTF8String], &addr,&sz,&swapped);
	[view setAnalyzeData:addr];
	return YES;
}
-(BOOL)readVolumeRAMONData:(NSString*)thePath
{
	int				result=NO;
	NSDictionary	*dic=[NSDictionary dictionaryWithContentsOfFile:thePath];
	NSString		*volPath=[dic objectForKey:@"volume"];
	NSString		*selPath=[dic objectForKey:@"selection"];
	
	if([volPath isAbsolutePath])
		result=[self readAnalyzeData:volPath];
	else
		result=[self readAnalyzeData:[NSString stringWithFormat:@"%@/%@",[thePath stringByDeletingLastPathComponent],volPath]];
	
	if(result==NO)
		return result;
	
	if(selPath)
	{
		if([selPath isAbsolutePath])
			result=[view loadSelection:(char*)[selPath UTF8String]];
		else
			result=[view loadSelection:(char*)[[NSString stringWithFormat:@"%@/%@",[thePath stringByDeletingLastPathComponent],selPath] UTF8String]];
	}
	
	return result;
}
-(BOOL)readVolumeRAMONZipData:(NSString*)thePath
{
	int						result=NO;
	NSString				*cmd,*name;
	
	// decompress
	name=[[thePath lastPathComponent] stringByDeletingPathExtension];
	cmd=[NSString stringWithFormat:@"mkdir /tmp/TmpRAMON;unzip -joq %@ -d /tmp/TmpRAMON/",thePath];
	system([cmd UTF8String]);
	
	// load
	NSDictionary	*dic=[NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"/tmp/TmpRAMON/%@.vramon",name]];
	NSString		*volPath=[dic objectForKey:@"volume"];
	NSString		*selPath=[dic objectForKey:@"selection"];
	
	if([volPath isAbsolutePath])
		volPath=[volPath lastPathComponent];
	result=[self readAnalyzeData:[NSString stringWithFormat:@"/tmp/TmpRAMON/%@",volPath]];
	if(result==NO)
		return result;
	
	if(selPath)
	{
		if([selPath isAbsolutePath])
			selPath=[selPath lastPathComponent];
		result=[view loadSelection:(char*)[[NSString stringWithFormat:@"/tmp/TmpRAMON/%@",selPath] UTF8String]];
	}
	
	// remove temporary directory
	system("rm -r /tmp/TmpRAMON");
	
	return result;
}

#pragma mark -
-(BOOL)writeDataToPath:(NSString*)thePath ofType:(NSString*)theType
{
	int	result=NO;
	
	if([theType isEqualTo:@"GZCompressedType"])
		result=[self writeGZCompressedData:thePath];
	else
	if([theType isEqualTo:@"NiftiType"])
		result=[self writeNiftiData:thePath];
	else
	if([theType isEqualTo:@"AnalyzeType"])
		result=[self writeAnalyzeData:thePath];
	else
	if([theType isEqualTo:@"VolumeRAMONType"])
		result=[self writeVolumeRAMONData:thePath];
	else
	if([theType isEqualTo:@"VolumeRAMONZipType"])
		result=[self writeVolumeRAMONZipData:thePath];
	
	return result;
}
-(BOOL)writeGZCompressedData:(NSString*)thePath
{
	int	result=NO;
	
	NSDocumentController	*dc=[NSDocumentController sharedDocumentController];
	NSString				*theType;
	NSString				*cmd,*filename;
	
	// compress
	filename=[thePath stringByDeletingPathExtension];
	theType=[dc typeFromFileExtension:[filename pathExtension]];
	result=[self writeDataToPath:filename ofType:theType];

	cmd=[NSString stringWithFormat:@"/usr/bin/gzip -f %@",filename];
	system([cmd UTF8String]);

	return result;
}
-(BOOL)writeAnalyzeData:(NSString*)thePath
{
	int	result=NO;
	
	[view saveAs:(char*)[thePath UTF8String]];
	result=YES;
	return result;
}
-(BOOL)writeNiftiData:(NSString*)thePath
{
	int		result=NO;
	char	*addr=(char*)[view hdr];
	
	Nifti_save((char*)[thePath UTF8String], addr);
	result=YES;
	
	return result;
}
-(BOOL)writeVolumeRAMONData:(NSString*)thePath
{
	int	result;
	
	NSString	*root=[path stringByDeletingLastPathComponent];
	NSString	*file=[[path lastPathComponent] stringByDeletingPathExtension];
	NSString	*volumePath=[NSString stringWithFormat:@"%@/%@.hdr",root,file];
	NSString	*selectionPath=[NSString stringWithFormat:@"%@/%@.sel.hdr",root,file];
	NSMutableDictionary	*dic=[NSMutableDictionary new];

	result=[view saveAs:(char*)[volumePath UTF8String]];
	if(result==NO)
    {
        [dic release];
		return result;
    }

	[dic setValue:[NSString stringWithFormat:@"%@.hdr",file] forKey:@"volume"];
	if([view selection])
	{
		result=[view saveSelection:(char*)[selectionPath UTF8String]];
		if(result==NO)
        {
            [dic release];
            return result;
        }
		[dic setValue:[NSString stringWithFormat:@"%@.sel.hdr",file] forKey:@"selection"];
	}
	result=[[dic description] writeToURL:[NSURL fileURLWithPath:thePath] atomically:YES encoding:NSUTF8StringEncoding error:NULL];

	[dic release];

	return result;
}
-(BOOL)writeVolumeRAMONZipData:(NSString*)thePath
{
	int	result;
	
	NSString	*file=[[thePath lastPathComponent] stringByDeletingPathExtension];
	NSString	*dicPath=[NSString stringWithFormat:@"/tmp/TmpRAMON/%@.vramon",file];
	NSString	*volPath=[NSString stringWithFormat:@"/tmp/TmpRAMON/%@.hdr",file];
	NSString	*selPath=[NSString stringWithFormat:@"/tmp/TmpRAMON/%@.sel.hdr",file];
	NSMutableDictionary	*dic=[NSMutableDictionary new];
	
	system("mkdir /tmp/TmpRAMON");
	result=[view saveAs:(char*)[volPath UTF8String]];
	if(result==NO)
		return result;
	
	[dic setValue:[NSString stringWithFormat:@"%@.hdr",file] forKey:@"volume"];
	if([view selection])
	{
		result=[view saveSelection:(char*)[selPath UTF8String]];
		if(result==NO)
			return result;
		
		[dic setValue:[NSString stringWithFormat:@"%@.sel.hdr",file] forKey:@"selection"];
	}
	result=[[dic description] writeToURL:[NSURL fileURLWithPath:dicPath] atomically:YES encoding:NSUTF8StringEncoding error:NULL];
	[dic release];
	
	char	cmd[4096];
	sprintf(cmd,"zip -jq %s /tmp/TmpRAMON/*",[thePath UTF8String]);
	system(cmd);
	system("rm -r /tmp/TmpRAMON");
	
	return result;
}
#pragma mark -
-(void)configureInterface
{
	int	max,plane;
	// configure display
	plane=[[[settings content] valueForKey:@"plane"] intValue];
	max=([view hdr]->dim)[plane+1]-1;
	[[settings content] setValue:[NSNumber numberWithInt:0] forKey:@"minslice"];
	[[settings content] setValue:[NSNumber numberWithInt:max] forKey:@"maxslice"];
	[[settings content] setValue:[NSNumber numberWithInt:max/2] forKey:@"slice"];
}
-(IBAction)plane:(id)sender
{
	int	col=[sender selectedColumn]+1;
	if(col!=[view plane])
	{
		[self configureInterface];
		[view setPlane:col];
		[view redraw];
		[view setNeedsDisplay:YES];
	}
}
-(IBAction)slice:(id)sender
{
	float	maxslice=[[[settings content] valueForKey:@"maxslice"] floatValue];
	float	slice=[sender floatValue];

	if(slice>maxslice)
		slice=maxslice;
	if(slice<0)
		slice=0;
	[[settings content] setValue:[NSNumber numberWithInt:slice] forKey:@"slice"];
	[view redraw];
	[view setNeedsDisplay:YES];
}
-(IBAction)mouseMode:(id)sender
{
	int	row=[sender selectedRow];
	
	switch(row)
	{
		case 0:	// sample mode
			[text insertText:@"setMouse(sample)\n> "];
			[view setMouse:"sample"];
			break;
		case 1:	// paint mode
			[text insertText:@"setMouse(paint)\n> "];
			[view setMouse:"paint"];
			break;
		case 2:	// select mode
			[text insertText:@"setMouse(select)\n> "];
			[view setMouse:"select"];
			break;
		case 3:	// cselect mode
			[text insertText:@"setMouse(cselect)\n> "];
			[view setMouse:"cselect"];
			break;
		case 4:	// polygon mode
			[text insertText:@"setMouse(poly)\n> "];
			[view setMouse:"poly"];
			break;
		case 5:	// fill mode
			[text insertText:@"setMouse(fill)\n> "];
			[view setMouse:"fill"];
			break;
	}
}
-(IBAction)penSize:(id)sender
{
    [view penSize:atoi([[[sender selectedCell] title] UTF8String])];
}
-(IBAction)invert:(id)sender
{
    [view invert];
    [view redraw];
    [view setNeedsDisplay:YES];
}
#pragma mark -
-(NSObjectController*)settings
{
	return settings;
}
-(NSString*)path
{
	return path;
}
#pragma mark -
-(void)initCmds
{
	NSString	*cmdstr=@"{root=(\
{cmd=abs;                                                       help=\"Absolute value\";},\
{cmd=addConstant;		args=(float);							help=\"Add arg[1] to the volume values\";},\
{cmd=addSelection;		args=(string);							help=\"Add selection from arg[1]=path\";},\
{cmd=adjustMinMax;		args=();                                help=\"Adjust min and max grey level values to mean ± 2 standard deviations (clipped to the volume's min and max)\";},\
{cmd=applyRotation;		args=();								help=\"Apply current rotation\";},\
{cmd=boundingBox;		args=();                                help=\"Select the smallest box including all currently selected voxels\";},\
{cmd=box;				args=(int,int,int,int,int,int);			help=\"Select the region inside the box arg[1-6]=xmn,ymn,zmn,xmx,ymx,zmx\";},\
{cmd=boxFilter;			args=(int,int);							help=\"Arg[1]=filter size, arg[2]=iterations\";},\
{cmd=changePixdim;		args=(float,float,float);				help=\"arg[1-3]=Change voxel dimensions in the header\";},\
{cmd=colormap;			args=(string);							help=\"arg[1]={autumn, bone, winter, hot, water, solidred, solidrgb, jet, jetrgb, negpos, gray}\";},\
{cmd=commands;													help=\"List all commands\";},\
{cmd=connectedSelection;args=(int,int,int);						help=\"Keeps only the selection connected to arg[1-3]=x,y,z coordinate\";},\
{cmd=convertToMovie;	args=(string);							help=\"Convert slices into mp4 movie stored at path arg[1]\";},\
{cmd=crop;				args=();                                help=\"Crops volume to the bounding box of the selection\";},\
{cmd=dct;                                                       help=\"Direct cosine transform\";},\
{cmd=deselect;},\
{cmd=dilate;			args=(int);								help=\"Dilate selection arg[1]=number of voxels\";},\
{cmd=erode;				args=(int);								help=\"Erode selection arg[1]=number of voxels\";},\
{cmd=euler;														help=\"Display Euler's characteristic for the selection\";},\
{cmd=fill;				args=(int,int,int,string);              help=\"Fills in 2D starting at coordinates arg[1-3]=x,y,z in plane arg[4]=X, Y or Z\";},\
{cmd=flip;              args=(string);            				help=\"Flips the volume along the dimension argv[1]=x, y or z\";},\
{cmd=flipMesh;			args=(string);            				help=\"Flips the mesh (if loaded) along the dimension argv[1]=x, y or z\";},\
{cmd=grow;				args=(float,float);						help=\"Add to the actual selection connected voxels with values between arg[1,2]=min,max\";},\
{cmd=help;				args=(string);							help=\"Help\";},\
{cmd=hideMesh;                                                  help=\"Hide mesh\";},\
{cmd=histogram;},\
{cmd=idct;                                                      help=\"Inverse discrete cosine transform\";},\
{cmd=invert;													help=\"Invert selection\";},\
{cmd=info;														help=\"Display file information\";},\
{cmd=loadMesh;          args=(string);							help=\"Load a mesh in text format at arg[1]=path\";},\
{cmd=loadSelection;		args=(string);							help=\"Load selection at arg[1]=path\";},\
{cmd=make26;													help=\"Remove edge and corner neighbours so as to make the selection 26 connected.\";},\
{cmd=minMax;													help=\"Print minimum and maximum values\";},\
{cmd=mode;},\
{cmd=multiplyConstant;	args=(float);							help=\"Multiply the volume values by arg[1]\";},\
{cmd=penSize;			args=(int);								help=\"Arg[1]=size in pixels\";},\
{cmd=polygonize;		args=(string);							help=\"Save a mesh of the selection at arg[1]=path\";},\
{cmd=pushMesh;          args=(float);                           help=\"Push the mesh (if loaded) by arg[1]=distance along the normal\";},\
{cmd=reorient;			args=(string);							help=\"Change the current 'xyz' orientation of the volume to that of the string in arg[1], for example, zxy\";},\
{cmd=reorientMesh;			args=(string);							help=\"Change the current 'xyz' orientation of the mesh (if loaded) to that of the string in arg[1], for example, zxy\";},\
{cmd=resample;			args=(float,float,float,string);		help=\"Resample volume to pixel dimensions arg[1-3], using arg[4]={nearest,trilinear} interpolation\";},\
{cmd=resize;			args=(int,int,int,string);				help=\"Resize volume to dimension arg[1-3], arg[4]=three characters containing the justification flags s=start, c=center, e=end for the x, y and z dimensions (for example ssc=x start, y start, z center)\";},\
{cmd=save;														help=\"Overwrite volume\";},\
{cmd=saveAs;			args=(string);							help=\"Save data volume at arg[1]=path\";},\
{cmd=saveMesh;			args=(string);							help=\"Save mesh (if loaded) at arg[1]=path\";},\
{cmd=saveSelection;		args=(string);							help=\"Save selection at arg[1]=path\";},\
{cmd=savePicture;		args=(string);							help=\"Save current image at arg[1]=path\";},\
{cmd=scaleMesh;         args=(float);							help=\"Scale mesh (if loaded) with arg[1]=scale factor\";},\
{cmd=select;			args=(int,int,int,float,float);},\
{cmd=set;				args=(float);},\
{cmd=setMinMax;			args=(float,float);						help=\"Change the min,max values used for display to arg[1,2]=min,max\";},\
{cmd=setMouse;			args=(string);							help=\"Change mouse mode to arg[1]={sample,paint,select,cselect,poly,fill}\";},\
{cmd=setRotation;		args=(float,float,float);				help=\"Rotate the volume arg[1-3]=angle x, y, z, in degrees\";},\
{cmd=setSelectionColor;	args=(float,float,float);				help=\"Change selection color to RGB=arg[1-3]\";},\
{cmd=setSelectionOpacity;args=(float);							help=\"Change selection opacity to arg[1]\";},\
{cmd=setThresholdWidth;	args=(float);},\
{cmd=setVolume;			args=(string);},\
{cmd=showMesh;                                                  help=\"Show mesh\";},\
{cmd=smooth;			args=(int,int);                         help=\"Smooth selection by removing all voxels with less than argv[1]=threshold neighbours, typical threshold=13, for arg[2]=iterations\";},\
{cmd=smoothMeshLaplace;	args=(float,int);                       help=\"Laplace smoothing of the mesh (if loaded) with arg[1]=lambda in (-1,1), arg[2]=iterations\";},\
{cmd=smoothMeshTaubin;	args=(float,float,int);                 help=\"Taubin smoothing of the mesh (if loaded). Typical arg[1]=lambda=0.5, arg[2]=mu=-0.53, arg[3]=iterations\";},\
{cmd=stats;},\
{cmd=stdev;				args=(int, float);},\
{cmd=subtractSelection;	args=(string);							help=\"Subtract selection from arg[1]=path\";},\
{cmd=threshold;			args=(float,int);						help=\"Select values from arg[1]=threshold and down if arg[2]=0 or up if arg[2]=1\";},\
{cmd=tpDilate;			args=(int);								help=\"Topology-preserving dilate selection arg[1]=number of voxels\";},\
{cmd=tpDilateOnMask;	args=(int,string);						help=\"Topology-preserving dilate selection inside a mask, arg[1]=number of voxels, arg[2]=path a mask with the same dimensions as the current volume\";},\
{cmd=tpErode;			args=(int);								help=\"Topology-preserving erode selection arg[1]=number of voxels\";},\
{cmd=translateMesh;		args=(float,float,float);				help=\"Translate mesh (if loaded) by adding arg[1-3]=x, y and z displacements\";},\
{cmd=translateSelection;args=(int,int,int);                     help=\"Translate the selection by arg[1-3]=a, b and c voxels\";},\
{cmd=undo;},\
{cmd=voxeliseMesh;                                              help=\"Voxelise mesh (if loaded)\";}\
);}";
	NSDictionary	*dic=[cmdstr propertyListFromStringsFileFormat];
	cmds=[[dic objectForKey:@"root"] retain];
}
-(NSArray*)cmds
{
	return cmds;
}
-(void)printString:(NSNotification*)n
{
	if([n object]!=view)
		return;
	NSDictionary	*dic=[n userInfo];
	[text insertText:[dic objectForKey:@"string"]];
}
-(void)applyCmd:(NSArray*)theCmd
{
	int			i,m;
	int			a;
	float		x;
	char		*s;
	NSInvocation	*invoc;
		
	for(i=0;i<[cmds count];i++)
	{
		if([[theCmd objectAtIndex:0] caseInsensitiveCompare:[[cmds objectAtIndex:i] objectForKey:@"cmd"]]==NSOrderedSame)
		{
			NSString		*cmd=[[cmds objectAtIndex:i] objectForKey:@"cmd"];
			NSArray			*args=[[cmds objectAtIndex:i] objectForKey:@"args"];
			NSMutableString	*sig=[NSMutableString stringWithString:cmd];
			for(m=0;m<[args count];m++)
				[sig appendString:@":"];
			SEL sel=NSSelectorFromString(sig);
			invoc=[NSInvocation invocationWithMethodSignature:[view methodSignatureForSelector:sel]];
			[invoc setSelector:sel];
			[invoc setTarget:view];
			for(m=0;m<[args count];m++)
			{
				if([[args objectAtIndex:m] isEqualTo:@"int"])
				{
					a=[[theCmd objectAtIndex:m+1] intValue];
					[invoc setArgument:&a atIndex:m+2];
				}
				else
				if([[args objectAtIndex:m] isEqualTo:@"float"])
				{
					x=[[theCmd objectAtIndex:m+1] floatValue];
					[invoc setArgument:&x atIndex:m+2];
				}
				else
				if([[args objectAtIndex:m] isEqualTo:@"string"])
				{
					s=(char*)[[theCmd objectAtIndex:m+1] UTF8String];
					[invoc setArgument:&s atIndex:m+2];
				}
			}
			[invoc invoke];
			[view redraw];
			[view setNeedsDisplay:YES];
			return;
		}
	}
	if(i==[cmds count])
		[text insertText:@"\nCommand unknown\n"];
}
@end
