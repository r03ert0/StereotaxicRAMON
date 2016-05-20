/* MyView */
#import <Cocoa/Cocoa.h>
#import "MyView3D.h"
#include "Analyze.h"
#include "nifti1.h"
#include "polygonizer3.h"
#include "voxtopology.h"
#import "MyDocumentProtocol.h"
#import <QTKit/QTKit.h>
#import <QuickTime/QuickTime.h>

#define kSELECT		1
#define kPAINT		2
#define kSAMPLE		3
#define kCSELECT	4
#define kPOLY		5
#define kFILL		6

#define kPI 3.14159265358979323846264

#define STACK 600000

typedef struct
{
    float x,y,z;
} float3D;
typedef struct
{
    int a,b,c;
} int3D;
typedef struct
{
    short       timeStamp;      // time stamp for the cell creation
    int         i;              // vertex index
    long        *next;          // next cell at the same hash
} HashCell;
typedef struct
{
    int np;
    int nt;
    float3D *p;
    int3D   *t;

    HashCell    *hash;          // collision detection hash table
    int         nhash;          // number of cells allocated for collision detection
    float       hashCellSize;   // cell size
} Mesh;

@interface MyView : NSView
{
	IBOutlet MyView3D	*view3D;
	
	AnalyzeHeader	*hdr;
	char			*data;
	int				dim[3];
	int				dataType;
	
	NSImage			*image;
	short			*selection;	// selection volume
	short			sindex;		// selection value index
	NSPoint			oldm;		// old mouse location
	int				polyFlag;	// polyFlag=0 -> start new polygon with next click
	NSBezierPath	*poly;		// Bezier path for polygon drawing
    
    Mesh        *mesh;
    int         flag_showMesh;  // show or hide mesh

	// GUI variables: variables that can be set and queried from the interface
	float	max,min;			// minimum and maximum data levels
	int		plane;				// view plane: X, Y or Z
	int		cmap;				// colour map index
	int		mode;				// mouse click mode: paint, sample, select, connected select, polygon
	int		pensize;			// size of paint region
	float	selectionOpacity;	// selection opacity
	float	selectionColor[3];	// selection colour
	float	volRotation[3];		// rotation angles for the volume, 0 by default
	float	thresholdWidth;		// threshold width

    NSTrackingArea  *trackingArea;
	
	id<MyDocument>	app;
}
-(float)slice;
-(void)setSlice:(int)slice;
-(void)setApp:(id)theApp;
-(void)setAnalyzeData:(char*)theHdr;
-(void)redraw;
-(float)getValueAt:(int)x :(int)y :(int)z;
-(int)setPixel:(unsigned char*)px withValueAt:(float)x :(float)y :(float)z;
-(void)setValue:(float)val at:(int)x :(int)y :(int)z;
-(void)setValue:(float)val at:(int)x :(int)y :(int)z volume:(char*)voldata;

-(AnalyzeHeader*)hdr;
-(short*)selection;
-(int)plane;
-(void)setPlane:(int)newPlane;
-(void)displayMessage:(NSString*)msg;
-(void)displayPolygonization;

-(void)abs;
-(void)addConstant:(float)x;
-(void)addSelection:(char*)path;
-(void)adjustMinMax;
-(void)applyRotation;
-(void)boundingBox;
-(void)box:(int)a :(int)b :(int)c :(int)d :(int)e :(int)f;
-(void)boxFilter:(int)r :(int)iter;
-(void)boxFilter1:(int)r;
-(void)changePixdim:(float)d0 :(float)d1 :(float)d2;
-(void)colormap:(char*)str;
-(void)commands;
-(void)connectedSelection:(int)x :(int)y :(int)z;
-(void)convertToMovie:(char*)path;
-(void)crop;
-(void)getCrop:(char**)crop dim:(int*)cdim;
-(void)getScaledNearest:(char**)scaled fx:(float)fx fy:(float)fy fz:(float)fz dim:(short*)sdim;
-(float)getScaledTrilinear1:(float)x :(float)y :(float)z :(int*)error;
-(void)getScaledTrilinear:(char**)scaled fx:(float)fx fy:(float)fy fz:(float)fz dim:(short*)sdim;
void dct_1d(float *in, float *out, int N);
void idct_1d(float *in, float *out, int N);
void dct_xyz(float *vol,float *coeff,int *dim8);
void idct_xyz(float *vol,float *coeff,int *dim8);
-(void)dct;
-(void)idct;
-(void)deselect;
-(void)dilate:(int)a;
-(void)erode:(int)a;
-(void)euler;
-(void)fill:(int)x :(int)y :(int)z :(char*)aPlane;
-(void)flip:(char*)d;
-(void)flipMesh:(char*)d;
-(void)grow:(float)Min :(float)Max;
-(void)help:(char*)cmd;
-(void)hideMesh;
-(void)histogram;
-(void)idct;
-(void)info;
-(void)invert;
-(BOOL)loadSelection:(char*)path;
-(BOOL)loadMesh:(char*)path;
-(void)make26;
-(void)minMax;
-(void)mode;
-(void)multiplyConstant:(float)x;
-(void)penSize:(int)a;
-(void)polygonize:(char*)path;
-(void)pushMesh:(float)d;
-(void)removeMesh;
-(void)reorient:(char*)ori;
-(void)reorientMesh:(char*)ori;
-(void)resample:(float)pixx :(float)pixy :(float)pixz :(char*)interpolation;
-(void)resize:(int)x :(int)y :(int)z :(char*)just;
-(BOOL)save;
-(BOOL)saveAs:(char*)path;
-(BOOL)saveMesh:(char*)path;
-(BOOL)saveSelection:(char*)path;
-(void)savePicture:(char*)path;
-(void)scaleMesh:(float)x;
-(void)select:(int)x :(int)y :(int)z :(float)mn :(float)mx;
-(void)set:(float)x;
-(void)setMinMax:(float)x :(float)y;
-(void)setMouse:(char*)str;
-(void)setRotation:(float)angleX :(float)angleY :(float)angleZ;
-(void)setSelectionColor:(float)r :(float)g :(float)b;
-(void)setSelectionOpacity:(float)o;
-(void)setThresholdWidth:(float)w;
-(void)setVolume:(char*)path;
-(void)showMesh;
-(void)smooth:(int)level :(int)iter;
-(void)smooth1:(char*)mask :(int)level;
-(void)smoothMeshLaplace:(float)lambda :(int)iterations;
-(void)smoothMeshTaubin:(float)lambda :(float)mu :(int)iterations;
-(void)stdev:(int)neigh :(float)maxstd;
-(void)stats;
-(void)subtractSelection:(char*)path;
-(void)threshold:(float)value :(int)direction;
-(void)tpDilate:(int)a;
-(void)tpDilateOnMask:(int)iter :(char*)path;
-(void)tpErode:(int)a;
-(void)translateMesh:(float)x :(float)y :(float)z;
-(void)undo;
-(void)voxeliseMesh;

@end
