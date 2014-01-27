/* MyView3D */

#import <Cocoa/Cocoa.h>
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>

#import "Trackball.h"

@interface MyView3D : NSOpenGLView
{
	IBOutlet NSButton   *checkXPlane;
	IBOutlet NSButton   *checkYPlane;
	IBOutlet NSButton   *checkZPlane;
    float	*p,*c,o[3],dim[3];
	int		*t;
	int		np;
	int		nt;

	float	zoom;
    float   crop;
	float	xslice,yslice,zslice;
	float	scale;
	float	pix[3];

	// trackball & rotation
	Trackball	*m_trackball;
	float		m_rotation[4];	// The main rotation
	float		m_tbRot[4];		// The trackball rotation
}
-(IBAction)setStandardRotation:(id)sender;
-(IBAction)changeView:(id)sender;
-(void)rotateBy:(float *)r;		// trackball method
-(void)newMesh:(int)mynp :(int)nt :(float**)myp :(int**)myt :(int *)dim;
-(void)setOrigin:(float*)origin;
-(void)depth;
-(void)setXSlice:(float)x;
-(void)setYSlice:(float)y;
-(void)setZSlice:(float)z;
-(void)setScale:(float)theScale;
-(void)setPixdim:(float*)thePixdim;
@end
