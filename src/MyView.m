#import "MyView.h"
#include "colourmap.h"

@implementation MyView

float	Zero[16]={0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0};
float	X[16]={0,1,0,0, 0,0,1,0, 1,0,0,0, 0,0,0,1};
float	Y[16]={1,0,0,0, 0,0,1,0, 0,1,0,0, 0,0,0,1};
float	Z[16]={1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1};
void multMatVec(float *rV, float *M, float *V);
void multMatVec(float *rV, float *M, float *V)
{
	rV[0]=M[0]*V[0]+M[1]*V[1]+M[2]*V[2]+M[3];
	rV[1]=M[4]*V[0]+M[5]*V[1]+M[6]*V[2]+M[7];
	rV[2]=M[8]*V[0]+M[9]*V[1]+M[10]*V[2]+M[11];
}
float detMat(float *M);
float detMat(float *M)
{
	return	M[1]*M[11]*M[14]*M[4]-M[1]*M[10]*M[15]*M[4]-M[11]*M[13]*M[2]*M[4]+
			M[10]*M[13]*M[3]*M[4]-M[0]*M[11]*M[14]*M[5]+M[0]*M[10]*M[15]*M[5]+
			M[11]*M[12]*M[2]*M[5]-M[10]*M[12]*M[3]*M[5]-M[1]*M[11]*M[12]*M[6]+
			M[0]*M[11]*M[13]*M[6]+M[1]*M[10]*M[12]*M[7]-M[0]*M[10]*M[13]*M[7]-
			M[15]*M[2]*M[5]*M[8]+M[14]*M[3]*M[5]*M[8]+M[1]*M[15]*M[6]*M[8]-
			M[13]*M[3]*M[6]*M[8]-M[1]*M[14]*M[7]*M[8]+M[13]*M[2]*M[7]*M[8]+
			M[15]*M[2]*M[4]*M[9]-M[14]*M[3]*M[4]*M[9]-M[0]*M[15]*M[6]*M[9]+
			M[12]*M[3]*M[6]*M[9]+M[0]*M[14]*M[7]*M[9]-M[12]*M[2]*M[7]*M[9];
}
void invMat(float *rM, float *M);
void invMat(float *rM, float *M)
{
	float	d=detMat(M);
	int		i;
	rM[0] = -(M[11]*M[14]*M[5] - M[10]*M[15]*M[5] - M[11]*M[13]*M[6] + M[10]*M[13]*M[7] + M[15]*M[6]*M[9] - M[14]*M[7]*M[9]);
	rM[1] = M[1]*M[11]*M[14] - M[1]*M[10]*M[15] - M[11]*M[13]*M[2] + M[10]*M[13]*M[3] + M[15]*M[2]*M[9] - M[14]*M[3]*M[9];
	rM[2] = -(M[15]*M[2]*M[5] - M[14]*M[3]*M[5] - M[1]*M[15]*M[6] + M[13]*M[3]*M[6] + M[1]*M[14]*M[7] - M[13]*M[2]*M[7]);
	rM[3] = M[11]*M[2]*M[5] - M[10]*M[3]*M[5] - M[1]*M[11]*M[6] + M[1]*M[10]*M[7] + M[3]*M[6]*M[9] - M[2]*M[7]*M[9];
	
	rM[4] = M[11]*M[14]*M[4] - M[10]*M[15]*M[4] - M[11]*M[12]*M[6] + M[10]*M[12]*M[7] + M[15]*M[6]*M[8] - M[14]*M[7]*M[8];
	rM[5] = -(M[0]*M[11]*M[14] - M[0]*M[10]*M[15] - M[11]*M[12]*M[2] + M[10]*M[12]*M[3] + M[15]*M[2]*M[8] - M[14]*M[3]*M[8]);
	rM[6] = M[15]*M[2]*M[4] - M[14]*M[3]*M[4] - M[0]*M[15]*M[6] + M[12]*M[3]*M[6] + M[0]*M[14]*M[7] - M[12]*M[2]*M[7];
	rM[7] = -(M[11]*M[2]*M[4] - M[10]*M[3]*M[4] - M[0]*M[11]*M[6] + M[0]*M[10]*M[7] + M[3]*M[6]*M[8] - M[2]*M[7]*M[8]);
	
	rM[8] = -(M[11]*M[13]*M[4] - M[11]*M[12]*M[5] + M[15]*M[5]*M[8] - M[13]*M[7]*M[8] - M[15]*M[4]*M[9] + M[12]*M[7]*M[9]);
	rM[9] = -(M[1]*M[11]*M[12] - M[0]*M[11]*M[13] - M[1]*M[15]*M[8] + M[13]*M[3]*M[8] + M[0]*M[15]*M[9] - M[12]*M[3]*M[9]);
	rM[10]= -(M[1]*M[15]*M[4] - M[13]*M[3]*M[4] - M[0]*M[15]*M[5] + M[12]*M[3]*M[5] - M[1]*M[12]*M[7] + M[0]*M[13]*M[7]);
	rM[11]= M[1]*M[11]*M[4] - M[0]*M[11]*M[5] + M[3]*M[5]*M[8] - M[1]*M[7]*M[8] - M[3]*M[4]*M[9] + M[0]*M[7]*M[9];
	
	rM[12]= M[10]*M[13]*M[4] - M[10]*M[12]*M[5] + M[14]*M[5]*M[8] - M[13]*M[6]*M[8] - M[14]*M[4]*M[9] + M[12]*M[6]*M[9];
	rM[13]= M[1]*M[10]*M[12] - M[0]*M[10]*M[13] - M[1]*M[14]*M[8] + M[13]*M[2]*M[8] + M[0]*M[14]*M[9] - M[12]*M[2]*M[9];
	rM[14]= M[1]*M[14]*M[4] - M[13]*M[2]*M[4] - M[0]*M[14]*M[5] + M[12]*M[2]*M[5] - M[1]*M[12]*M[6] + M[0]*M[13]*M[6];
	rM[15]= -(M[1]*M[10]*M[4] - M[0]*M[10]*M[5] + M[2]*M[5]*M[8] - M[1]*M[6]*M[8] - M[2]*M[4]*M[9] + M[0]*M[6]*M[9]);
	
	for(i=0;i<16;i++)
		rM[i]*=1/d;
}
void angles2rotation(float angleX, float angleY, float angleZ, float *m)
{
	int		i;
	float	ax=angleX*kPI/180.0;
	float	ay=angleY*kPI/180.0;
	float	az=angleZ*kPI/180.0;
	float	tmp[16]={	 cos(ay)*cos(az),-cos(ax)*sin(az)+sin(ax)*sin(ay)*cos(az), sin(ax)*sin(az)+cos(ax)*sin(ay)*cos(az),0,
						 cos(ay)*sin(az), cos(ax)*cos(az)+sin(ax)*sin(ay)*sin(az),-sin(ax)*cos(az)+cos(ax)*sin(ay)*sin(az),0,
						-sin(ay)		, sin(ax)*cos(ay)						 , cos(ax)*cos(ay)						  ,0,
						 0				, 0										 , 0									  ,1};
	for(i=0;i<16;i++)
		m[i]=tmp[i];
}
float determinant(float3D a, float3D b, float3D c)
{
    float   D= a.x*(b.y*c.z-c.y*b.z)+
    a.y*(b.z*c.x-c.z*b.x)+
    a.z*(b.x*c.y-c.x*b.y);
    return D;
}

#pragma mark -
- (void)updateCursor
{
	// cursor to + symbol inside drawing region
    NSRect		fr=[self frame];
	float		tmp[3],tmpd[3],W,H;
	int			dim1[3];
    float		*P,invP[16];
    int         p=plane;
	
    if(dim[0]*dim[1]*dim[2]==0)
        return;
    
    switch(p)
	{
		case 1: P=(float*)X; break;
		case 2: P=(float*)Y; break;
		case 3: P=(float*)Z; break;
        default: P=(float*)Zero;
	}
	invMat(invP,P);
	
    tmp[0]=dim[0];
	tmp[1]=dim[1];
	tmp[2]=dim[2];
	multMatVec(tmpd,P,tmp);
	dim1[0]=(int)tmpd[0];
	dim1[1]=(int)tmpd[1];
	dim1[2]=(int)tmpd[2];
	
	W=(int)(pensize*fr.size.width/dim1[0] +0.5);
	H=(int)(pensize*fr.size.height/dim1[1]+0.5);
    
    NSImage *img=[[NSImage alloc] initWithSize:(NSSize){W+2,H+2}];
    NSBezierPath *bp=[NSBezierPath bezierPathWithRect:(NSRect){1,1,W,H}];
    [img lockFocus];
    [[NSColor whiteColor] set];
    [bp stroke];
    [img unlockFocus];

    [[[NSCursor alloc] initWithImage:img hotSpot:(NSPoint){W/2+1,H/2+1}] set];
}
-(void)cursorUpdate:(NSEvent *)theEvent
{
    [self updateCursor];
}
- (void)updateTrackingAreas
{
    [self removeTrackingArea:trackingArea];
    trackingArea = [[NSTrackingArea alloc] initWithRect:[self visibleRect]
                                                options: (NSTrackingCursorUpdate|NSTrackingActiveInKeyWindow)
                                                  owner:self userInfo:nil];
    [self addTrackingArea:trackingArea];
}
- (id)initWithFrame:(NSRect)frameRect
{
	if ((self = [super initWithFrame:frameRect]) != nil)
	{
		hdr=nil;
		data=nil;
		image=nil;
		selection=nil;
		sindex=1;
		plane=1;
		thresholdWidth=0;
		pensize=1;
		app=nil;
		cmap=GRAY;
		mode=kSAMPLE;
		oldm=(NSPoint){-1,-1};
		selectionColor[0]=255;
		selectionColor[1]=0;
		selectionColor[2]=0;
		selectionOpacity=0.5;
		polyFlag=0;
		poly=[[NSBezierPath bezierPath] retain];
		volRotation[0]=volRotation[1]=volRotation[2]=0;
        mesh=nil;
        
		printf("MyView initialised\n");

        trackingArea = [[NSTrackingArea alloc] initWithRect:[self visibleRect]
                                                                     options: (NSTrackingCursorUpdate|NSTrackingActiveInKeyWindow)
                                                                       owner:self userInfo:nil];
        [self addTrackingArea:trackingArea];
	}


    return self;
}
- (void)drawRect:(NSRect)rect
{
	[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationNone];
	if(image==nil)
		return;
	[image drawInRect:rect fromRect:(NSRect){{0,0},[image size]} operation:NSCompositeCopy fraction:1.0];
	
	if(mode==kPOLY)
	{
		[[NSColor greenColor] set];
		[poly stroke];
	}
    
    if(mesh!=nil && flag_showMesh==true)
        [self displayMesh];
}
-(BOOL)acceptsFirstResponder
{
	return YES;
}
-(BOOL)isFlipped
{
	return NO;
}
-(void)mouseDown:(NSEvent*)e
{
	NSRect		fr=[self frame];
	NSPoint		m=[self convertPoint:[e locationInWindow] fromView:nil];
	float		tmp[3],tmpd[3],tmpx[3];
	int			dim1[3];
	float		x1,y1,z1,volRot[16];
	float		val;
	float		*P,invP[16];
	float		slice=[[[[app settings] content] valueForKey:@"slice"] floatValue];
	
	angles2rotation(volRotation[0],volRotation[1],volRotation[2],volRot);
	
	switch(plane)
	{
		case 1: P=X; break;
		case 2: P=Y; break;
		case 3: P=Z; break;
        default: P=Zero;
	}
	invMat(invP,P);
	
	tmp[0]=dim[0];
	tmp[1]=dim[1];
	tmp[2]=dim[2];
	multMatVec(tmpd,P,tmp);
	dim1[0]=(int)tmpd[0];
	dim1[1]=(int)tmpd[1];
	dim1[2]=(int)tmpd[2];
	
	tmp[0]=(m.x/fr.size.width)*dim1[0];
	tmp[1]=((fr.size.height-m.y)/fr.size.height)*dim1[1];
	tmp[2]=slice;
	multMatVec(tmpx,invP,tmp);
	tmpx[0]=tmpx[0]-dim[0]/2.0;
	tmpx[1]=tmpx[1]-dim[1]/2.0;
	tmpx[2]=tmpx[2]-dim[2]/2.0;
	multMatVec(tmp,volRot,tmpx);
	x1=tmp[0]+dim[0]/2.0;
	y1=tmp[1]+dim[1]/2.0;
	z1=tmp[2]+dim[2]/2.0;
	
	val=[self getValueAt:x1:y1:z1];

	switch(mode)
	{
		case kSAMPLE:
			[self displayMessage:[NSString stringWithFormat:@"%.1f,%.1f,%.1f (%.1f)",x1,y1,z1,val]];
			break;
		case kSELECT:
			[self select:(int)x1:(int)y1:(int)z1:val-thresholdWidth:val+thresholdWidth];
			[self redraw];
			[self setNeedsDisplay:YES];
			break;
		case kCSELECT:
			[self connectedSelection:(int)x1:(int)y1:(int)z1];
			[self redraw];
			[self setNeedsDisplay:YES];
			break;
		case kPAINT:
		{
			int	i,j;
			int	R=pensize/2;
			
			// get the screen equivalent of x1,y1,z1
/*          x1=tmp[0];
			y1=tmp[1];
			z1=tmp[2];
*/
            x1=(m.x/fr.size.width)*dim1[0];
            y1=((fr.size.height-m.y)/fr.size.height)*dim1[1];
            z1=slice;

			for(i=-R;i<-R+pensize;i++)
			for(j=-R;j<-R+pensize;j++)
			{
				tmp[0]=(int)x1+i;
				tmp[1]=(int)y1+j;
				tmp[2]=z1;
				multMatVec(tmpx,invP,tmp);
				tmpx[0]=tmpx[0]-dim[0]/2.0;
				tmpx[1]=tmpx[1]-dim[1]/2.0;
				tmpx[2]=tmpx[2]-dim[2]/2.0;
				multMatVec(tmp,volRot,tmpx);
				tmpx[0]=tmp[0]+dim[0]/2.0;
				tmpx[1]=tmp[1]+dim[1]/2.0;
				tmpx[2]=tmp[2]+dim[2]/2.0;
				if(	tmpx[0]>=0 && tmpx[0]<dim[0] &&
					tmpx[1]>=0 && tmpx[1]<dim[1] &&
					tmpx[2]>=0 && tmpx[2]<dim[2])
                {
                    if([e modifierFlags]&NSAlternateKeyMask)
                    {
                        if(selection[((int)tmpx[2])*dim[1]*dim[0]+((int)tmpx[1])*dim[0]+((int)tmpx[0])])
                            selection[((int)tmpx[2])*dim[1]*dim[0]+((int)tmpx[1])*dim[0]+((int)tmpx[0])]=0;
                    }
                    else
                    {
                        if(selection[((int)tmpx[2])*dim[1]*dim[0]+((int)tmpx[1])*dim[0]+((int)tmpx[0])]==0)
                            selection[((int)tmpx[2])*dim[1]*dim[0]+((int)tmpx[1])*dim[0]+((int)tmpx[0])]=sindex;
                    }
                }
			}
			[self redraw];
			[self setNeedsDisplay:YES];
			break;
		}
		case kPOLY:
		{
			if(polyFlag==0)
			{
				[poly removeAllPoints];
				[poly moveToPoint:m];
				polyFlag=1;
			}
			else
			{
				[poly lineToPoint:m];
				if([e clickCount]==2)
				{
					int		i;
					float	sum;
					NSPoint	p0,p,tmp[3];
					
					sum=0;
					[poly elementAtIndex:0 associatedPoints:tmp];
					p0=tmp[0];
					p0.x=(p0.x/fr.size.width)*dim1[0];
					p0.y=((fr.size.height-p0.y)/fr.size.height)*dim1[1];
					for(i=1;i<[poly elementCount];i++)
					{
						[poly elementAtIndex:i associatedPoints:tmp];
						p=tmp[0];
						p.x=(p.x/fr.size.width)*dim1[0];
						p.y=((fr.size.height-p.y)/fr.size.height)*dim1[1];
						sum+=sqrt(pow(p.x-p0.x,2)+pow(p.y-p0.y,2));
						p0=p;
					}
					[self displayMessage:[NSString stringWithFormat:@"Poly length: %g",sum]];
					
					polyFlag=0;
				}
			}
			[self setNeedsDisplay:YES];
			break;
		}
		case kFILL:
		{
			switch(plane)
			{
				case 1: [self fill:x1:y1:z1:"X"]; break;
				case 2: [self fill:x1:y1:z1:"Y"]; break;
				case 3:	[self fill:x1:y1:z1:"Z"]; break;
			}
			[self redraw];
			[self setNeedsDisplay:YES];
			break;
		}
	}
}
-(void)lineFromPoint:(float*)tmp0 toPoint:(float*)tmp1 eraseFlag:(int)erase
{
    // Bresenham's line algorithm adapted from
    // http://stackoverflow.com/questions/4672279/bresenham-algorithm-in-javascript
    
    int	i,j;
    int	R=pensize/2;
    int x1=tmp0[0];
    int y1=tmp0[1];
    int x2=tmp1[0];
    int y2=tmp1[1];
    int z=tmp0[2];
    float *P,invP[16],volRot[16],tmp[3],tmpx[3];
    
    // Define differences and error check
    int dx = abs(x2 - x1);
    int dy = abs(y2 - y1);
    int sx = (x1 < x2) ? 1 : -1;
    int sy = (y1 < y2) ? 1 : -1;
    int err = dx - dy;
    int e2;
    
    // view rotation
    angles2rotation(volRotation[0],volRotation[1],volRotation[2],volRot);

    // stereotaxic plane
    switch(plane)
    {
        case 1: P=X; break;
        case 2: P=Y; break;
        case 3: P=Z; break;
    }
    invMat(invP,P);

    // paint 1st point

    while (!((x1 == x2) && (y1 == y2)))
    {
        e2 = err<<1;
        if (e2 > -dy)
        {
            err -= dy;
            x1 += sx;
        }
        if (e2 < dx)
        {
            err += dx;
            y1 += sy;
        }
        
        for(i=-R;i<-R+pensize;i++)
            for(j=-R;j<-R+pensize;j++)
            {
                tmp[0]=(int)x1+i;
                tmp[1]=(int)y1+j;
                tmp[2]=z;
 
                // get the screen equivalent of x1,y1,z1
                multMatVec(tmpx,invP,tmp);
                tmpx[0]=tmpx[0]-dim[0]/2.0;
                tmpx[1]=tmpx[1]-dim[1]/2.0;
                tmpx[2]=tmpx[2]-dim[2]/2.0;
                multMatVec(tmp,volRot,tmpx);
                tmpx[0]=tmp[0]+dim[0]/2.0;
                tmpx[1]=tmp[1]+dim[1]/2.0;
                tmpx[2]=tmp[2]+dim[2]/2.0;
                
                if(	tmpx[0]>=0 && tmpx[0]<dim[0] &&
                   tmpx[1]>=0 && tmpx[1]<dim[1] &&
                   tmpx[2]>=0 && tmpx[2]<dim[2])
                {
                    if(erase)
                    {
                        if(selection[((int)tmpx[2])*dim[1]*dim[0]+((int)tmpx[1])*dim[0]+((int)tmpx[0])])
                            selection[((int)tmpx[2])*dim[1]*dim[0]+((int)tmpx[1])*dim[0]+((int)tmpx[0])]=0;
                    }
                    else
                    {
                        if(selection[((int)tmpx[2])*dim[1]*dim[0]+((int)tmpx[1])*dim[0]+((int)tmpx[0])]==0)
                            selection[((int)tmpx[2])*dim[1]*dim[0]+((int)tmpx[1])*dim[0]+((int)tmpx[0])]=sindex;
                    }
                }
            }
    }

}
-(void)mouseDragged:(NSEvent*)e
{
	NSPoint		m=[self convertPoint:[e locationInWindow] fromView:nil];
	
	if(m.x==oldm.x&&m.y==oldm.y)
		return;	
	
	NSRect		fr=[self frame];
	float		tmp[3],tmpd[3],tmp0[3],tmp1[3];
	int			dim1[3];
	float		x0,y0,x1,y1,volRot[16];
	float		*P,invP[16];
	float		slice=[[[[app settings] content] valueForKey:@"slice"] floatValue];
    int         eraseFlag=[e modifierFlags]&NSAlternateKeyMask;
	
	// view rotation
    angles2rotation(volRotation[0],volRotation[1],volRotation[2],volRot);
	
    // stereotaxic plane
	switch(plane)
	{
		case 1: P=X; break;
		case 2: P=Y; break;
		case 3: P=Z; break;
	}
	invMat(invP,P);
	
    // get dimensions in display space
	tmp[0]=dim[0];
	tmp[1]=dim[1];
	tmp[2]=dim[2];
	multMatVec(tmpd,P,tmp);
	dim1[0]=(int)tmpd[0];
	dim1[1]=(int)tmpd[1];
	dim1[2]=(int)tmpd[2];
	
	// transform coordinates to display space
    x1=(m.x/fr.size.width)*dim1[0];
    y1=((fr.size.height-m.y)/fr.size.height)*dim1[1];

    if(oldm.x==-1 && oldm.y==-1)
    {
        x0=x1;
        y0=y1;
    }
    else
    {
        x0=(oldm.x/fr.size.width)*dim1[0];
        y0=((fr.size.height-oldm.y)/fr.size.height)*dim1[1];
    }

	switch(mode)
	{
		case kPAINT:
		{
            tmp0[0]=x0;
            tmp0[1]=y0;
            tmp0[2]=slice;
            tmp1[0]=x1;
            tmp1[1]=y1;
            tmp1[2]=slice;
            [self lineFromPoint:tmp0 toPoint:tmp1 eraseFlag:eraseFlag];
			[self redraw];
			[self setNeedsDisplay:YES];
			oldm=m;
			break;
		}
	}
}
-(void)mouseUp:(NSEvent*)e
{
	if(mode==kPAINT)
	{
		sindex++;
		id	doc=[[NSDocumentController sharedDocumentController] documentForWindow:[self window]];
		[doc updateChangeCount:NSChangeDone];
        oldm.x=-1;
        oldm.y=-1;
	}
	if([[view3D window] isVisible])
		[self displayPolygonization];
	
//	printf("X=%i\n",euler(selection,dim));
}
-(void)keyDown:(NSEvent*)e
{
	float		slice=[[[[app settings] content] valueForKey:@"slice"] floatValue];

	//printf("key code: %i\n",[e keyCode]);
	switch([e keyCode])
	{
		case 123:		// <-
			[self setSlice:slice-1];
			[self redraw];
			[self setNeedsDisplay:YES];
			break;
		case 124:		// ->
			[self setSlice:slice+1];
			[self redraw];
			[self setNeedsDisplay:YES];
			break;
		case 49:		// [ space ]
			[self invert];
			[self redraw];
			[self setNeedsDisplay:YES];
			break;
	}
}
#pragma mark -
-(float)slice
{
	return 	[[[[app settings] content] valueForKey:@"slice"] floatValue];
}
-(void)setSlice:(int)slice
{
	float	maxslice=[[[[app settings] content] valueForKey:@"maxslice"] floatValue];
	if(slice>maxslice)
		slice=maxslice;
	if(slice<0)
		slice=0;
	[[[app settings] content] setValue:[NSNumber numberWithInt:slice] forKey:@"slice"];
	
    switch(plane)
    {
        case 1:// 0=X plane
            [view3D setXSlice:slice];
            break;
        case 2:// 1=Y plane
            [view3D setYSlice:slice];
            break;
        case 3:// 2=Z plane
            [view3D setZSlice:slice];
            break;
    }
}
-(void)configureData:(char*)theHdr
{
	if(hdr)
		free(hdr);
	hdr=(AnalyzeHeader*)theHdr;
	data=theHdr+sizeof(AnalyzeHeader);
	dataType=hdr->datatype;

	// configure dimensions
	if(hdr->dim[4]>1)				// diffusion tensor data, to represent as RGB values
	{
		dim[0]=hdr->dim[2];
		dim[1]=hdr->dim[3];
		dim[2]=hdr->dim[4];
	}
	else								// everything else
	{
		dim[0]=hdr->dim[1];
		dim[1]=hdr->dim[2];
		dim[2]=hdr->dim[3];
	}	
}
-(void)configureMinMax
{
	int		i;
	float	val;

    for(i=0;i<dim[0]*dim[1]*dim[2];i++)
	{
		if(dataType==RGBFLOAT)
		{
			val=((float3D*)data)[i].x;
			if(i==0) min=max=val;
			if(min>val) min=val;
			if(max<val) max=val;
			val=((float3D*)data)[i].y;
			if(min>val) min=val;
			if(max<val) max=val;
			val=((float3D*)data)[i].z;
			if(min>val) min=val;
			if(max<val) max=val;
		}
		else
		{
			switch(dataType){
                case UCHAR:
                    val=((unsigned char*)data)[i];
                    break;
                case DT_INT8:
                    val=((char*)data)[i];
                    break;
				case SHORT:
                    val=((short*)data)[i];
                    break;
                case DT_UINT16:
                    val=((unsigned short*)data)[i];
                    break;
				case INT:
                    val=((int*)data)[i];
                    break;
                case DT_UINT32:
                    val=((unsigned int*)data)[i];
                    break;
				case FLOAT:
                    val=((float*)data)[i];
                    break;
			}
			if(i==0) min=max=val;
			if(min>val) min=val;
			if(max<val) max=val;
		}
	}
	printf("[min,max]=(%f,%f)\n",min,max);
}
-(void)configureSelection
{
	if(selection)
		free(selection);
	selection=(short*)calloc(dim[0]*dim[1]*dim[2],sizeof(short));
}
-(void)setAnalyzeData:(char*)theHdr;
{
	// configure data
	[self configureData:(char*)theHdr];
	
  // adjust max/min values
  [self adjustMinMax];

	// configure selection mask
	[self configureSelection];
}
-(void)redraw
{
    int				x,y,z;
	float			tmp[3],tmpd[3],tmpx[3];
	int				dim1[3];
	float			x1,y1,z1,volRot[16];
	unsigned char	px[4];
	float			*P,invP[16];
	float			slice=[[[[app settings] content] valueForKey:@"slice"] floatValue];
	
    switch(plane)
    {
        case 1:// 0=X plane
            [view3D setXSlice:slice];
            break;
        case 2:// 1=Y plane
            [view3D setYSlice:slice];
            break;
        case 3:// 2=Z plane
            [view3D setZSlice:slice];
            break;
    }

	switch(plane)
	{
		case 1: P=X; break;
		case 2: P=Y; break;
		case 3: P=Z; break;
	}
	invMat(invP,P);
	
	tmp[0]=dim[0];
	tmp[1]=dim[1];
	tmp[2]=dim[2];
	multMatVec(tmpd,P,tmp);
	dim1[0]=(int)tmpd[0];
	dim1[1]=(int)tmpd[1];
	dim1[2]=(int)tmpd[2];
	
	NSBitmapImageRep *bmp=[[[NSBitmapImageRep alloc]
                                initWithBitmapDataPlanes:NULL
                                pixelsWide:dim1[0]
                                pixelsHigh:dim1[1]
                                bitsPerSample:8
                                samplesPerPixel:4
                                hasAlpha:YES
                                isPlanar:NO
                                colorSpaceName:NSCalibratedRGBColorSpace
                                bytesPerRow:0
                                bitsPerPixel:0] autorelease];
    unsigned char	*baseaddr=[bmp bitmapData];
	int				bpr=(int)[bmp bytesPerRow];
	
	z=slice;
	
	angles2rotation(volRotation[0],volRotation[1],volRotation[2],volRot);
	
	for(x=0;x<dim1[0];x++)
	for(y=0;y<dim1[1];y++)
	{
		tmp[0]=x;
		tmp[1]=y;
		tmp[2]=z;
		multMatVec(tmpx,invP,tmp);
		tmpx[0]=tmpx[0]-dim[0]/2.0;
		tmpx[1]=tmpx[1]-dim[1]/2.0;
		tmpx[2]=tmpx[2]-dim[2]/2.0;
		multMatVec(tmp,volRot,tmpx);
		x1=tmp[0]+dim[0]/2.0;
		y1=tmp[1]+dim[1]/2.0;
		z1=tmp[2]+dim[2]/2.0;
		
		if([self setPixel:px withValueAt:x1:y1:z1])
		if(selection[(int)z1*dim[1]*dim[0]+(int)y1*dim[0]+(int)x1])
		{
/*
			// additive
			px[0]=(1-selectionOpacity)*px[0]+selectionOpacity*selectionColor[0];
			px[1]=(1-selectionOpacity)*px[1]+selectionOpacity*selectionColor[1];
			px[2]=(1-selectionOpacity)*px[2]+selectionOpacity*selectionColor[2];
*/
			// multiplicative 
			px[0]=(1-selectionOpacity)*px[0]+selectionOpacity*px[0]*selectionColor[0]/255.0;
			px[1]=(1-selectionOpacity)*px[1]+selectionOpacity*px[1]*selectionColor[1]/255.0;
			px[2]=(1-selectionOpacity)*px[2]+selectionOpacity*px[2]*selectionColor[2]/255.0;
		}

		baseaddr[y*bpr+4*x+0]=px[0];
		baseaddr[y*bpr+4*x+1]=px[1];
		baseaddr[y*bpr+4*x+2]=px[2];
		baseaddr[y*bpr+4*x+3]=255;
		
	}

    if(image)
		[image release];
	image = [NSImage new];
    [image addRepresentation:bmp];
}
-(int)setPixel:(unsigned char*)px withValueAt :(float)x :(float)y :(float)z
{
	float		val;
	RGBValue	rgb;
	float3D		rgbfloat;
	int			error;

	px[0]=px[1]=px[2]=0;
	if(x<0 || x>=dim[0] || y<0 || y>=dim[1] || z<0 || z>=dim[2])
		return NO;
	
	if(dataType==RGB)
	{
		rgb=((RGBValue*)data)[(int)z*dim[1]*dim[0]+(int)y*dim[0]+(int)x];
		px[0]=rgb.r;
		px[1]=rgb.g;
		px[2]=rgb.b;
	}
	else
	if(dataType==RGBFLOAT)
	{
		rgbfloat=((float3D*)data)[(int)z*dim[1]*dim[0]+(int)y*dim[0]+(int)x];
		px[0]=(rgbfloat.x-min)/(max-min)*255;
		px[1]=(rgbfloat.y-min)/(max-min)*255;
		px[2]=(rgbfloat.z-min)/(max-min)*255;
	}
	else
	{
		val=[self getScaledTrilinear1:x:y:z:&error];
		if(!error)
        {
            if(min==max)
                px[0]=px[1]=px[2]=0;
            else
                colourmap((val-min)/(max-min),px,cmap);
        }
	}
	
	return YES;
}
-(float)getValueAt:(int)x :(int)y :(int)z
{
	float		val;
	RGBValue	rgb;

	if(dataType==RGB)
	{
		rgb=((RGBValue*)data)[z*dim[1]*dim[0]+y*dim[0]+x];
		val=((int)rgb.r)>>16|((int)rgb.g)>>8|((int)rgb.b);
	}
	else
	{
		switch(dataType)
        {   case UCHAR:     val=((unsigned char*)data)[z*dim[1]*dim[0]+y*dim[0]+x];         break;
            case DT_INT8:   val=((char*)data)[z*dim[1]*dim[0]+y*dim[0]+x];                  break;
            case SHORT:     val=        ((short*)data)[z*dim[1]*dim[0]+y*dim[0]+x];         break;
            case DT_UINT16: val=        ((unsigned short*)data)[z*dim[1]*dim[0]+y*dim[0]+x];break;
            case INT:       val=          ((int*)data)[z*dim[1]*dim[0]+y*dim[0]+x];         break;
            case DT_UINT32: val=          ((unsigned int*)data)[z*dim[1]*dim[0]+y*dim[0]+x];break;
			case FLOAT:	    val=        ((float*)data)[z*dim[1]*dim[0]+y*dim[0]+x];	        break;
		}
	}
	return val;
}
-(void)getScaledNearest:(char**)scaled fx:(float)fx fy:(float)fy fz:(float)fz dim:(short*)sdim
{
	int	i,j,k;
	sdim[0]=ceil(fabs(dim[0]*fx));
	sdim[1]=ceil(fabs(dim[1]*fy));
	sdim[2]=ceil(fabs(dim[2]*fz));
	
	switch(dataType)
	{
		case UCHAR:
			*scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(char));
			for(i=0;i<sdim[0];i++)
				for(j=0;j<sdim[1];j++)
					for(k=0;k<sdim[2];k++)
						((unsigned char*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=((unsigned char*)data)[((int)(k/fz))*dim[1]*dim[0]+((int)(j/fy))*dim[0]+(int)(i/fx)];
			break;
		case SHORT:
			*scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(short));
			for(i=0;i<sdim[0];i++)
				for(j=0;j<sdim[1];j++)
					for(k=0;k<sdim[2];k++)
						((short*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=((short*)data)[((int)(k/fz))*dim[1]*dim[0]+((int)(j/fy))*dim[0]+(int)(i/fx)];
			break;
		case INT:
			*scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(int));
			for(i=0;i<sdim[0];i++)
				for(j=0;j<sdim[1];j++)
					for(k=0;k<sdim[2];k++)
						((int*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=((int*)data)[((int)(k/fz))*dim[1]*dim[0]+((int)(j/fy))*dim[0]+(int)(i/fx)];
			break;
		case FLOAT:
			*scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(float));
			for(i=0;i<sdim[0];i++)
				for(j=0;j<sdim[1];j++)
					for(k=0;k<sdim[2];k++)
						((float*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=((float*)data)[((int)(k/fz))*dim[1]*dim[0]+((int)(j/fy))*dim[0]+(int)(i/fx)];
			break;
		case RGB:
			*scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(RGBValue));
			for(i=0;i<sdim[0];i++)
				for(j=0;j<sdim[1];j++)
					for(k=0;k<sdim[2];k++)
						((RGBValue*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=((RGBValue*)data)[((int)(k/fz))*dim[1]*dim[0]+((int)(j/fy))*dim[0]+(int)(i/fx)];
			break;
	}
}
-(float)getScaledTrilinear1:(float)x :(float)y :(float)z :(int*)error
{
	int				i;
	int				a,b,c;		// voxel origin (index space)
	int				wX,wY,wZ;	// volume width, length and depth (index space)
	float			v;
	AnalyzeHeader	h;
	float			pix[3];
	
	*error=0;
	
	h=*hdr;
	for(i=0;i<3;i++)
		pix[i]=fabs(h.pixdim[i+1]);
	
	wX=abs(dim[0]);
	wY=abs(dim[1]);
	wZ=abs(dim[2]);
	
	// voxel origin in index space
	a=(int)x;
	b=(int)y;
	c=(int)z;
	
	// convert {x,y,z} to index coordinates, relative to the voxel origin
	x=x-a;
	y=y-b;
	z=z-c;
	
	if((a>=0&&a<wX-1)&&(b>=0&&b<wY-1)&&(c>=0&&c<wZ-1))
	{
		v=
		[self getValueAt:a  :b  :c  ]*(1-x)*(1-y)*(1-z) +
		[self getValueAt:a+1:b  :c  ]*x*(1-y)*(1-z) + 
		[self getValueAt:a  :b+1:c  ]*(1-x)*y*(1-z) + 
		[self getValueAt:a  :b  :c+1]*(1-x)*(1-y)*z +
		[self getValueAt:a+1:b  :c+1]*x*(1-y)*z + 
		[self getValueAt:a  :b+1:c+1]*(1-x)*y*z + 
		[self getValueAt:a+1:b+1:c  ]*x*y*(1-z) + 
		[self getValueAt:a+1:b+1:c+1]*x*y*z;
	}
	else
	{
		v=0;
		*error=1;
	}
	
	return v;
}
-(void)getScaledTrilinear:(char**)scaled fx:(float)fx fy:(float)fy fz:(float)fz dim:(short*)sdim
{
	int	i,j,k,error;
	sdim[0]=ceil(fabs(dim[0]*fx));
	sdim[1]=ceil(fabs(dim[1]*fy));
	sdim[2]=ceil(fabs(dim[2]*fz));
	
	switch(dataType)
	{
        case UCHAR:
            *scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(char));
            for(i=0;i<sdim[0];i++)
                for(j=0;j<sdim[1];j++)
                    for(k=0;k<sdim[2];k++)
                        ((unsigned char*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=[self getScaledTrilinear1:i/fx:j/fy:k/fz:&error];
            break;
        case DT_INT8:
            *scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(char));
            for(i=0;i<sdim[0];i++)
                for(j=0;j<sdim[1];j++)
                    for(k=0;k<sdim[2];k++)
                        ((char*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=[self getScaledTrilinear1:i/fx:j/fy:k/fz:&error];
            break;
        case SHORT:
            *scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(short));
            for(i=0;i<sdim[0];i++)
                for(j=0;j<sdim[1];j++)
                    for(k=0;k<sdim[2];k++)
                        ((short*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=[self getScaledTrilinear1:i/fx:j/fy:k/fz:&error];
            break;
        case DT_UINT16:
            *scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(short));
            for(i=0;i<sdim[0];i++)
                for(j=0;j<sdim[1];j++)
                    for(k=0;k<sdim[2];k++)
                        ((unsigned short*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=[self getScaledTrilinear1:i/fx:j/fy:k/fz:&error];
            break;
        case INT:
            *scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(int));
            for(i=0;i<sdim[0];i++)
                for(j=0;j<sdim[1];j++)
                    for(k=0;k<sdim[2];k++)
                        ((int*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=[self getScaledTrilinear1:i/fx:j/fy:k/fz:&error];
            break;
        case DT_UINT32:
            *scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(int));
            for(i=0;i<sdim[0];i++)
                for(j=0;j<sdim[1];j++)
                    for(k=0;k<sdim[2];k++)
                        ((unsigned int*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=[self getScaledTrilinear1:i/fx:j/fy:k/fz:&error];
            break;
		case FLOAT:
			*scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(float));
			for(i=0;i<sdim[0];i++)
				for(j=0;j<sdim[1];j++)
					for(k=0;k<sdim[2];k++)
						((float*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=[self getScaledTrilinear1:i/fx:j/fy:k/fz:&error];
			break;
	}
}
-(float)getScaledSelectionTrilinear1:(float)x :(float)y :(float)z
{
	int				i;
	int				a,b,c;		// voxel origin (index space)
	int				wX,wY,wZ;	// volume width, length and depth (index space)
	float			v;
	AnalyzeHeader	h;
	float			pix[3];
	
	h=*hdr;
	for(i=0;i<3;i++)
		pix[i]=fabs(h.pixdim[i+1]);
	
	wX=abs(dim[0]);
	wY=abs(dim[1]);
	wZ=abs(dim[2]);
	
	// voxel origin in index space
	a=(int)x;
	b=(int)y;
	c=(int)z;
	
	// convert {x,y,z} to index coordinates, relative to the voxel origin
	x=x-a;
	y=y-b;
	z=z-c;
	
	if((a>=0&&a<(wX-1))&&(b>=0&&b<(wY-1))&&(c>=0&&c<(wZ-1)))
	{
		v=
		(selection[( c )*wY*wX+( b )*wX+( a )]>0)*(1-x)*(1-y)*(1-z) +
		(selection[( c )*wY*wX+( b )*wX+(a+1)]>0)*x*(1-y)*(1-z) +
		(selection[( c )*wY*wX+(b+1)*wX+( a )]>0)*(1-x)*y*(1-z) +
		(selection[(c+1)*wY*wX+( b )*wX+( a )]>0)*(1-x)*(1-y)*z +
		(selection[(c+1)*wY*wX+( b )*wX+(a+1)]>0)*x*(1-y)*z +
		(selection[(c+1)*wY*wX+(b+1)*wX+( a )]>0)*(1-x)*y*z +
		(selection[( c )*wY*wX+(b+1)*wX+(a+1)]>0)*x*y*(1-z) +
		(selection[(c+1)*wY*wX+(b+1)*wX+(a+1)]>0)*x*y*z;
	}
	else
		v=0;
	
	return (v>=0.5);
}
-(void)getScaledSelectionTrilinear:(short**)scaled fx:(float)fx fy:(float)fy fz:(float)fz dim:(short*)sdim
{
	int	i,j,k;
	sdim[0]=ceil(fabs(dim[0]*fx));
	sdim[1]=ceil(fabs(dim[1]*fy));
	sdim[2]=ceil(fabs(dim[2]*fz));
	
	*scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(short));
	for(i=0;i<sdim[0];i++)
		for(j=0;j<sdim[1];j++)
			for(k=0;k<sdim[2];k++)
				((short*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=[self getScaledSelectionTrilinear1:i/fx:j/fy:k/fz];
}
-(void)setValue:(float)val at:(int)x :(int)y :(int)z
{
	switch(dataType)
    {   case UCHAR: ((unsigned char*)data)[z*dim[1]*dim[0]+y*dim[0]+x]=val;         break;
        case DT_INT8: ((char*)data)[z*dim[1]*dim[0]+y*dim[0]+x]=val;                break;
		case SHORT:
		{
			if(val<SHRT_MIN)
				val=SHRT_MIN;
			if(val>SHRT_MAX)
				val=SHRT_MAX;
			((short*)data)[z*dim[1]*dim[0]+y*dim[0]+x]=val;
			break;
		}
        case DT_UINT16: ((unsigned short*)data)[z*dim[1]*dim[0]+y*dim[0]+x]=val;             break;
        case INT: ((int*)data)[z*dim[1]*dim[0]+y*dim[0]+x]=val;                    break;
        case DT_UINT32: ((unsigned int*)data)[z*dim[1]*dim[0]+y*dim[0]+x]=val;                    break;
		case FLOAT:	((float*)data)[z*dim[1]*dim[0]+y*dim[0]+x]=val;					break;
	}
}
-(void)setValue:(float)val at:(int)x :(int)y :(int)z volume:(char*)voldata
{
	switch(dataType)
	{	case UCHAR: ((unsigned char*)voldata)[z*dim[1]*dim[0]+y*dim[0]+x]=val;			break;
        case DT_INT8: ((char*)voldata)[z*dim[1]*dim[0]+y*dim[0]+x]=val;            break;
		case SHORT:
		{
			if(val<SHRT_MIN)
				val=SHRT_MIN;
			if(val>SHRT_MAX)
				val=SHRT_MAX;
			((short*)voldata)[z*dim[1]*dim[0]+y*dim[0]+x]=val;
			break;
		}
        case DT_UINT16: ((unsigned short*)voldata)[z*dim[1]*dim[0]+y*dim[0]+x]=val;break;
        case INT:    ((int*)voldata)[z*dim[1]*dim[0]+y*dim[0]+x]=val;                    break;
        case DT_UINT32:    ((unsigned int*)voldata)[z*dim[1]*dim[0]+y*dim[0]+x]=val;                    break;
		case FLOAT:	((float*)voldata)[z*dim[1]*dim[0]+y*dim[0]+x]=val;					break;
	}
}
#pragma mark -
-(AnalyzeHeader*)hdr
{
	return hdr;
}
-(short*)selection
{
	return selection;
}
-(int)plane
{
	return plane;
}
-(void)setPlane:(int)newPlane
{
	plane=newPlane;

	float			slice=[[[[app settings] content] valueForKey:@"slice"] floatValue];
    switch(plane)
    {
        case 1: [view3D setXSlice:slice]; break;
        case 2: [view3D setYSlice:slice]; break;
        case 3: [view3D setZSlice:slice]; break;
    }
}
-(void)displayPolygonization
{
	VOLUME			vol;
	PROCESS			p;
	char			*err;
	int				i,j,k,flag;
	AnalyzeHeader	h;
	float			pix[3];
	float			*verts;
	int				*tris;
	float			o[3]={0,0,0};
	float			scale;
	
	h=*hdr;
	for(i=0;i<3;i++)
		pix[i]=fabs(h.pixdim[i+1]);

	vol.dim=dim;
	vol.pix=pix;
	vol.datatype=1;
	vol.vol=(char*)selection;
	
	flag=0;
	for(i=0;i<dim[0]&&flag==0;i++)
	for(j=0;j<dim[1]&&flag==0;j++)
	for(k=0;k<dim[2]&&flag==0;k++)
		if(selection[k*dim[1]*dim[0]+j*dim[1]+i])
			flag=1;
	//err=polygonize(&p,&vol,2*(pix[0]+pix[1]+pix[2])/3.0,2000,i*pix[0],j*pix[1],k*pix[2],TET);
	scale=2/3.0;
	err=polygonize(&p,&vol,scale*(pix[0]+pix[1]+pix[2]),2000,i*pix[0],j*pix[1],k*pix[2],TET);
	[view3D setPixdim:pix];
	[view3D setScale:scale];

	if(err!=NULL)
	{
		printf("%s\n",err);
		return;
	}
	
	[view3D newMesh:p.vertices.count:p.triangles.count:&verts:&tris:dim];
	for(i=0;i<p.vertices.count;i++)
	{
		o[0]+=verts[3*i+0]=(p.vertices.ptr[i]).position.x;
		o[1]+=verts[3*i+1]=(p.vertices.ptr[i]).position.y;
		o[2]+=verts[3*i+2]=(p.vertices.ptr[i]).position.z;
	}
	o[0]/=(float)p.vertices.count;
	o[1]/=(float)p.vertices.count;
	o[2]/=(float)p.vertices.count;
	for(i=0;i<p.triangles.count;i++)
	{
		tris[3*i+0]=(p.triangles.ptr[i]).i;
		tris[3*i+1]=(p.triangles.ptr[i]).j;
		tris[3*i+2]=(p.triangles.ptr[i]).k;
	}
	freeprocess(p);
	[view3D setOrigin:o];
	[view3D depth];
	[view3D setNeedsDisplay:YES];
}
float dot3D(float3D a,float3D b)
{
    return a.x*b.x+a.y*b.y+a.z*b.z;
}
float3D sub3D(float3D a, float3D b)
{
    return (float3D){a.x-b.x,a.y-b.y,a.z-b.z};
}
float3D add3D(float3D a, float3D b)
{
    return (float3D){a.x+b.x,a.y+b.y,a.z+b.z};
}
float3D sca3D(float3D a, float t)
{
    return (float3D){a.x*t,a.y*t,a.z*t};
}
float3D	cross3D(float3D a, float3D b)
{
    return (float3D){a.y*b.z-a.z*b.y,a.z*b.x-a.x*b.z,a.x*b.y-a.y*b.x};
}
float norm3D(float3D a)
{
    return sqrt(a.x*a.x+a.y*a.y+a.z*a.z);
}
// Akenine-Möller triangle/box intersection, fixed by Nick Pelling
// Code adapted from from http://www.cs.lth.se/home/Tomas_Akenine_Moller/code/
#define FINDMINMAX(x0,x1,x2,min,max)min=max=x0;if(x1<min) min=x1;if(x1>max) max=x1;if(x2<min) min=x2;if(x2>max) max=x2;
int planeBoxOverlap(float *nor,float *vert, float *maxbox)
{
    int		q;
    float	vmin[3],vmax[3];
    
    for(q=0;q<3;q++)
    if(nor[q]>0.0f)
    {
        vmin[q]=-maxbox[q]-vert[q];
        vmax[q]=maxbox[q]-vert[q];
    }
    else
    {
        vmin[q]=maxbox[q]-vert[q];
        vmax[q]=-maxbox[q]-vert[q];
    }
    if(dot3D(*(float3D*)nor,*(float3D*)vmin)>0.0f) return 0;
    if(dot3D(*(float3D*)nor,*(float3D*)vmax)>=0.0f)return 1;
    return 0;
}
#define AXISTEST_X01(a,b,fa,fb)	p0= a*v0.y-b*v0.z;p2= a*v2.y-b*v2.z;if(p0<p2){min=p0;max=p2;}else{min=p2;max=p0;}rad=fa*boxhalfsize.y+fb*boxhalfsize.z;if(min>rad||max<-rad)return 0;
#define AXISTEST_X2(a,b,fa,fb)	p0= a*v0.y-b*v0.z;p1= a*v1.y-b*v1.z;if(p0<p1){min=p0;max=p1;}else{min=p1;max=p0;}rad=fa*boxhalfsize.y+fb*boxhalfsize.z;if(min>rad||max<-rad)return 0;
#define AXISTEST_Y02(a,b,fa,fb)	p0=-a*v0.x+b*v0.z;p2=-a*v2.x+b*v2.z;if(p0<p2){min=p0;max=p2;}else{min=p2;max=p0;}rad=fa*boxhalfsize.x+fb*boxhalfsize.z;if(min>rad||max<-rad)return 0;
#define AXISTEST_Y1(a,b,fa,fb)	p0=-a*v0.x+b*v0.z;p1=-a*v1.x+b*v1.z;if(p0<p1){min=p0;max=p1;}else{min=p1;max=p0;}rad=fa*boxhalfsize.x+fb*boxhalfsize.z;if(min>rad||max<-rad)return 0;
#define AXISTEST_Z12(a,b,fa,fb)	p1= a*v1.x-b*v1.y;p2= a*v2.x-b*v2.y;if(p2<p1){min=p2;max=p1;}else{min=p1;max=p2;}rad=fa*boxhalfsize.x+fb*boxhalfsize.y;if(min>rad||max<-rad)return 0;
#define AXISTEST_Z0(a,b,fa,fb)	p0= a*v0.x-b*v0.y;p1= a*v1.x-b*v1.y;if(p0<p1){min=p0;max=p1;}else{min=p1;max=p0;}rad=fa*boxhalfsize.x+fb*boxhalfsize.y;if(min>rad||max<-rad)return 0;
int triBoxOverlap(float3D boxcenter,int	i,Mesh *mesh)
{
    float3D *p=mesh->p;
    int3D *t=mesh->t;
    float3D	boxhalfsize={0.5,0.5,0.5};
    float3D	v0,v1,v2;
    float	min,max,p0,p1,p2,rad,fex,fey,fez;
    float3D	nor,e0,e1,e2;
    
    v0=sub3D(p[t[i].a],boxcenter);
    v1=sub3D(p[t[i].b],boxcenter);
    v2=sub3D(p[t[i].c],boxcenter);
    
    e0=sub3D(v1,v0);      // tri edge 0
    e1=sub3D(v2,v1);      // tri edge 1
    e2=sub3D(v0,v2);      // tri edge 2
    
    fex = fabs(e0.x);
    fey = fabs(e0.y);
    fez = fabs(e0.z);
    AXISTEST_X01(e0.z, e0.y, fez, fey);
    AXISTEST_Y02(e0.z, e0.x, fez, fex);
    AXISTEST_Z12(e0.y, e0.x, fey, fex);
    
    fex = fabs(e1.x);
    fey = fabs(e1.y);
    fez = fabs(e1.z);
    AXISTEST_X01(e1.z, e1.y, fez, fey);
    AXISTEST_Y02(e1.z, e1.x, fez, fex);
    AXISTEST_Z0(e1.y, e1.x, fey, fex);
    
    fex = fabs(e2.x);
    fey = fabs(e2.y);
    fez = fabs(e2.z);
    AXISTEST_X2(e2.z, e2.y, fez, fey);
    AXISTEST_Y1(e2.z, e2.x, fez, fex);
    AXISTEST_Z12(e2.y, e2.x, fey, fex);
    
    // test in X-direction
    FINDMINMAX(v0.x,v1.x,v2.x,min,max);
    if(min>boxhalfsize.x || max<-boxhalfsize.x) return 0;
    
    // test in Y-direction
    FINDMINMAX(v0.y,v1.y,v2.y,min,max);
    if(min>boxhalfsize.y || max<-boxhalfsize.y) return 0;
    
    // test in Z-direction
    FINDMINMAX(v0.z,v1.z,v2.z,min,max);
    if(min>boxhalfsize.z || max<-boxhalfsize.z) return 0;
    
    nor=cross3D(e0,e1);
    if(!planeBoxOverlap((float*)&nor,(float*)&v0,(float*)&boxhalfsize))
        return 0;
    
    return 1;   // box and triangle overlaps
}
float Min(float x, float y)
{
    return (x<y)?x:y;
}
float Max(float x, float y)
{
    return (x>y)?x:y;
}
-(void)displayMesh
{
    int i,j,k;
    int nt=mesh->nt;
    float3D *p=mesh->p;
    int3D   *t=mesh->t;
    int     *it;
    float3D a,b;
    NSBezierPath    *bp=[NSBezierPath bezierPath];
    float3D v;
    float	s,d,x0,y0,slice=[[[[app settings] content] valueForKey:@"slice"] floatValue];

    float		tmp[3],tmpx[3],dim1[3],pixdim[3];
    float		*P,invP[16];
    NSRect      fr=[self frame];
    
    switch(plane)
    {
        case 1: P=X; break;
        case 2: P=Y; break;
        case 3: P=Z; break;
        default: P=Zero;
    }
    invMat(invP,P);
    
    tmp[0]=dim[0];
    tmp[1]=dim[1];
    tmp[2]=dim[2];
    multMatVec(tmpx,P,tmp);
    dim1[0]=tmpx[0];
    dim1[1]=tmpx[1];
    dim1[2]=tmpx[2];
    
    tmp[0]=hdr->pixdim[1];
    tmp[1]=hdr->pixdim[2];
    tmp[2]=hdr->pixdim[3];
    multMatVec(pixdim,P,tmp);
    
    slice*=pixdim[2];
    for(i=0;i<nt;i++)
    {
        k=0;
        for(j=0;j<3;j++)
        {
            it=(int*)&(t[i]);
            
            a=p[it[j]];
            tmp[0]=a.x;
            tmp[1]=a.y;
            tmp[2]=a.z;
            multMatVec(tmpx, P, tmp);
            a=*(float3D*)tmpx;

            b=p[it[(j+1)%3]];
            tmp[0]=b.x;
            tmp[1]=b.y;
            tmp[2]=b.z;
            multMatVec(tmpx, P, tmp);
            b=*(float3D*)tmpx;
            
            if((a.z-slice)*(b.z-slice)<=0)
            {
                d=a.z-b.z;
                if(fabs(d)<0.000001)
                    continue;
                s=(slice-b.z)/d;
                v=add3D(sca3D(a,s),sca3D(b,1-s));
                x0=(v.x/pixdim[0]+1.5)*fr.size.width/dim1[0];
                y0=fr.size.height*(1-(v.y/pixdim[1]+1)/dim1[1]);
                if(k==0)
                    [bp moveToPoint:(NSPoint){x0,y0}];
                else
                    [bp lineToPoint:(NSPoint){x0,y0}];
                k++;
            }
        }
    }
    [[NSColor yellowColor] set];
    [bp setLineWidth:1];
    [bp stroke];
}
void addToHash(Mesh *m, unsigned int hash, int vertexIndex, int iter)
{
    HashCell    *h=&(m->hash[hash]);
    
    if(h->timeStamp)
    {
        // find a free cell, or add a new one
        while(h->timeStamp==iter)
        {
            if(h->next==NULL)
                h->next=(long*)calloc(1,sizeof(HashCell));
            h=(HashCell*)h->next;
        }
    }
    h->timeStamp=iter;
    h->i=vertexIndex;
}
int distanceToTriangle(Mesh *m, int vertexIndex, int triIndex, float3D *penetration)
{
    float3D *p=m->p;
    int3D   *t=m->t;
    float3D    coords;
    float3D    a,b,x,n;
    
    a=sub3D(p[t[triIndex].b],p[t[triIndex].a]);
    b=sub3D(p[t[triIndex].c],p[t[triIndex].a]);
    x=sub3D(p[vertexIndex],p[t[triIndex].a]);
    
    float d00 = dot3D(a,a);
    float d01 = dot3D(a,b);
    float d11 = dot3D(b,b);
    float d20 = dot3D(x,a);
    float d21 = dot3D(x,b);
    float denom = d00 * d11 - d01 * d01;
    coords.x = (d11 * d20 - d01 * d21) / denom;
    coords.y = (d00 * d21 - d01 * d20) / denom;
    
    n=cross3D(a,b);
    n=sca3D(n,1/norm3D(n));
    coords.z=dot3D(x,n);

    *penetration=coords;
    
    if(coords.x>=0 && coords.y>=0 &&
       coords.x+coords.y<=1 &&
       coords.z<0)
        return 1;
    return 0;
}
int detect_collision(Mesh *m,float3D *p0)
/*
 Collision detection algorithm
 */
{
    int             i,j,k,x,y,z;
    unsigned int    hash;
    float3D         mi,ma,penetration;
    int             np=m->np;
    int             nt=m->nt;
    float3D         *p=m->p;
    int             *t;
    HashCell        *h;
    int             isInTriangle,iter=1;
    
    // 1. assign vertices to hash
    for(i=0;i<np;i++)
    {
        hash=(((unsigned int)floor(p[i].x/m->hashCellSize)*92837111)^((unsigned int)floor(p[i].y/m->hashCellSize)*689287499)^((unsigned int)floor(p[i].z/m->hashCellSize)*283923481))%m->nhash;
        addToHash(m,hash,i,iter);
    }
    
    // 2. detect collision with triangle bounding box
    for(i=0;i<nt;i++)
    {
        // bounding box for t
        t=(int*)&(m->t[i]);
        mi=ma=p[t[0]];
        for(j=0;j<3;j++)
        {
            if(p[t[j]].x<mi.x) mi.x=p[t[j]].x;
            if(p[t[j]].y<mi.y) mi.y=p[t[j]].y;
            if(p[t[j]].z<mi.z) mi.z=p[t[j]].z;
            
            if(p[t[j]].x>ma.x) ma.x=p[t[j]].x;
            if(p[t[j]].y>ma.y) ma.y=p[t[j]].y;
            if(p[t[j]].z>ma.z) ma.z=p[t[j]].z;
        }
        
        // scan bounding box
        for(x=floor(mi.x/m->hashCellSize);x<=floor(ma.x/m->hashCellSize);x++)
        for(y=floor(mi.y/m->hashCellSize);y<=floor(ma.y/m->hashCellSize);y++)
        for(z=floor(mi.z/m->hashCellSize);z<=floor(ma.z/m->hashCellSize);z++)
        {
            hash=((unsigned int)(x*92837111)^(unsigned int)(y*689287499)^(unsigned int)(z*283923481))%m->nhash;
                    
            // check for collision
            h=&(m->hash[hash]);
            while(h->timeStamp)
            {
                if(h->timeStamp==iter)
                {
                    // check if the vertex is not one of the vertices of the triangle we are testing
                    isInTriangle=0;
                    for(k=0;k<3;k++)
                    if(t[k]==h->i)
                    {
                        isInTriangle=1;
                        break;
                    }
                    if(isInTriangle==0)
                    {
                        // 3rd pass: check if vertex traverses
                        if(distanceToTriangle(m,h->i,i,&penetration))
                        if(fabs(penetration.z)<0.2)
                        {
                            printf("MSG: \"Collision detected\"\n");
                            printf("Vertex_index %i\n",h->i);
                            printf("Triangle %i (%i,%i,%i)\n",i,t[0],t[1],t[2]);
                            printf("Penetration %f,%f,%f\n",penetration.x,penetration.y,penetration.z);
                            if(1)
                            {
                                p[h->i]=p0[h->i];
                                /* if collision response is active, add collision response to external forces */
                                
                                /*
                                float3D    target,force;
                                 float3D    a,b,c;
                                 double      k=1000;  // collision elasticity
                                 m->fext[h->i]=add3D(m->fext[h->i],sca3D(sub3D(prev,m->p[h->i]),k));
                                 a=sub3D(m->p[m->t[i].p[1]],m->p[m->t[i].p[0]]);
                                 b=sub3D(m->p[m->t[i].p[2]],m->p[m->t[i].p[0]]);
                                 c=sub3D(m->p[m->t[i].p[3]],m->p[m->t[i].p[0]]);
                                 // there are 3 types of tetrahedron:
                                 switch(i%3)
                                 {
                                     case 0: // t[3*i+0]={b1,a1,c0,c1}
                                     target=m->p[m->t[i].p[3]];
                                     m->fext[m->t[i].p[0]]=add3D(m->fext[m->t[i].p[0]],sca3D(sub3D(prev,m->p[h->i]),k*(b.x+b.y+b.z)));
                                     m->fext[m->t[i].p[1]]=add3D(m->fext[m->t[i].p[1]],sca3D(sub3D(prev,m->p[h->i]),-k*b.x));
                                     m->fext[m->t[i].p[3]]=add3D(m->fext[m->t[i].p[3]],sca3D(sub3D(prev,m->p[h->i]),-k*b.z));
                                     break;
                                     case 1: // t[3*i+1]={c0,b1,a0,a1}
                                     target=m->p[m->t[i].p[3]];
                                     break;
                                     case 2: // t[3*i+2]={a0,c0,b0,b1}
                                     target=m->p[m->t[i].p[3]];
                                     force=sca3D(sub3D(target,m->p[h->i]),k);
                                     m->fext[h->i]=add3D(m->fext[h->i],force);
                                     m->fext[m->t[i].p[3]]=sub3D(m->fext[m->t[i].p[3]],force);
                                     break;
                                 }
                                 */
                            }
                            else
                            {
                            /* else, just return */
                                //return 1;
                            }
                        }
                    }
                }
                if(h->next)
                    h=(HashCell*)h->next;
                else
                    break;
            }
        }
    }
    
    return 0;
}
#pragma mark -
-(void)setApp:(id)theApp
{
	app=theApp;
}
-(void)displayMessage:(NSString *)msg
{
	NSDictionary	*dic;
	dic=[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"\n%@\n",msg] forKey:@"string"];
	[[NSNotificationCenter defaultCenter]	postNotificationName:@"MyPrintString"
														object:self
													  userInfo:dic];
}
#pragma mark -
-(void)abs
{
	int	i,j,k;
	float	val;
	for(i=0;i<dim[0];i++)
    for(j=0;j<dim[1];j++)
    for(k=0;k<dim[2];k++)
    {
        val=[self getValueAt:i:j:k];
        val=fabs(val);
        [self setValue:val at:i:j:k];
    }
	[self configureMinMax];
}
-(void)addConstant:(float)x
{
	int	i,j,k;
	float	val;
	for(i=0;i<dim[0];i++)
		for(j=0;j<dim[1];j++)
			for(k=0;k<dim[2];k++)
			{
				val=[self getValueAt:i:j:k];
				val=val+x;
				[self setValue:val at:i:j:k];
			}
	[self configureMinMax];
}
-(void)addSelection:(char*)path
{
	char			*addr;
	int				sz;
	AnalyzeHeader	*newhdr;
	char			*img;
	int				i,j,k;
	int				swapped;

	Analyze_load((char*)path, &addr,&sz,&swapped);
	newhdr=(AnalyzeHeader*)addr;
	img=addr+sizeof(AnalyzeHeader);
	
	if(newhdr->dim[1]!=dim[0] || newhdr->dim[2]!=dim[1] || newhdr->dim[3]!=dim[2])
	{
		printf("WARNING: Dimensions do not match.\n");
	}
	
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
    if(i<newhdr->dim[1] && j<newhdr->dim[2] && k<newhdr->dim[3])
    {
		if(getValue(newhdr,img,i,j,k) && (selection[k*dim[1]*dim[0]+j*dim[0]+i]==0))
			selection[k*dim[1]*dim[0]+j*dim[0]+i]=sindex;
    }
	sindex++;
	free(addr);
}
-(void)adjustMinMax
{
	int		i;
  float	val;
  double  s,ss,std,tmpmin,tmpmax;
    
	s=ss=0;
  for(i=0;i<dim[0]*dim[1]*dim[2];i++)
	{
    val=0;
    if(dataType==RGBFLOAT)
		{
			val=((float3D*)data)[i].x;
			if(i==0) min=max=val;
			if(min>val) min=val;
			if(max<val) max=val;
			val=((float3D*)data)[i].y;
			if(min>val) min=val;
			if(max<val) max=val;
			val=((float3D*)data)[i].z;
			if(min>val) min=val;
			if(max<val) max=val;
		}
		else
		{
			switch(dataType){
        case UCHAR:     val=((unsigned char*)data)[i];  break;
        case DT_INT8:   val=((char*)data)[i];           break;
        case SHORT:     val=((short*)data)[i];          break;
        case DT_UINT16: val=((unsigned short*)data)[i]; break;
        case INT:       val=((int*)data)[i];            break;
        case DT_UINT32: val=((unsigned int*)data)[i];   break;
				case FLOAT:	    val=((float*)data)[i];			    break;
			}
      if(isnan(val)||isinf(val))
          continue;
			if(i==0) min=max=val;
			if(min>val) min=val;
			if(max<val) max=val;
		}
    s+=val;
    ss+=val*val;
	}
  s/=(float)(dim[0]*dim[1]*dim[2]);
  std=sqrt(ss/(float)(dim[0]*dim[1]*dim[2])-pow(s,2));

  //  tmpmin=s-3*std;
  //  tmpmax=s+3*std;
  //  min=(tmpmin<min)?min:tmpmin;
  //  max=(tmpmax>max)?max:tmpmax;

  printf("[mean,std,min,max]=(%f,%f,%f,%f)\n",s,std,min,max);
}
-(void)applyRotation
{
	
	char			*volRotated;
	char			*addr;
	short			*selRotated;
	float			x,y,z,x1,y1,z1,volRot[16],tmp[3],tmpx[3],val;
	int				err;
	AnalyzeHeader	h;
	
	h=*hdr;
	volRotated=calloc(dim[0]*dim[1]*dim[2],AnalyzeBytesPerVoxel(h));
	selRotated=calloc(dim[0]*dim[1]*dim[2],sizeof(short));
		
	angles2rotation(volRotation[0],volRotation[1],volRotation[2],volRot);
	
	for(x=0;x<dim[0];x++)
	for(y=0;y<dim[1];y++)
	for(z=0;z<dim[2];z++)
	{
		tmp[0]=x-dim[0]/2.0;
		tmp[1]=y-dim[1]/2.0;
		tmp[2]=z-dim[2]/2.0;
		multMatVec(tmpx,volRot,tmp);
		x1=tmpx[0]+dim[0]/2.0;
		y1=tmpx[1]+dim[1]/2.0;
		z1=tmpx[2]+dim[2]/2.0;
		
		if(x1>=0&&x1<dim[0]&&y1>=0&&y1<dim[1]&&z1>=0&&z1<dim[2])
		{
			val=[self getScaledTrilinear1:x1:y1:z1:&err];
			[self setValue:val at:x:y:z volume:volRotated];
			selRotated[(int)z*dim[1]*dim[0]+(int)y*dim[0]+(int)x]=roundf([self getScaledSelectionTrilinear1:x1:y1:z1]);
		}
	}
	selection=selRotated;
	
	volRotation[0]=0;
	volRotation[1]=0;
	volRotation[2]=0;	
	
	// put hdr and img in a single ptr
	addr=(char*)calloc(sizeof(AnalyzeHeader)+dim[0]*dim[1]*dim[2]*AnalyzeBytesPerVoxel(h),1);
	*(AnalyzeHeader*)addr=h;
	memcpy(addr+sizeof(AnalyzeHeader),volRotated,dim[0]*dim[1]*dim[2]*AnalyzeBytesPerVoxel(h));
	free(volRotated);
	
	// update data in view
	[self configureData:addr];
	[self configureMinMax];
	
	// update data in document
	[app configureInterface];
}	
-(void)boundingBox
{
    int   mn[3],mx[3];
    int   i,j,k;
    
    mn[0]=dim[0];
    mn[1]=dim[1];
    mn[2]=dim[2];
    mx[0]=mx[1]=mx[2]=0;
    
    for(i=0;i<dim[0];i++)
    for(j=0;j<dim[1];j++)
    for(k=0;k<dim[2];k++)
    {
        if(selection[k*dim[1]*dim[0]+j*dim[0]+i])
        {
            if(i<mn[0]) mn[0]=i;
            if(j<mn[1]) mn[1]=j;
            if(k<mn[2]) mn[2]=k;

            if(i>mx[0]) mx[0]=i;
            if(j>mx[1]) mx[1]=j;
            if(k>mx[2]) mx[2]=k;
        }
    }
    [self box:mn[0]:mn[1]:mn[2]:mx[0]:mx[1]:mx[2]];
}
-(void)box:(int)a :(int)b :(int)c :(int)d :(int)e :(int)f
{
	int	i,j,k;
	
	for(i=a;i<=d;i++)
	for(j=b;j<=e;j++)
	for(k=c;k<=f;k++)
	if(i>=0&&i<dim[0] && j>=0&&j<dim[1] && k>=0&&k<dim[2])
		selection[k*dim[1]*dim[0]+j*dim[0]+i]=sindex;
	sindex++;
}
-(void)boxFilter:(int)radius :(int)iter
{
	int	i;
	for(i=0;i<iter;i++)
		[self boxFilter1:radius];
}
-(void)boxFilter1:(int)r
{
	int		i,j,k;
	float	sum,val;
	float	*tmpx=(float*)calloc(dim[0]*dim[1]*dim[2],sizeof(float));
	float	*tmpy=(float*)calloc(dim[0]*dim[1]*dim[2],sizeof(float));
	float	*tmpz=(float*)calloc(dim[0]*dim[1]*dim[2],sizeof(float));
	
	// x direction
	for(k=0;k<dim[2];k++)
	for(j=0;j<dim[1];j++)
	{
		sum=0;
		for(i=0;i<r;i++)
			sum+=[self getValueAt:i:j:k];
		for(i=0;i<=r;i++)
		{
			sum+=[self getValueAt:i+r:j:k];
			val=sum/(double)(r+1+i);
			tmpx[k*dim[1]*dim[0]+j*dim[0]+i]=val;
		}
		for(i=r+1;i<dim[0]-r;i++)
		{
			sum+=[self getValueAt:i+r:j:k];
			sum-=[self getValueAt:i-r-1:j:k];
			val=sum/(double)(2*r+1);
			tmpx[k*dim[1]*dim[0]+j*dim[0]+i]=val;
		}
		for(i=dim[0]-r;i<dim[0];i++)
		{
			sum-=[self getValueAt:i-r-1:j:k];
			val=sum/(double)(r+(dim[0]-i));
			tmpx[k*dim[1]*dim[0]+j*dim[0]+i]=val;
		}
	}
	// y direction
	for(k=0;k<dim[2];k++)
	for(i=0;i<dim[0];i++)
	{
		sum=0;
		for(j=0;j<r;j++)
			sum+=tmpx[k*dim[1]*dim[0]+j*dim[0]+i];
		for(j=0;j<=r;j++)
		{
			sum+=tmpx[k*dim[1]*dim[0]+(j+r)*dim[0]+i];
			val=sum/(double)(r+1+j);
			tmpy[k*dim[1]*dim[0]+j*dim[0]+i]=val;
		}
		for(j=r+1;j<dim[1]-r;j++)
		{
			sum+=tmpx[k*dim[1]*dim[0]+(j+r)*dim[0]+i];
			sum-=tmpx[k*dim[1]*dim[0]+(j-r-1)*dim[0]+i];
			val=sum/(double)(2*r+1);
			tmpy[k*dim[1]*dim[0]+j*dim[0]+i]=val;
		}
		for(j=dim[1]-r;j<dim[1];j++)
		{
			sum-=tmpx[k*dim[1]*dim[0]+(j-r-1)*dim[0]+i];
			val=sum/(double)(r+(dim[1]-j));
			tmpy[k*dim[1]*dim[0]+j*dim[0]+i]=val;
		}
	}

	// z direction
	for(j=0;j<dim[1];j++)
	for(i=0;i<dim[0];i++)
	{
		sum=0;
		for(k=0;k<r;k++)
			sum+=tmpy[k*dim[1]*dim[0]+j*dim[0]+i];
		for(k=0;k<=r;k++)
		{
			sum+=tmpy[(k+r)*dim[1]*dim[0]+j*dim[0]+i];
			val=sum/(double)(r+1+k);
			tmpz[k*dim[1]*dim[0]+j*dim[0]+i]=val;
		}
		for(k=r+1;k<dim[2]-r;k++)
		{
			sum+=tmpy[(k+r)*dim[1]*dim[0]+j*dim[0]+i];
			sum-=tmpy[(k-r-1)*dim[1]*dim[0]+j*dim[0]+i];
			val=sum/(double)(2*r+1);
			tmpz[k*dim[1]*dim[0]+j*dim[0]+i]=val;
		}
		for(k=dim[2]-r;k<dim[2];k++)
		{
			sum-=tmpy[(k-r-1)*dim[1]*dim[0]+j*dim[0]+i];
			val=sum/(double)(r+(dim[2]-k));
			tmpz[k*dim[1]*dim[0]+j*dim[0]+i]=val;
		}
	}

	for(k=0;k<dim[2];k++)
	for(j=0;j<dim[1];j++)
	for(i=0;i<dim[0];i++)
		[self setValue:(float)tmpz[k*dim[1]*dim[0]+j*dim[0]+i] at:i:j:k];

	free(tmpx);
	free(tmpy);
	free(tmpz);
}
-(void)changePixdim:(float)d0 :(float)d1 :(float)d2
{
    hdr->pixdim[1]=d0;
    hdr->pixdim[2]=d1;
    hdr->pixdim[3]=d2;
}
-(void)colormap:(char*)str
{
	if(strcmp(str,"autumn")==0)
		cmap=AUTUMN;
	else
	if(strcmp(str,"bone")==0)
		cmap=BONE;
	else
	if(strcmp(str,"winter")==0)
		cmap=WINTER;
	else
	if(strcmp(str,"hot")==0)
		cmap=HOT;
	else
	if(strcmp(str,"water")==0)
		cmap=WATER;
	else
	if(strcmp(str,"solidred")==0)
		cmap=SOLIDRED;
	else
	if(strcmp(str,"solidrgb")==0)
		cmap=SOLIDRGB;
	else
	if(strcmp(str,"jet")==0)
		cmap=JET;
	else
	if(strcmp(str,"jetgb")==0)
		cmap=JETGB;
	else
	if(strcmp(str,"negpos")==0)
		cmap=NEGPOS;
	else
	if(strcmp(str,"gray")==0)
		cmap=GRAY;
	else
		printf("ERROR: Unknown colormap '%s'\n",str);
}
-(void)commands
{
	printf("> list of available commands\n");
	NSArray			*cmds=[app cmds],*args;
	NSMutableString	*str=[NSMutableString new];
	int				i,j;
	
	[str appendString:@"\n"];
	for(i=0;i<[cmds count];i++)
	{
		[str appendString:[[cmds objectAtIndex:i] objectForKey:@"cmd"]];
		[str appendString:@"("];
		args=[[cmds objectAtIndex:i] objectForKey:@"args"];
		for(j=0;j<[args count];j++)
		{
			[str appendString:[args objectAtIndex:j]];
			if(j<[args count]-1)
				[str appendString:@","];
		}
		[str appendString:@")\n"];
	}
	
	[self displayMessage:str];
	[str release];
}
-(void)connectedSelection:(int)x :(int)y :(int)z;
{
	printf("> connected selection\n");
	int		n,k;
	int		dx,dy,dz;
	int		dire[6]={0,0,0,0,0,0};
	int		nstack=0;
	short	stack[STACK][3];
	char	dstack[STACK];
	int		empty,mark;
	char	*tmp;

	tmp=(char*)calloc(dim[0]*dim[1]*dim[2],sizeof(char));

	n=0;
	for(;;)
	{
		tmp[z*dim[1]*dim[0]+y*dim[0]+x]=1;
		n++;
		
		for(k=0;k<6;k++)
		{
			dx = (-1)*(	k==3 ) + ( 1)*( k==1 );
			dy = (-1)*( k==2 ) + ( 1)*( k==0 );
			dz = (-1)*( k==5 ) + ( 1)*( k==4 );

			if(	z+dz>=0 && z+dz<dim[2] &&
				y+dy>=0 && y+dy<dim[1] &&
				x+dx>=0 && x+dx<dim[0] )
			{
				empty=(selection[(z+dz)*dim[1]*dim[0]+(y+dy)*dim[0]+(x+dx)]>0);
				mark = tmp[(z+dz)*dim[1]*dim[0]+(y+dy)*dim[0]+(x+dx)];
				if( empty && !mark && !dire[k])
				{
					dire[k] = 1;
					dstack[nstack] = k+1;
					stack[nstack][0]=x+dx;
					stack[nstack][1]=y+dy;
					stack[nstack][2]=z+dz;
					nstack++;
				}
				else
					if( dire[k] && !empty && !mark)
						dire[k] = 0;
			}
		}
		if(nstack>STACK-10)
		{
			printf("StackOverflow\n");
			break;
		}
		if(nstack)
		{
			nstack--;
			x = stack[nstack][0];
			y = stack[nstack][1];
			z = stack[nstack][2];
			for(k=0;k<6;k++)
				dire[k] = (dstack[nstack]==(k+1))?0:dire[k];
		}
		else
			break;
	}
	
	for(k=0;k<dim[0]*dim[1]*dim[2];k++)
	if(tmp[k]>0)
		selection[k]=sindex;
	else
		selection[k]=0;
	sindex++;
	free(tmp);
	
	printf("%i voxels selected\n",n);
}
-(void)convertToMovie:(char*)path
{
    /*
	NSString	*filePath=[NSString stringWithUTF8String:path];
	NSError		*error = nil;
	QTMovie		*mMovie = [[QTMovie alloc] initToWritableData:[NSMutableData data] error:&error];

	[mMovie setAttribute:[NSNumber numberWithBool:YES] forKey:QTMovieEditableAttribute];

	// add all the images to our movie as MPEG-4 frames
	long long timeValue = 30;
	long timeScale      = 600;
	QTTime duration     = QTMakeTime(timeValue, timeScale);
	NSDictionary *myDict = [NSDictionary dictionaryWithObjectsAndKeys:@"mp4v",QTAddImageCodecType,
												[NSNumber numberWithLong:codecHighQuality],QTAddImageCodecQuality,
												nil];
	int i,nslices=(hdr->dim)[plane]-1;
	int	slice0=[self slice];
	for (i=0;i<nslices;i++)
	{
		[self setSlice:i];
		[self redraw];
		
		// flip vertically
		
		[mMovie addImage:image 
				forDuration:duration
				withAttributes:myDict];
		[mMovie setCurrentTime:[mMovie duration]];
	}
	[self setSlice:slice0];

	// save to path
	i=[mMovie writeToFile:filePath withAttributes:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:QTMovieFlatten] error:&error];

	[mMovie release];
     */
}
-(void)crop
{
    int   mn[3],mx[3];
    int   i,j,k;
    
    mn[0]=dim[0];
    mn[1]=dim[1];
    mn[2]=dim[2];
    mx[0]=mx[1]=mx[2]=0;
    for(i=0;i<dim[0];i++)
    for(j=0;j<dim[1];j++)
    for(k=0;k<dim[2];k++)
    {
        if(selection[k*dim[1]*dim[0]+j*dim[0]+i])
        {
            if(i<mn[0]) mn[0]=i;
            if(j<mn[1]) mn[1]=j;
            if(k<mn[2]) mn[2]=k;
            
            if(i>mx[0]) mx[0]=i;
            if(j>mx[1]) mx[1]=j;
            if(k>mx[2]) mx[2]=k;
        }
    }

    char			*volResized;
    short			*selResized;
    char			*addr;
    short			newdim[4]={0,0,0,1};
    int				x,y,z;	// original and target coordinates
    AnalyzeHeader	h;
    
    h=*hdr;
    x=newdim[0]=mx[0]-mn[0]+1;
    y=newdim[1]=mx[1]-mn[1]+1;
    z=newdim[2]=mx[2]-mn[2]+1;
    
    volResized=calloc(x*y*z,AnalyzeBytesPerVoxel(h));
    // resize volume
    for(i=0;i<x;i++)
    for(j=0;j<y;j++)
    for(k=0;k<z;k++)
    {
        switch(dataType)
        {
            case UCHAR:
                ((unsigned char*)volResized)[k*y*x+j*x+i]=((unsigned char*)data)[(k+mn[2])*dim[1]*dim[0]+(j+mn[1])*dim[0]+(i+mn[0])];
                break;
            case DT_INT8:
                ((char*)volResized)[k*y*x+j*x+i]=((char*)data)[(k+mn[2])*dim[1]*dim[0]+(j+mn[1])*dim[0]+(i+mn[0])];
                break;
            case SHORT:
                ((short*)volResized)[k*y*x+j*x+i]=((short*)data)[(k+mn[2])*dim[1]*dim[0]+(j+mn[1])*dim[0]+(i+mn[0])];
                break;
            case DT_UINT16:
                ((unsigned short*)volResized)[k*y*x+j*x+i]=((unsigned short*)data)[(k+mn[2])*dim[1]*dim[0]+(j+mn[1])*dim[0]+(i+mn[0])];
                break;
            case INT:
                ((int*)volResized)[k*y*x+j*x+i]=((int*)data)[(k+mn[2])*dim[1]*dim[0]+(j+mn[1])*dim[0]+(i+mn[0])];
                break;
            case DT_UINT32:
                ((unsigned int*)volResized)[k*y*x+j*x+i]=((unsigned int*)data)[(k+mn[2])*dim[1]*dim[0]+(j+mn[1])*dim[0]+(i+mn[0])];
                break;
            case FLOAT:
                ((float*)volResized)[k*y*x+j*x+i]=((float*)data)[(k+mn[2])*dim[1]*dim[0]+(j+mn[1])*dim[0]+(i+mn[0])];
                break;
        }
    }
    //	for(i=0;i<x*y*z*AnalyzeBytesPerVoxel(h);i++)
    //		volResized[i]=data[i];
    
    // resize selection
    selResized=calloc(x*y*z,sizeof(short));
    for(i=0;i<x;i++)
    for(j=0;j<y;j++)
    for(k=0;k<z;k++)
            selResized[k*y*x+j*x+i]=selection[(k+mn[2])*dim[1]*dim[0]+(j+mn[1])*dim[0]+(i+mn[0])];
    free(selection);
    selection=selResized;
    
    // make new header
    h.dim[0]=4;
    h.dim[1]=x;
    h.dim[2]=y;
    h.dim[3]=z;
    h.dim[4]=1;
    
    // put hdr and img in a single ptr
    addr=(char*)calloc(sizeof(AnalyzeHeader)+x*y*z*AnalyzeBytesPerVoxel(h),1);
    *(AnalyzeHeader*)addr=h;
    memcpy(addr+sizeof(AnalyzeHeader),volResized,x*y*z*AnalyzeBytesPerVoxel(h));
    free(volResized);
    
    // update data in view
    [self configureData:addr];
    [self configureMinMax];
    
    // update data in document
    [app configureInterface];
}
void dct_1d(float *in, float *out, int N)
{
	int n,k;
    
	for(k=0;k<N;k++)
	{
		float z=0;
		for(n=0;n<N;n++)
			z+=in[n]*cos(pi*(2*n+1)*k/(float)(2*N));
		out[k]=z*((k==0)?1/sqrt(N):sqrt(2/(float)N));
	}
}
void idct_1d(float *in, float *out, int N)
{
	int n,k;
    
	for(n=0;n<N;n++)
	{
		float z=0;
		for(k=0;k<N;k++)
			z+=((k==0)?1/sqrt(N):sqrt(2/(float)N))*in[k]*cos(pi*(2*n+1)*k/(float)(2*N));
		out[n]=z;
	}
}
void dct_xyz(float *vol,float *coeff,int *dim8)
{
	int i,j,k;
	float *in,*out;
    int max;
    
    max=(dim8[0]>dim8[1])?dim8[0]:dim8[1];
    max=(dim8[2]>max)?dim8[2]:max;
    in=(float*)calloc(max,sizeof(float));
    out=(float*)calloc(max,sizeof(float));
	
    for(i=0;i<dim8[0];i++)
        for(j=0;j<dim8[1];j++)
        {
            for(k=0;k<dim8[2];k++)
                in[k]=vol[k*dim8[1]*dim8[0]+j*dim8[0]+i];
            dct_1d(in,out,dim8[2]);
            for(k=0;k<dim8[2];k++)
                coeff[k*dim8[1]*dim8[0]+j*dim8[0]+i]=out[k];
        }
    
	for(j=0;j<dim8[1];j++)
        for(k=0;k<dim8[2];k++)
        {
            for(i=0;i<dim8[0];i++)
                in[i]=coeff[k*dim8[1]*dim8[0]+j*dim8[0]+i];
            dct_1d(in,out,dim8[0]);
            for(i=0;i<dim8[0];i++)
                coeff[k*dim8[1]*dim8[0]+j*dim8[0]+i]=out[i];
        }
    
	for(k=0;k<dim8[2];k++)
        for(i=0;i<dim8[0];i++)
        {
            for(j=0;j<dim8[1];j++)
                in[j]=coeff[k*dim8[1]*dim8[0]+j*dim8[0]+i];
            dct_1d(in, out,dim8[1]);
            for(j=0;j<dim8[1];j++)
                coeff[k*dim8[1]*dim8[0]+j*dim8[0]+i]=out[j];
        }
    
    free(in);
    free(out);
}
void idct_xyz(float *vol,float *coeff,int *dim8)
{
	int i,j,k;
	float *in,*out;
    int max;
    
    max=(dim8[0]>dim8[1])?dim8[0]:dim8[1];
    max=(dim8[2]>max)?dim8[2]:max;
    in=(float*)calloc(max,sizeof(float));
    out=(float*)calloc(max,sizeof(float));
	
	for(i=0;i<dim8[0];i++)
        for(j=0;j<dim8[1];j++)
        {
            for(k=0;k<dim8[2];k++)
                in[k]=vol[k*dim8[1]*dim8[0]+j*dim8[0]+i];
            idct_1d(in, out,dim8[2]);
            for(k=0;k<dim8[2];k++)
                coeff[k*dim8[1]*dim8[0]+j*dim8[0]+i]=out[k];
        }
    
	for(j=0;j<dim8[1];j++)
        for(k=0;k<dim8[2];k++)
        {
            for(i=0;i<dim8[0];i++)
                in[i]=coeff[k*dim8[1]*dim8[0]+j*dim8[0]+i];
            idct_1d(in, out,dim8[0]);
            for(i=0;i<dim8[0];i++)
                coeff[k*dim8[1]*dim8[0]+j*dim8[0]+i]=out[i];
        }
    
	for(k=0;k<dim8[2];k++)
        for(i=0;i<dim8[0];i++)
        {
            for(j=0;j<dim8[1];j++)
                in[j]=coeff[k*dim8[1]*dim8[0]+j*dim8[0]+i];
            idct_1d(in, out,dim8[1]);
            for(j=0;j<dim8[1];j++)
                coeff[k*dim8[1]*dim8[0]+j*dim8[0]+i]=out[j];
        }
    
    free(in);
    free(out);
}
-(void)dct
{
	float	*tmp,*coeff;
	int		i,j,k;
    
	tmp=(float*)calloc(dim[0]*dim[1]*dim[2],sizeof(float));
	coeff=(float*)calloc(dim[0]*dim[1]*dim[2],sizeof(float));
	for(i=0;i<dim[0];i++)
        for(j=0;j<dim[1];j++)
            for(k=0;k<dim[2];k++)
                tmp[k*dim[1]*dim[0]+j*dim[0]+i]=[self getValueAt:i:j:k];
    
	// dct
	dct_xyz(tmp,coeff,dim);
	
	// change volume to compressed version
	for(i=0;i<dim[0];i++)
        for(j=0;j<dim[1];j++)
            for(k=0;k<dim[2];k++)
                [self setValue:coeff[k*dim[1]*dim[0]+j*dim[0]+i] at:i:j:k];
	
	free(tmp);
    free(coeff);
	[self configureMinMax];
}
-(void)idct
{
	float	*tmp,*coeff;
	int		i,j,k;
    
	tmp=(float*)calloc(dim[0]*dim[1]*dim[2],sizeof(float));
	coeff=(float*)calloc(dim[0]*dim[1]*dim[2],sizeof(float));
	for(i=0;i<dim[0];i++)
        for(j=0;j<dim[1];j++)
            for(k=0;k<dim[2];k++)
                tmp[k*dim[1]*dim[0]+j*dim[0]+i]=[self getValueAt:i:j:k];
    
	// idct
	idct_xyz(tmp,coeff,dim);
	
	for(i=0;i<dim[0];i++)
        for(j=0;j<dim[1];j++)
            for(k=0;k<dim[2];k++)
                [self setValue:coeff[k*dim[1]*dim[0]+j*dim[0]+i] at:i:j:k];
	
	free(tmp);
    free(coeff);
	[self configureMinMax];
}
-(void)deselect
{
	printf("> deselect\n");
	int		i;
	
	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
		selection[i]=0;
	sindex=1;
}
-(void)dilate:(int)r
{
	printf("> dilate\n");
	int		i,j,k;
	int		a,b,c;
	char	*tmp=calloc(dim[0]*dim[1]*dim[2],1);
	
	for(i=0;i<dim[0]*dim[1]*dim[2];i++) tmp[i]=selection[i];

	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	if(selection[k*dim[1]*dim[0]+j*dim[0]+i]>0)
	{
		for(a=-r;a<=r;a++)
		for(b=-r;b<=r;b++)
		for(c=-r;c<=r;c++)
		if(	i+a>=0 && i+a<dim[0] &&
			j+b>=0 && j+b<dim[1] &&
			k+c>=0 && k+c<dim[2])
		if(a*a+b*b+c*c<=r*r)
		if(selection[(k+c)*dim[1]*dim[0]+(j+b)*dim[0]+(i+a)]==0)
			tmp[(k+c)*dim[1]*dim[0]+(j+b)*dim[0]+(i+a)]=1;
	}

	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
	if(selection[i]==0 && tmp[i]>0)
		selection[i]=sindex;
	sindex++;
	free(tmp);
}
-(void)erode:(int)r
{
	printf("> erode\n");
	int		i,j,k;
	int		a,b,c;
	char	*tmp=calloc(dim[0]*dim[1]*dim[2],1);
	int		flag;
	
	for(i=0;i<dim[0]*dim[1]*dim[2];i++) tmp[i]=selection[i];

	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	if(selection[k*dim[1]*dim[0]+j*dim[0]+i]==0)
	{
		flag=0;
		for(a=-1;a<=1;a++)
		for(b=-1;b<=1;b++)
		for(c=-1;c<=1;c++)
		if(	i+a>=0 && i+a<dim[0] &&
		   j+b>=0 && j+b<dim[1] &&
		   k+c>=0 && k+c<dim[2])
				if(selection[(k+c)*dim[1]*dim[0]+(j+b)*dim[0]+(i+a)]>0)
				{
					flag=1;
					break;
				}
		if(flag)
		{
			for(a=-r;a<=r;a++)
			for(b=-r;b<=r;b++)
			for(c=-r;c<=r;c++)
			if(	i+a>=0 && i+a<dim[0] &&
			   j+b>=0 && j+b<dim[1] &&
			   k+c>=0 && k+c<dim[2])
				if(a*a+b*b+c*c<=r*r)
				if(selection[(k+c)*dim[1]*dim[0]+(j+b)*dim[0]+(i+a)]>0)
					tmp[(k+c)*dim[1]*dim[0]+(j+b)*dim[0]+(i+a)]=0;
		}
	}

	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
	if(selection[i]>0 && tmp[i]==0)
		selection[i]=0;
	free(tmp);
}
-(void)euler
{
	[self displayMessage:[NSString stringWithFormat:@"X=%i",euler(selection,dim)]];
}
-(void)fill:(int)x :(int)y :(int)z :(char*)aPlane
{
	printf("> fill\n");
	int		n,k;
	int		dx,dy,dz;
	int		dire[4]={0,0,0,0};
	int		nstack=0;
	short	stack[STACK][2];
	char	dstack[STACK];
	int		empty,mark;
	char	*tmp;
	
	tmp=(char*)calloc(dim[0]*dim[1],sizeof(char));
	
	x=x;
	y=y;
	z=z;
	dz=0;
	
	n=0;
	for(;;)
	{
		tmp[y*dim[0]+x]=1;
		n++;
		
		for(k=0;k<4;k++)
		{
			dx = (-1)*(	k==3 ) + ( 1)*( k==1 );
			dy = (-1)*( k==2 ) + ( 1)*( k==0 );
			
			if(y+dy>=0 && y+dy<dim[1] &&
			   x+dx>=0 && x+dx<dim[0] )
			{
				empty=(selection[(z+dz)*dim[1]*dim[0]+(y+dy)*dim[0]+(x+dx)]==0);
				mark = tmp[(y+dy)*dim[0]+(x+dx)];
				if( empty && !mark && !dire[k])
				{
					dire[k] = 1;
					dstack[nstack] = k+1;
					stack[nstack][0]=x+dx;
					stack[nstack][1]=y+dy;
					nstack++;
				}
				else
					if( dire[k] && !empty && !mark)
						dire[k] = 0;
			}
		}
		if(nstack>STACK-10)
		{
			printf("StackOverflow\n");
			break;
		}
		if(nstack)
		{
			nstack--;
			x = stack[nstack][0];
			y = stack[nstack][1];
			for(k=0;k<4;k++)
				dire[k] = (dstack[nstack]==(k+1))?0:dire[k];
		}
		else
			break;
	}
	
	for(k=0;k<dim[1]*dim[0];k++)
	if(tmp[k]>0)
		selection[z*dim[1]*dim[0]+k]=sindex;
	sindex++;
	free(tmp);
}
-(void)flip:(char*)d
{
    printf("> flip\n");
    int		i,j,k;
    float   v;
    short   s;
    
    switch(d[0])
    {
        case 'x':
            for(i=0;i<dim[0]/2;i++)
            for(j=0;j<dim[1];j++)
            for(k=0;k<dim[2];k++)
            {
                v=[self getValueAt:i:j:k];
                [self setValue:[self getValueAt:(dim[0]-i-1):j:k] at:i:j:k];
                [self setValue:v at:(dim[0]-i-1):j:k];
                
                s=selection[k*dim[1]*dim[0]+j*dim[0]+i];
                selection[k*dim[1]*dim[0]+j*dim[0]+i]=selection[k*dim[1]*dim[0]+j*dim[0]+(dim[0]-i-1)];
                selection[k*dim[1]*dim[0]+j*dim[0]+(dim[0]-i-1)]=s;
            }
            break;
        case 'y':
            for(i=0;i<dim[0];i++)
            for(j=0;j<dim[1]/2;j++)
            for(k=0;k<dim[2];k++)
            {
                v=[self getValueAt:i:j:k];
                [self setValue:[self getValueAt:i:(dim[1]-j-1):k] at:i:j:k];
                [self setValue:v at:i:(dim[1]-j-1):k];

                s=selection[k*dim[1]*dim[0]+j*dim[0]+i];
                selection[k*dim[1]*dim[0]+j*dim[0]+i]=selection[k*dim[1]*dim[0]+(dim[1]-j-1)*dim[0]+i];
                selection[k*dim[1]*dim[0]+(dim[1]-j-1)*dim[0]+i]=s;
            }
            break;
        case 'z':
            for(i=0;i<dim[0];i++)
            for(j=0;j<dim[1];j++)
            for(k=0;k<dim[2]/2;k++)
            {
                v=[self getValueAt:i:j:k];
                [self setValue:[self getValueAt:i:j:(dim[2]-k-1)] at:i:j:k];
                [self setValue:v at:i:j:(dim[2]-k-1)];

                s=selection[k*dim[1]*dim[0]+j*dim[0]+i];
                selection[k*dim[1]*dim[0]+j*dim[0]+i]=selection[(dim[2]-k-1)*dim[1]*dim[0]+j*dim[0]+i];
                selection[(dim[2]-k-1)*dim[1]*dim[0]+j*dim[0]+i]=s;
            }
            break;
    }
}
-(void)flipMesh:(char*)d
{
    float world_dim[3];
    int   i;
    float np=mesh->np;
    float3D *p=mesh->p;
    
    world_dim[0]=dim[0]*hdr->pixdim[1];
    world_dim[1]=dim[1]*hdr->pixdim[2];
    world_dim[2]=dim[2]*hdr->pixdim[3];
    
    switch((int)d[0])
    {
        case (int)'x':
            for(i=0;i<np;i++)
                p[i].x=world_dim[0]-p[i].x;
            break;
        case (int)'y':
            for(i=0;i<np;i++)
                p[i].y=world_dim[1]-p[i].y;
            break;
        case (int)'z':
            for(i=0;i<np;i++)
                p[i].z=world_dim[2]-p[i].z;
            break;
    }
}
-(void)getCrop:(char**)crop dim:(int*)cdim
{
	int	a,b,c,d,e,f;
	int	i,j,k;
	
	a=b=c=d=e=f=0;
	
	// find min
	i=j=k=0;
	while(selection[k*dim[1]*dim[0]+j*dim[0]+i]<1)
	{
		i++;
		if(i==dim[0]){ i=0;j++;}
		if(j==dim[1]){ j=0;k++;}
		if(k==dim[2]) break;
	}
	a=i;
	b=j;
	c=k;
	
	//find max
	i=dim[0]-1;
	j=dim[1]-1;
	k=dim[2]-1;
	while(selection[k*dim[1]*dim[0]+j*dim[0]+i]<1)
	{
		i--;
		if(i==-1){ i=dim[0]-1;j--;}
		if(j==-1){ j=dim[1]-1;k--;}
		if(k==-1) break;
	}
	d=i;
	e=j;
	f=k;
	
	// crop
	cdim[0]=d-a+1;
	cdim[1]=e-b+1;
	cdim[2]=f-c+1;
	switch(dataType)
	{
		case UCHAR:
			*crop=calloc(cdim[2]*cdim[1]*cdim[0],sizeof(char));
			for(i=a;i<=d;i++)
			for(j=b;j<=e;j++)
			for(k=c;k<=f;k++)
				((unsigned char*)*crop)[(k-c)*cdim[1]*cdim[0]+(j-b)*cdim[0]+(i-a)]=((unsigned char*)data)[k*dim[1]*dim[0]+j*dim[0]+i];
			break;
		case SHORT:
			*crop=calloc(cdim[2]*cdim[1]*cdim[0],sizeof(short));
			for(i=a;i<=d;i++)
			for(j=b;j<=e;j++)
			for(k=c;k<=f;k++)
				((short*)*crop)[(k-c)*cdim[1]*cdim[0]+(j-b)*cdim[0]+(i-a)]=((short*)data)[k*dim[1]*dim[0]+j*dim[0]+i];
			break;
		case INT:
			*crop=calloc(cdim[2]*cdim[1]*cdim[0],sizeof(int));
			for(i=a;i<=d;i++)
			for(j=b;j<=e;j++)
			for(k=c;k<=f;k++)
				((int*)*crop)[(k-c)*cdim[1]*cdim[0]+(j-b)*cdim[0]+(i-a)]=((int*)data)[k*dim[1]*dim[0]+j*dim[0]+i];
			break;
		case FLOAT:
			*crop=calloc(cdim[2]*cdim[1]*cdim[0],sizeof(float));
			for(i=a;i<=d;i++)
			for(j=b;j<=e;j++)
			for(k=c;k<=f;k++)
				((float*)*crop)[(k-c)*cdim[1]*cdim[0]+(j-b)*cdim[0]+(i-a)]=((float*)data)[k*dim[1]*dim[0]+j*dim[0]+i];
			break;
		case RGB:
			*crop=calloc(cdim[2]*cdim[1]*cdim[0],sizeof(RGBValue));
			for(i=a;i<=d;i++)
			for(j=b;j<=e;j++)
			for(k=c;k<=f;k++)
				((RGBValue*)*crop)[(k-c)*cdim[1]*cdim[0]+(j-b)*cdim[0]+(i-a)]=((RGBValue*)data)[k*dim[1]*dim[0]+j*dim[0]+i];
			break;
	}
}
-(void)grow:(float)Min :(float)Max
{
	int		i,j,k;
	int		a,b,c;
	char	*tmp=calloc(dim[0]*dim[1]*dim[2],1);
	int		r=1;
	float	val;
	
	for(i=0;i<dim[0]*dim[1]*dim[2];i++) tmp[i]=selection[i];

	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	if(selection[k*dim[1]*dim[0]+j*dim[0]+i]>0)
	{
		for(a=-r;a<=r;a++)
		for(b=-r;b<=r;b++)
		for(c=-r;c<=r;c++)
		if(	i+a>=0 && i+a<dim[0] &&
			j+b>=0 && j+b<dim[1] &&
			k+c>=0 && k+c<dim[2])
		if(a*a+b*b+c*c<=r*r)
		if(selection[(k+c)*dim[1]*dim[0]+(j+b)*dim[0]+(i+a)]==0)
		{
			val=[self getValueAt:(i+a):(j+b):(k+c)];
			if(val>=Min && val<=Max)
				tmp[(k+c)*dim[1]*dim[0]+(j+b)*dim[0]+(i+a)]=1;
		}
	}

	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
	if(selection[i]==0 && tmp[i]>0)
		selection[i]=sindex;
	sindex++;
	free(tmp);
}
-(void)help:(char*)cmd
{
	printf("> help on command\n");
	NSArray			*cmds=[app cmds];
	NSMutableString	*str=[NSMutableString new];
	NSString		*hlp;
	int				i;
	
	for(i=0;i<[cmds count];i++)
		if([[[cmds objectAtIndex:i] objectForKey:@"cmd"] caseInsensitiveCompare:[NSString stringWithUTF8String:cmd]]==NSOrderedSame)
		{
			hlp=[[cmds objectAtIndex:i] objectForKey:@"help"];
			if([hlp length])
				[str appendString:hlp];
			else
				[str appendString:@"No help available"];
		break;
		}
	if(i==[cmds count])
		[str appendString:@"Command unknown"];
	
	//[str appendString:@"\n"];
	[self displayMessage:str];
	[str release];
}
-(void)hideMesh
{
    flag_showMesh=false;
}
-(void)histogram
{
	NSRect		wframe=NSMakeRect(0,0,200,200);
	NSWindow	*window=[[NSWindow alloc] initWithContentRect:wframe
											styleMask:NSTitledWindowMask|NSClosableWindowMask|NSResizableWindowMask
											backing:NSBackingStoreBuffered
											defer:NO];
	[window makeKeyAndOrderFront:NSApp];
}
-(void)interpolateSelectionTODO:(int)minSlice :(int)maxSlice
{
	int		i;
	//float	t;
	
	for(i=minSlice;i<maxSlice;i++)
	{
		//selection[];
	}
}
-(void)info
{
	// print volume header
	AnalyzeHeader	*header=hdr;
	nifti_1_header		*nii=(nifti_1_header*)header;
	char			str[256];
	int				isNii;
	
	isNii=0;
	if(strcmp((*(nifti_1_header*)header).magic,"n+1")==0||strcmp((*(nifti_1_header*)header).magic,"ni1")==0)
		isNii=1;
	switch(header->datatype)
    {   case UCHAR:     sprintf(str,"uchar"); break;
        case DT_INT8:   sprintf(str,"char"); break;
        case SHORT:     sprintf(str,"short"); break;
        case DT_UINT16: sprintf(str,"ushort"); break;
		case FLOAT:		sprintf(str,"float"); break;
        case INT:       sprintf(str,"int"); break;
        case DT_UINT32: sprintf(str,"uint"); break;
		case RGB:		sprintf(str,"rgb"); break;
		case RGBFLOAT:	sprintf(str,"rgbfloat"); break;
	}
	NSString	*string;
	if(isNii)
		string=[NSString stringWithFormat:@"\
Name:\t\t%s\n\
Volume size:\t%i,%i,%i,%i,%i\n\
Voxel units:\t%i,%i\n\
Data type:\t\t%s\n\
Voxel size:\t%g,%g,%g,%g\n\
Description:\t%s\n\
qform_code:\t%i\n\
sform_code:\t%i\n\
quatern_b:\t%g\n\
quatern_c:\t%g\n\
quatern_d:\t%g\n\
qoffset_x:\t%g\n\
qoffset_y:\t%g\n\
qoffset_z:\t%g\n\
Matrix:\n%g,%g,%g,%g\n%g,%g,%g,%g\n%g,%g,%g,%g",
		nii->db_name,
		nii->dim[0],nii->dim[1],nii->dim[2],nii->dim[3],nii->dim[4],
		nii->xyzt_units&0x7,nii->xyzt_units&0x38,
		str,
		nii->pixdim[0],nii->pixdim[1],nii->pixdim[2],nii->pixdim[3],
		nii->descrip,
        nii->qform_code,
        nii->sform_code,
        nii->quatern_b,
        nii->quatern_c,
        nii->quatern_d,
        nii->qoffset_x,
        nii->qoffset_y,
        nii->qoffset_z,
        nii->srow_x[0],nii->srow_x[1],nii->srow_x[2],nii->srow_x[3],
		nii->srow_y[0],nii->srow_y[1],nii->srow_y[2],nii->srow_y[3],
		nii->srow_z[0],nii->srow_z[1],nii->srow_z[2],nii->srow_z[3]];
	else
		string=[NSString stringWithFormat:@"\
Name:\t\t%s\n\
Volume size:\t%i,%i,%i,%i,%i\n\
Voxel units:\t%c%c\n\
Data type:\t\t%s\n\
Endianness:\t%s\n\
Voxel size:\t%i,%f,%f,%f\n\
Description:\t%s\n\
Origin:\t\t%i,%i,%i\n",
		 header->db_name,
		 header->dim[0],header->dim[1],header->dim[2],header->dim[3],header->dim[4],
		 ((char*)header->unused)[0],((char*)header->unused)[1],
		 str,
		 (header->sizeof_hdr==348)?"Intel":"Motorola",
		 (int)(header->pixdim[0]),header->pixdim[1],header->pixdim[2],header->pixdim[3],
		 header->descrip,
		 header->orig[0],header->orig[1],header->orig[2]];
	[self displayMessage:string];
    printf("voxel offset: %i\n",(int)nii->vox_offset);
}
-(void)invert
{
	printf("> invert\n");
	int		i;
	
	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
		selection[i]=1-(selection[i]>0);
	sindex=2;
}
-(void)mode
{
	printf("> mode\n");
	int		i,j,k;
	int		a,b,c;
	int		freq,maxfreq;
	int		n;
	float	*tmp=calloc(7*7*7,sizeof(float)),val,maxval;
	float	*tmp2=calloc(dim[0]*dim[1]*dim[2],sizeof(float));
	
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	if(selection[k*dim[1]*dim[0]+j*dim[0]+i] && [self getValueAt:i:j:k]==0)
	{
		n=0;
		for(a=-3;a<3;a++)
		for(b=-3;b<3;b++)
		for(c=-3;c<3;c++)
		if(a*a+b*b+c*c<3*3)
		if( i+a>=0 && i+a<dim[0] && j+b>=0 && j+b<dim[1] && k+c>=0 && k+c<dim[2])
		{
			val=[self getValueAt:i+a:j+b:k+c];
			if(val)
				tmp[n++]=val;
		}
		
		if(n==0)
			continue;
		
		// find mode
		maxfreq=0;
		for(a=0;a<n;a++)
		{
			if(tmp[a]>0)
			{
				freq=1;
				for(b=a+1;b<n;b++)
					if(tmp[b]==tmp[a])
					{
						tmp[b]=-1;
						freq++;
					}
				if(freq>maxfreq)
				{
					maxfreq=freq;
					maxval=tmp[a];
				}
			}
		}
		tmp2[k*dim[1]*dim[0]+j*dim[0]+i]=maxval;
	}

	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	if(tmp2[k*dim[1]*dim[0]+j*dim[0]+i])
		[self setValue:tmp2[k*dim[1]*dim[0]+j*dim[0]+i] at:i:j:k];
	free(tmp);
	free(tmp2);
}
-(void)multiplyConstant:(float)x
{
	int	i,j,k;
	float	val;
	for(i=0;i<dim[0];i++)
		for(j=0;j<dim[1];j++)
			for(k=0;k<dim[2];k++)
			{
				val=[self getValueAt:i:j:k];
				val=val*x;
				[self setValue:val at:i:j:k];
			}
	[self configureMinMax];
}
-(void)make26
{
	int	i,j,k,l;
	int	b[4];

	// remove edges in the XY plane
	for(i=0;i<dim[0]-1;i++)
	for(j=0;j<dim[1]-1;j++)
	for(k=0;k<dim[2];k++)
	{
		b[0]=selection[k*dim[1]*dim[0]+(j+0)*dim[0]+(i+0)]>0;
		b[1]=selection[k*dim[1]*dim[0]+(j+0)*dim[0]+(i+1)]>0;
		b[2]=selection[k*dim[1]*dim[0]+(j+1)*dim[0]+(i+1)]>0;
		b[3]=selection[k*dim[1]*dim[0]+(j+1)*dim[0]+(i+0)]>0;
		l=b[0]+b[1]*2+b[2]*4+b[3]*8;
		if(l==5)
			selection[k*dim[1]*dim[0]+(j+0)*dim[0]+(i+0)]=0;
		if(l==10)
			selection[k*dim[1]*dim[0]+(j+0)*dim[0]+(i+1)]=0;
	}

	// remove edges in the YZ plane
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1]-1;j++)
	for(k=0;k<dim[2]-1;k++)
	{
		b[0]=selection[(k+0)*dim[1]*dim[0]+(j+0)*dim[0]+i]>0;
		b[1]=selection[(k+0)*dim[1]*dim[0]+(j+1)*dim[0]+i]>0;
		b[2]=selection[(k+1)*dim[1]*dim[0]+(j+1)*dim[0]+i]>0;
		b[3]=selection[(k+1)*dim[1]*dim[0]+(j+0)*dim[0]+i]>0;
		l=b[0]+b[1]*2+b[2]*4+b[3]*8;
		if(l==5)
			selection[(k+0)*dim[1]*dim[0]+(j+0)*dim[0]+i]=0;
		if(l==10)
			selection[(k+0)*dim[1]*dim[0]+(j+1)*dim[0]+i]=0;
	}
	
	// remove edges in the ZX plane
	for(i=0;i<dim[0]-1;i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2]-1;k++)
	{
		b[0]=selection[(k+0)*dim[1]*dim[0]+j*dim[0]+(i+0)]>0;
		b[1]=selection[(k+1)*dim[1]*dim[0]+j*dim[0]+(i+0)]>0;
		b[2]=selection[(k+1)*dim[1]*dim[0]+j*dim[0]+(i+1)]>0;
		b[3]=selection[(k+0)*dim[1]*dim[0]+j*dim[0]+(i+1)]>0;
		l=b[0]+b[1]*2+b[2]*4+b[3]*8;
		if(l==5)
			selection[(k+0)*dim[1]*dim[0]+j*dim[0]+(i+0)]=0;
		if(l==10)
			selection[(k+1)*dim[1]*dim[0]+j*dim[0]+(i+0)]=0;
	}
	
	// remove corners
}
-(void)minMax
{
	[self displayMessage:[NSString stringWithFormat:@"min=%f, max=%f",min,max]];
}
-(BOOL)loadMeshTextFormat:(char*)path
{
    FILE    *f;
    char    str[512];
    int     np;
    int     nt;
    float3D *p;
    int3D   *t;
    int     i;
    
    f=fopen(path,"r");
    fgets(str,512,f);
    sscanf(str," %i %i ",&np,&nt);
    p=(float3D*)calloc(np,sizeof(float3D));
    t=(int3D*)calloc(nt,sizeof(int3D));
    for(i=0;i<np;i++)
    {
        fgets(str,512,f);
        sscanf(str," %f %f %f ",&(p[i].x),&(p[i].y),&(p[i].z));
    }
    for(i=0;i<nt;i++)
    {
        fgets(str,512,f);
        sscanf(str," %i %i %i ",&(t[i].a),&(t[i].b),&(t[i].c));
    }
    mesh=(Mesh*)calloc(1,sizeof(Mesh));
    mesh->np=np;
    mesh->nt=nt;
    mesh->p=p;
    mesh->t=t;
    flag_showMesh=true;
    printf("Loaded mesh, %i vertices, %i triangles\n",np,nt);
    return YES;
}
-(BOOL)loadMeshPLYFormat:(char*)path
{
    FILE    *f;
    int     np;
    int     nt;
    float3D *p;
    int3D   *t;
    int     i,x;
    char    str[512],str1[256],str2[256];
    
    f=fopen(path,"r");
    if(f==NULL){printf("ERROR: Cannot open file\n");return 1;}
    
    // READ HEADER
    np=nt=0;
    do
    {
        fgets(str,511,f);
        sscanf(str," %s %s %i ",str1,str2,&x);
        if(strcmp(str1,"element")==0&&strcmp(str2,"vertex")==0)
            np=x;
        else
            if(strcmp(str1,"element")==0&&strcmp(str2,"face")==0)
                nt=x;
    }
    while(strcmp(str1,"end_header")!=0 && !feof(f));
    if(np*nt==0)
    {
        printf("ERROR: Bad Ply file header format\n");
        return NO;
    }
    // READ VERTICES
    p=(float3D*)calloc(np,sizeof(float3D));
    if(p==NULL){printf("ERROR: Not enough memory for mesh vertices\n");return NO;}
    for(i=0;i<np;i++)
        fscanf(f," %f %f %f ",&(p[i].x),&(p[i].y),&(p[i].z));
    
    // READ TRIANGLES
    t=(int3D*)calloc(nt,sizeof(int3D));
    if(t==NULL){printf("ERROR: Not enough memory for mesh triangles\n"); return NO;}
    for(i=0;i<nt;i++)
        fscanf(f," 3 %i %i %i ",&(t[i].a),&(t[i].b),&(t[i].c));

    fclose(f);

    mesh=(Mesh*)calloc(1,sizeof(Mesh));
    mesh->np=np;
    mesh->nt=nt;
    mesh->p=p;
    mesh->t=t;
    flag_showMesh=true;
    printf("Loaded mesh, %i vertices, %i triangles\n",np,nt);
    
    return YES;
}
-(BOOL)loadMesh:(char*)path
{
    NSString *ex = [[NSString stringWithUTF8String:path] pathExtension];
    if([ex isEqualToString:@"txt"])
        [self loadMeshTextFormat:path];
    else
    if([ex isEqualToString:@"ply"])
        [self loadMeshPLYFormat:path];
    else
    {
        printf("ERROR: Unknown mesh format\n");
        return NO;
    }
    return YES;
}
-(BOOL)loadSelection:(char*)path
{
	char			*addr;
	int				sz;
	AnalyzeHeader	*newhdr;
	char			*img;
	int				swapped;
    int             i,j,k;

	Analyze_load((char*)path, &addr,&sz,&swapped);
	newhdr=(AnalyzeHeader*)addr;
	img=addr+sizeof(AnalyzeHeader);
	
    if(newhdr->datatype!=SHORT)
    {
        [self displayMessage:[NSString stringWithFormat:@"ERROR: data type must be SHORT\n"]];
        printf("ERROR: Cannot load selection - data type different from SHORT.\n");
        return NO;
    }

    if(newhdr->dim[1]==dim[0] && newhdr->dim[2]==dim[1] && newhdr->dim[3]==dim[2])
        memcpy(selection,img,dim[0]*dim[1]*dim[2]*sizeof(short));
    else
	{
        [self displayMessage:[NSString stringWithFormat:@"WARNING: dimensions do not match\n"]];
		printf("WARNING: dimensions do not match.\n");
        
        for(i=0;i<dim[0];i++)
        for(j=0;j<dim[1];j++)
        for(k=0;k<dim[2];k++)
        if(i<newhdr->dim[1] && j<newhdr->dim[2] && k<newhdr->dim[3])
            selection[k*dim[1]*dim[0]+j*dim[0]+i]=((short*)img)[k*newhdr->dim[2]*newhdr->dim[1]+j*newhdr->dim[1]+i]>0;
	}
	free(addr);
	
	return YES;
}
-(void)penSize:(int)a
{
	pensize=a;
}
-(void)polygonize:(char*)path
{
	VOLUME			vol;
	PROCESS			p;
	char			*err;
	int				i,j,k;
	AnalyzeHeader	h;
	FILE			*f;
	float			pix[3];
	
	h=*hdr;
	for(i=0;i<3;i++)
		pix[i]=fabs(h.pixdim[i+1]);

	vol.dim=dim;
	vol.pix=pix;
	vol.datatype=1;
	vol.vol=(char*)selection;
	
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
		if(selection[k*dim[1]*dim[0]+j*dim[1]+i])
			break;
//	err=polygonize(&p,&vol,5,2000,i,j,k,TET);	
	err=polygonize(&p,&vol,2*(pix[0]+pix[1]+pix[2])/3.0,2000,i*pix[0],j*pix[1],k*pix[2],TET);	

	if(err!=NULL)
	{
		printf("%s\n",err);
		return;
	}
	
	f=fopen(path,"w");
	fprintf(f,"%d %d\n",p.vertices.count,p.triangles.count);
	for(i=0;i<p.vertices.count;i++)
	{
		VERTEX	v;
		v=p.vertices.ptr[i];
		fprintf(f,"%f  %f	 %f\n",v.position.x,v.position.y,v.position.z);
	}
	for(i=0;i<p.triangles.count;i++)
	{
		TRIANGLE	t;
		t=p.triangles.ptr[i];
		fprintf(f,"%d %d %d\n",t.i,t.j,t.k);
	}
	fclose(f);
	
	freeprocess(p);
	
	[[NSWorkspace sharedWorkspace] openFile:[NSString stringWithUTF8String:path] withApplication:@"EditMesh.app"];
}
-(void)pushMesh:(float)d
{
    int i,j,np,nt;
    float3D *p;
    int3D   *t;
    float3D *p0; // rest configuration
    float3D *n; // normal vectors
    float3D a;
    
    if(mesh==nil)
    {
        printf("ERROR: no mesh loaded");
        return;
    }
    np=mesh->np;
    nt=mesh->nt;
    p=mesh->p;
    t=mesh->t;
    
    p0=(float3D*)calloc(np,sizeof(float3D));
    n=(float3D*)calloc(np,sizeof(float3D));

    // compute normal vectors
    for(i=0;i<nt;i++)
    {
        a=cross3D(sub3D(p[t[i].b],p[t[i].a]),sub3D(p[t[i].c],p[t[i].a]));
        a=sca3D(a,1/norm3D(a));
        n[t[i].a]=add3D(n[t[i].a],a);
        n[t[i].b]=add3D(n[t[i].b],a);
        n[t[i].c]=add3D(n[t[i].c],a);
    }
    for(i=0;i<np;i++)
        n[i]=sca3D(n[i],1/norm3D(n[i]));
    
    // smooth normals
    for(j=0;j<2;j++)
    {
        for(i=0;i<nt;i++)
        {
            a=sca3D(add3D(add3D(n[t[i].a],n[t[i].b]),n[t[i].c]),1/3.0);
            p0[t[i].a]=add3D(p0[t[i].a],a);
            p0[t[i].b]=add3D(p0[t[i].b],a);
            p0[t[i].c]=add3D(p0[t[i].c],a);
        }
        for(i=0;i<np;i++)
            p0[i]=sca3D(p0[i],1/norm3D(p0[i]));
        for(i=0;i<nt;i++)
        {
            a=sca3D(add3D(add3D(p0[t[i].a],p0[t[i].b]),p0[t[i].c]),1/3.0);
            n[t[i].a]=add3D(n[t[i].a],a);
            n[t[i].b]=add3D(n[t[i].b],a);
            n[t[i].c]=add3D(n[t[i].c],a);
        }
        for(i=0;i<np;i++)
            n[i]=sca3D(n[i],1/norm3D(n[i]));
   }
    
    // push mesh in the normal direction
    for(i=0;i<np;i++)
    {
        p0[i]=p[i];
        p[i]=add3D(p[i],sca3D(n[i],d));
    }

    // collision detection
    // compute average edge length
    float avrgEdgeLength=0;
    for(i=0;i<nt;i++)
    {
        avrgEdgeLength+=norm3D(sub3D(p[t[i].a],p[t[i].b]));
        avrgEdgeLength+=norm3D(sub3D(p[t[i].b],p[t[i].c]));
        avrgEdgeLength+=norm3D(sub3D(p[t[i].c],p[t[i].a]));
    }
    avrgEdgeLength/=3.0*nt;
    mesh->nhash=9973; // a prime number close to 10k
    mesh->hash=(HashCell*)calloc(mesh->nhash,sizeof(HashCell));
    mesh->hashCellSize=avrgEdgeLength;
    
    detect_collision(mesh,p0);

    free(p0);
    free(n);
    free(mesh->hash);
}
-(void)reorient:(char*)o
{
	char			*volReoriented;
	char			*addr;
	short			*selReoriented;
	int				i,j,k;
	int				i1,j1,k1;
	int				ind0,ind1,ind2;
	float			px1,px2,px3;
	int				n,n1;
	AnalyzeHeader	h;
	
	h=*hdr;
	
	volReoriented=calloc(dim[0]*dim[1]*dim[2],AnalyzeBytesPerVoxel(h));
	selReoriented=(short*)calloc(dim[0]*dim[1]*dim[2],sizeof(short));
	
	// reorient selection and volume
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	{
		i1=i*(o[0]=='x')+j*(o[0]=='y')+k*(o[0]=='z');
		j1=i*(o[1]=='x')+j*(o[1]=='y')+k*(o[1]=='z');
		k1=i*(o[2]=='x')+j*(o[2]=='y')+k*(o[2]=='z');
		ind0=0*(o[0]=='x')+1*(o[0]=='y')+2*(o[0]=='z');
		ind1=0*(o[1]=='x')+1*(o[1]=='y')+2*(o[1]=='z');
		ind2=0*(o[2]=='x')+1*(o[2]=='y')+2*(o[2]=='z');
		
		n=k*dim[1]*dim[0]+j*dim[0]+i;
		n1=k1*dim[ind1]*dim[ind0]+j1*dim[ind0]+i1;

		selReoriented[n1]=selection[n];

		switch(dataType)
		{
            case UCHAR:    ((unsigned char*)volReoriented)[n1]=((unsigned char*)data)[n];    break;
            case DT_INT8:    ((char*)volReoriented)[n1]=((char*)data)[n];    break;
            case SHORT:    ((short*)volReoriented)[n1]=((short*)data)[n];                    break;
            case DT_UINT16:    ((unsigned short*)volReoriented)[n1]=((unsigned short*)data)[n];                    break;
            case INT:    ((int*)volReoriented)[n1]=((int*)data)[n];                        break;
            case DT_UINT32:    ((unsigned int*)volReoriented)[n1]=((unsigned int*)data)[n];                        break;
			case FLOAT:	((float*)volReoriented)[n1]=((float*)data)[n];					break;
		}
	}

	free(selection);
	selection=selReoriented;
	
	// make new header
	h.dim[0]=4;
	h.dim[1]=dim[ind0];
	h.dim[2]=dim[ind1];
	h.dim[3]=dim[ind2];
	h.dim[4]=1;
	px1=h.pixdim[1+ind0];
	px2=h.pixdim[1+ind1];
	px3=h.pixdim[1+ind2];
	h.pixdim[1]=px1;
	h.pixdim[2]=px2;
	h.pixdim[3]=px3;
	
	// put hdr and img in a single ptr
	addr=(char*)calloc(sizeof(AnalyzeHeader)+dim[ind0]*dim[ind1]*dim[ind2]*AnalyzeBytesPerVoxel(h),1);
	*(AnalyzeHeader*)addr=h;
	memcpy(addr+sizeof(AnalyzeHeader),volReoriented,dim[ind0]*dim[ind1]*dim[ind2]*AnalyzeBytesPerVoxel(h));
	free(volReoriented);
	
	// update data in view
	[self configureData:addr];
	[self configureMinMax];
	
	// update data in document
	[app configureInterface];	
}
-(void)reorientMesh:(char*)o
{
    int i;
    int np;
    int nt;
    float3D *p;
    int3D *t;
    
    if(mesh==nil)
        printf("ERROR: no mesh loaded");
    np=mesh->np;
    nt=mesh->nt;
    p=mesh->p;
    t=mesh->t;
    
    for(i=0;i<np;i++)
        p[i]=(float3D){
            p[i].x*(o[0]=='x')+p[i].y*(o[0]=='y')+p[i].z*(o[0]=='z'),
            p[i].x*(o[1]=='x')+p[i].y*(o[1]=='y')+p[i].z*(o[1]=='z'),
            p[i].x*(o[2]=='x')+p[i].y*(o[2]=='y')+p[i].z*(o[2]=='z')
        };
}
-(void)resample:(float)pixx :(float)pixy :(float)pixz :(char*)interpolation
{
	char			*volScaled;
	char			*addr;
	short			*selScaled;
	short			newdim[4]={0,0,0,1};
	AnalyzeHeader	h;
	float			fx,fy,fz;
	
	h=*hdr;
	fx=fabs(h.pixdim[1]/pixx);
	fy=fabs(h.pixdim[2]/pixy);
	fz=fabs(h.pixdim[3]/pixz);
	
	// resample volume
	if(strcmp(interpolation,"nearest")==0)
		[self getScaledNearest:&volScaled fx:fx fy:fy fz:fz dim:newdim];
	else
	if(strcmp(interpolation,"trilinear")==0)
		[self getScaledTrilinear:&volScaled fx:fx fy:fy fz:fz dim:newdim];
	
	// resample selection
	[self getScaledSelectionTrilinear:&selScaled fx:fx fy:fy fz:fz dim:newdim];
	free(selection);
	selection=selScaled;

	// make new header
	h.dim[0]=4;
	h.dim[1]=newdim[0];
	h.dim[2]=newdim[1];
	h.dim[3]=newdim[2];
	h.dim[4]=1;
	h.pixdim[1]=pixx;
	h.pixdim[2]=pixy;
	h.pixdim[3]=pixz;
	
	// put hdr and img in a single ptr
	addr=(char*)calloc(sizeof(AnalyzeHeader)+newdim[0]*newdim[1]*newdim[2]*AnalyzeBytesPerVoxel(h),1);
	*(AnalyzeHeader*)addr=h;
	memcpy(addr+sizeof(AnalyzeHeader),volScaled,newdim[0]*newdim[1]*newdim[2]*AnalyzeBytesPerVoxel(h));
	free(volScaled);

	// update data in view
	[self configureData:addr];
	[self configureMinMax];
	
	// update data in document
	[app configureInterface];
}
-(void)resize:(int)x :(int)y :(int)z :(char*)just
{
	char			*volResized;
	short			*selResized;
	char			*addr;
	short			newdim[4]={0,0,0,1};
	int				i,j,k;	// original and target coordinates
	int				o[3];				// offset for justification
	AnalyzeHeader	h;
	
	h=*hdr;
	newdim[0]=x;
	newdim[1]=y;
	newdim[2]=z;

	// compute offsets
	for(i=0;i<3;i++)
	{
		o[i]=0;												// 'start' justification by default
		if(just[i]=='c')		o[i]=(dim[i]-newdim[i])/2;	// 'center'
		else if(just[i]=='e')	o[i]=dim[i]-newdim[i];		// 'end'
	}
	
	volResized=calloc(x*y*z,AnalyzeBytesPerVoxel(h));
	// resize volume
	for(i=0;i<x;i++)
	for(j=0;j<y;j++)
	for(k=0;k<z;k++)
	if(i+o[0]>=0&&i+o[0]<dim[0] && j+o[1]>=0&&j+o[1]<dim[1] && k+o[2]>=0&&k+o[2]<dim[2])
	{
		switch(dataType)
		{
            case UCHAR:
                ((unsigned char*)volResized)[k*y*x+j*x+i]=((unsigned char*)data)[(k+o[2])*dim[1]*dim[0]+(j+o[1])*dim[0]+(i+o[0])];
                break;
            case DT_INT8:
                ((char*)volResized)[k*y*x+j*x+i]=((char*)data)[(k+o[2])*dim[1]*dim[0]+(j+o[1])*dim[0]+(i+o[0])];
                break;
            case SHORT:
                ((short*)volResized)[k*y*x+j*x+i]=((short*)data)[(k+o[2])*dim[1]*dim[0]+(j+o[1])*dim[0]+(i+o[0])];
                break;
            case DT_UINT16:
                ((unsigned short*)volResized)[k*y*x+j*x+i]=((unsigned short*)data)[(k+o[2])*dim[1]*dim[0]+(j+o[1])*dim[0]+(i+o[0])];
                break;
            case INT:
                ((int*)volResized)[k*y*x+j*x+i]=((int*)data)[(k+o[2])*dim[1]*dim[0]+(j+o[1])*dim[0]+(i+o[0])];
                break;
            case DT_UINT32:
                ((unsigned int*)volResized)[k*y*x+j*x+i]=((unsigned int*)data)[(k+o[2])*dim[1]*dim[0]+(j+o[1])*dim[0]+(i+o[0])];
                break;
			case FLOAT:
				((float*)volResized)[k*y*x+j*x+i]=((float*)data)[(k+o[2])*dim[1]*dim[0]+(j+o[1])*dim[0]+(i+o[0])];
				break;
		}
	}
//	for(i=0;i<x*y*z*AnalyzeBytesPerVoxel(h);i++)
//		volResized[i]=data[i];
	
	// resize selection
	selResized=calloc(x*y*z,sizeof(short));
	for(i=0;i<x;i++)
	for(j=0;j<y;j++)
	for(k=0;k<z;k++)
	if(i+o[0]>=0&&i+o[0]<dim[0] && j+o[1]>=0&&j+o[1]<dim[1] && k+o[2]>=0&&k+o[2]<dim[2])
		selResized[k*y*x+j*x+i]=selection[(k+o[2])*dim[1]*dim[0]+(j+o[1])*dim[0]+(i+o[0])];
	free(selection);
	selection=selResized;

	// make new header
	h.dim[0]=4;
	h.dim[1]=x;
	h.dim[2]=y;
	h.dim[3]=z;
	h.dim[4]=1;

	// put hdr and img in a single ptr
	addr=(char*)calloc(sizeof(AnalyzeHeader)+x*y*z*AnalyzeBytesPerVoxel(h),1);
	*(AnalyzeHeader*)addr=h;
	memcpy(addr+sizeof(AnalyzeHeader),volResized,x*y*z*AnalyzeBytesPerVoxel(h));
	free(volResized);
	
	// update data in view
	[self configureData:addr];
	[self configureMinMax];
	
	// update data in document
	[app configureInterface];
}
-(BOOL)save
{
	int		result;
	char	*path=(char*)[[app path] UTF8String];
	result=[self saveAs:path];
	return result;
}
-(BOOL)saveAs:(char*)path
{
	int				result;
	AnalyzeHeader	h;
	
	h=*hdr;
	result=Analyze_save_hdr(path,h);
	if(result==NO)
	{
		printf("ERROR: saveAs\n");
		return result;
	}
	result=Analyze_save_img(path,h,data);
	if(result==NO)
		printf("ERROR: saveAs\n");
	return result;
}
-(BOOL)saveMesh:(char*)path
{
    FILE *f;
    int i;
    int np;
    int nt;
    float3D *p;
    int3D *t;

    if(mesh==nil)
    {
        printf("ERROR: no mesh loaded");
        return 0;
    }
    np=mesh->np;
    nt=mesh->nt;
    p=mesh->p;
    t=mesh->t;

    f=fopen(path,"w");
    fprintf(f,"%i %i\n",np,nt);
    for(i=0;i<np;i++)
        fprintf(f,"%f %f %f\n",p[i].x,p[i].y,p[i].z);
    for(i=0;i<nt;i++)
        fprintf(f,"%i %i %i\n",t[i].a,t[i].b,t[i].c);
    fclose(f);
    
    return 1;
}
-(BOOL)saveSelection:(char*)path
{
	int				result;
	AnalyzeHeader	h;
	
	h=*hdr;
	h.datatype=SHORT;
	result=Analyze_save_hdr(path,h);
	if(result==NO)
	{
		printf("ERROR: saveSelection\n");
		return result;
	}
	result=Analyze_save_img(path,h,(char*)selection);
	if(result==NO)
		printf("ERROR: saveSelection\n");
	return result;
}
-(void)savePicture:(char*)path
{
	NSData		*bmp=[[[image representations] objectAtIndex:0] representationUsingType:NSJPEGFileType properties:[NSDictionary dictionaryWithObject:[NSDecimalNumber numberWithFloat:0.8] forKey:NSImageCompressionFactor]];
	NSString	*filename=[NSString stringWithFormat:@"%s.jpg",path];
	
	[bmp writeToFile:filename atomically:YES];    
}
-(void)scaleMesh:(float)x
{
    int i;
    int np;
    int nt;
    float3D *p;
    int3D *t;
    
    if(mesh==nil)
        printf("ERROR: no mesh loaded");
    np=mesh->np;
    nt=mesh->nt;
    p=mesh->p;
    t=mesh->t;
    
    for(i=0;i<np;i++)
        p[i]=sca3D(p[i],x);
}
-(void)select:(int)x :(int)y :(int)z :(float)Min :(float)Max
{
	printf("> select\n");
	int		n,k;
	int		dx,dy,dz;
	int		dire[6]={0,0,0,0,0,0};
	int		nstack=0;
	short	stack[STACK][3];
	char	dstack[STACK];
	int		empty,mark;
	float	val;
	char	*tmp;

	tmp=(char*)calloc(dim[0]*dim[1]*dim[2],sizeof(char));

	n=0;
	for(;;)
	{
		tmp[z*dim[1]*dim[0]+y*dim[0]+x]=1;
		n++;
		
		for(k=0;k<6;k++)
		{
			dx = (-1)*(	k==3 ) + ( 1)*( k==1 );
			dy = (-1)*( k==2 ) + ( 1)*( k==0 );
			dz = (-1)*( k==5 ) + ( 1)*( k==4 );

			if(	z+dz>=0 && z+dz<dim[2] &&
				y+dy>=0 && y+dy<dim[1] &&
				x+dx>=0 && x+dx<dim[0] )
			{
				val=[self getValueAt:(x+dx):(y+dy):(z+dz)];
				empty=(val>=Min && val<=Max);
				mark = tmp[(z+dz)*dim[1]*dim[0]+(y+dy)*dim[0]+(x+dx)];
				if( empty && !mark && !dire[k])
				{
					dire[k] = 1;
					dstack[nstack] = k+1;
					stack[nstack][0]=x+dx;
					stack[nstack][1]=y+dy;
					stack[nstack][2]=z+dz;
					nstack++;
				}
				else
					if( dire[k] && !empty && !mark)
						dire[k] = 0;
			}
		}
		if(nstack>STACK-10)
		{
			printf("StackOverflow\n");
			break;
		}
		if(nstack)
		{
			nstack--;
			x = stack[nstack][0];
			y = stack[nstack][1];
			z = stack[nstack][2];
			for(k=0;k<6;k++)
				dire[k] = (dstack[nstack]==(k+1))?0:dire[k];
		}
		else
			break;
	}
	
	for(k=0;k<dim[0]*dim[1]*dim[2];k++)
	if(selection[k]==0 && tmp[k]>0)
		selection[k]=sindex;
	sindex++;
	free(tmp);
	
	printf("%i voxels selected\n",n);
}
-(void)set:(float)val
{
	printf("> set\n");
	int		i,j,k;
	
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	if(selection[k*dim[1]*dim[0]+j*dim[0]+i]>0)
		[self setValue:val at:i:j:k];
}
-(void)setMinMax:(float)x :(float)y
{
	min=x;
	max=y;
}
-(void)setMouse:(char*)str
{
	if(strcmp(str,"select")==0)
		mode=kSELECT;
	else
	if(strcmp(str,"paint")==0)
		mode=kPAINT;
	else
	if(strcmp(str,"sample")==0)
		mode=kSAMPLE;
	else
	if(strcmp(str,"cselect")==0)
		mode=kCSELECT;
	else
	if(strcmp(str,"poly")==0)
		mode=kPOLY;
	else
	if(strcmp(str,"fill")==0)
		mode=kFILL;
	else
		printf("ERROR: Unknown mouse mode '%s'\n",str);
}
-(void)setRotation:(float)angleX :(float)angleY :(float)angleZ
{
	volRotation[0]=angleX;
	volRotation[1]=angleY;
	volRotation[2]=angleZ;
}
-(void)setSelectionColor:(float)r :(float)g :(float)b
{
	selectionColor[0]=r;
	selectionColor[1]=g;
	selectionColor[2]=b;
}
-(void)setSelectionOpacity:(float)o
{
	selectionOpacity=o;
}
-(void)setThresholdWidth:(float)w
{
	thresholdWidth=w;
}
-(void)setVolume:(char*)path
{
}
-(void)showMesh
{
    flag_showMesh=true;
}
-(void)smooth:(int)level :(int)iter
{
	int		i;
	char	kwhite=4; // voxel is selected
	char	*mask=calloc(dim[0]*dim[1]*dim[2],1);
	
	for(i=0;i<dim[2]*dim[1]*dim[0];i++)
		mask[i]=kwhite*(selection[i]>0);
		
	for(i=0;i<iter;i++)
		[self smooth1:mask:level];
	
	for(i=0;i<dim[2]*dim[1]*dim[0];i++)
		selection[i]=sindex*(mask[i]&kwhite);
	sindex++;

	free(mask);
}
-(void)smooth1:(char*)mask :(int)level	
{
	int		x,y,z;
	int		m,dx,dy,dz;
	char	mark;
	float	sum;
	int		voxelschanged=0;
	char	kwork0=1;		// voxel has enough neighbors
	char	kwork1=2;		// voxel has not changed
	char	kwhite=4;		// voxel is white
	int		doErode=1;		// to erode or not to erode
	int		doDilate=0;		// to dilate or not to dilate
	int		con27[27][3] ={{-1,-1,-1},	{0,-1,-1},	{1,-1,-1},
							{-1,0,-1},	{0,0,-1},	{1,0,-1},
							{-1,1,-1},	{0,1,-1},	{1,1,-1},
							
							{-1,-1,0},	{0,-1,0},	{1,-1,0},
							{-1,0,0},	{0,0,0},	{1,0,0},
							{-1,1,0},	{0,1,0},	{1,1,0},
							
							{-1,-1,1},	{0,-1,1},	{1,-1,1},
							{-1,0,1},	{0,0,1},	{1,0,1},
							{-1,1,1},	{0,1,1},	{1,1,1}};
	
	for(z=0;z<dim[2];z++)
	for(y=0;y<dim[1];y++)
	for(x=0;x<dim[0];x++)
	{
		mark = mask[z*dim[1]*dim[0]+y*dim[0]+x];

		if(!(mark&kwork1))
		{
			sum=0;
			for(m=0;m<27;m++)
			{
				dx = con27[m][0];
				dy = con27[m][1];
				dz = con27[m][2];

				if(	z+dz>=0 && z+dz<dim[2] &&
					y+dy>=0 && y+dy<dim[1] &&
					x+dx>=0 && x+dx<dim[0] )
				{
					mark = mask[(z+dz)*dim[1]*dim[0]+(y+dy)*dim[0]+(x+dx)];
					if(mark&kwhite)
						sum++;
				}
			}
			if(sum>=level)	mask[z*dim[1]*dim[0]+y*dim[0]+x] |= kwork0;
			else			mask[z*dim[1]*dim[0]+y*dim[0]+x] &= 0xff-kwork0;
			
			mask[z*dim[1]*dim[0]+y*dim[0]+x] |= kwork1;
		}
	}

	for(z=0;z<dim[2];z++)
	for(y=0;y<dim[1];y++)
	for(x=0;x<dim[0];x++)
	{
		mark = mask[z*dim[1]*dim[0]+y*dim[0]+x];
		
		if(mark&kwhite && !(mark&kwork0) && doErode)	// white -> black
		{
			mask[z*dim[1]*dim[0]+y*dim[0]+x] = 0;
			voxelschanged++;
			for(m=0;m<27;m++)
			{
				dx = con27[m][0];
				dy = con27[m][1];
				dz = con27[m][2];
				if(	z+dz>=0 && z+dz<dim[2] &&
					y+dy>=0 && y+dy<dim[1] &&
					x+dx>=0 && x+dx<dim[0] )
					mask[(z+dz)*dim[1]*dim[0]+(y+dy)*dim[0]+(x+dx)] &= 0xff-kwork1;
			}
		}
		else
		if(!(mark&kwhite) && mark&kwork0 && doDilate)	// black -> white
		{
			mask[z*dim[1]*dim[0]+y*dim[0]+x] = kwhite;
			voxelschanged++;
			for(m=0;m<27;m++)
			{
				dx = con27[m][0];
				dy = con27[m][1];
				dz = con27[m][2];
				if(	z+dz>=0 && z+dz<dim[2] &&
					y+dy>=0 && y+dy<dim[1] &&
					x+dx>=0 && x+dx<dim[0] )
					mask[(z+dz)*dim[1]*dim[0]+(y+dy)*dim[0]+(x+dx)] &= 0xff-kwork1;
			}
		}
	}
	
	printf("%i voxels modified\n",voxelschanged);
}
-(void)smoothMeshLaplace:(float)lambda :(int)iterations
{
    int i,j;
    int np;
    int nt;
    float3D *p;
    int3D *t;
    float3D *p0;
    int *n;
    
    if(mesh==nil)
    {
        printf("ERROR: No mesh to smooth\n");
        return;
    }
    printf("laplace smooth, lambda=%f, iterations:%i\n",lambda,iterations);
    np=mesh->np;
    nt=mesh->nt;
    p=mesh->p;
    t=mesh->t;
    
    p0=(float3D*)calloc(np,sizeof(float3D));
    n=(int*)calloc(np,sizeof(int));
    
    for(i=0;i<nt;i++)
    {
        n[t[i].a]+=2;
        n[t[i].b]+=2;
        n[t[i].c]+=2;
    }
    for(j=0;j<iterations;j++)
    {
        for(i=0;i<nt;i++)
        {
            p0[t[i].a]=add3D(p0[t[i].a],add3D(p[t[i].b],p[t[i].c]));
            p0[t[i].b]=add3D(p0[t[i].b],add3D(p[t[i].c],p[t[i].a]));
            p0[t[i].c]=add3D(p0[t[i].c],add3D(p[t[i].a],p[t[i].b]));
        }
        for(i=0;i<np;i++)
            p0[i]=sca3D(p0[i],1/(float)n[i]);
        for(i=0;i<np;i++)
        {
            p[i]=add3D(sca3D(p[i],1-lambda),sca3D(p0[i],lambda));
            p0[i]=(float3D){0,0,0};
        }
    }
    free(p0);
    free(n);
}
-(void)smoothMeshTaubin:(float)lambda :(float)mu :(int)iterations
{
    int i;
    
    for(i=0;i<iterations;i++)
    {
        [self smoothMeshLaplace:lambda:1];
        [self smoothMeshLaplace:mu:1];
    }
}
-(void)stats
{
	// volume in voxels
	// volume in pixels
	// histogram (20 bins)
	int		i,j,k;
	int		nv;
	float	vvol;
	float	val,min0,max0;
	int		hist[21];
	AnalyzeHeader	h;
	int		nbins=20;
	
	h=*hdr;
	vvol=h.pixdim[1]*h.pixdim[2]*h.pixdim[3];
	nv=0;
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	if(selection[k*dim[1]*dim[0]+j*dim[0]+i])
	{
		val=[self getValueAt:i:j:k];
		if(nv==0)
			min0=max0=val;
		else
		{
			if(val<min0) min0=val;
			if(val>max0) max0=val;
		}
		nv++;
	}
	
	for(i=0;i<=nbins;i++)
		hist[i]=0;
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	if(selection[k*dim[1]*dim[0]+j*dim[0]+i])
	{
		val=[self getValueAt:i:j:k];
		hist[(int)((val-min0)/(max0-min0)*nbins)]++;
	}
	
	NSMutableString	*str=[NSMutableString stringWithCapacity:100];
	
	[str appendString:[NSString stringWithFormat:@"nvoxels: %i\n",nv]];
	[str appendString:[NSString stringWithFormat:@"volume: %f [%c%c^3]\n",nv*vvol,h.unused[0],h.unused[1]]];
	[str appendString:[NSString stringWithFormat:@"min: %f\n",min0]];
	[str appendString:[NSString stringWithFormat:@"max: %f\n",max0]];
	[str appendString:@"hist=["];
	for(i=0;i<=nbins;i++)
		[str appendString:[NSString stringWithFormat:@"%i ",hist[i]]];
	[self displayMessage:str];
}
-(void)stdev:(int)neigh :(float)maxstd
{
	printf("> std\n");
    int		x,y,z,i,j,k;
	float	tmp[3],tmpd[3],tmpx[3];
	int		dim1[3],x1,y1,z1;
	float	val;
	float	*P,invP[16],n,s,ss,std;
	float	mx,mn;
	float		slice=[[[[app settings] content] valueForKey:@"slice"] floatValue];
	
	switch(plane)
	{
		case 1: P=X; break;
		case 2: P=Y; break;
		case 3: P=Z; break;
	}
	invMat(invP,P);
	
	tmp[0]=dim[0];
	tmp[1]=dim[1];
	tmp[2]=dim[2];
	multMatVec(tmpd,P,tmp);
	dim1[0]=(int)tmpd[0];
	dim1[1]=(int)tmpd[1];
	dim1[2]=(int)tmpd[2];
		
	z=slice;//(slice/100.0)*(dim1[2]-1);
	for(x=0;x<dim1[0];x++)
	for(y=0;y<dim1[1];y++)
	{
		s=ss=n=0;
		for(i=x-neigh;i<=x+neigh;i++)
		for(j=y-neigh;j<=y+neigh;j++)
		for(k=z-neigh;k<=z+neigh;k++)
		{
			if(i>=0&&i<dim1[0] && j>=0&&j<dim1[1] && k>=0&&k<dim1[2])
			{
				tmp[0]=i;
				tmp[1]=j;
				tmp[2]=k;
				multMatVec(tmpx,invP,tmp);
				x1=tmpx[0];
				y1=tmpx[1];
				z1=tmpx[2];
				val=[self getValueAt:x1:y1:z1];
				s += val;
				ss+= val*val;
				n++;
			}
		}
		if(n>1)	std=sqrt((n*ss-s*s)/n/(n-1));
		else	std=0;

		if(x==0 && y==0) mx=mn=std;
		if(mx<std) mx=std;
		if(mn>std) mn=std;
		if(std>maxstd) std=maxstd;

		[self setValue:std at:x1:y1:z1];
	}
	printf("stdev in [%f,%f]\n",mn,mx);
}
-(void)subtractSelection:(char*)path
{
	char			*addr;
	int				sz;
	AnalyzeHeader	*newhdr;
	char			*img;
	int				i;
	int				swapped;

	Analyze_load((char*)path, &addr,&sz,&swapped);
	newhdr=(AnalyzeHeader*)addr;
	img=addr+sizeof(AnalyzeHeader);
	
	if(newhdr->dim[1]!=dim[0] || newhdr->dim[2]!=dim[1] || newhdr->dim[3]!=dim[2])
	{
		printf("ERROR: Cannot load selection - dimensions do not match.\n");
		return;
	}
	if(newhdr->datatype!=SHORT)
	{
		printf("ERROR: Cannot load selection - data type different from SHORT.\n");
		return;
	}
	
	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
		if(((short*)img)[i] && selection[i])
			selection[i]=0;
	free(addr);
}
-(void)threshold:(float)value :(int)direction
{
	printf("> threshold\n");
	int		i,j,k;
	float	val;
	char	*tmp;

	tmp=(char*)calloc(dim[0]*dim[1]*dim[2],sizeof(char));

	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	{
		val=[self getValueAt:i:j:k];
		if((val>=value && direction==1)||(val<=value && direction==0))
			tmp[k*dim[1]*dim[0]+j*dim[0]+i]=1;
	}
	
	for(k=0;k<dim[0]*dim[1]*dim[2];k++)
	if(selection[k]==0 && tmp[k]>0)
		selection[k]=sindex;
	sindex++;
	free(tmp);
}
void tpDilate_set(int x, int y, int z, int *Ref, int *dim, short *ne, short *vol)
{
	int		K[3*8]={ 0,0,0, -1,0,0, -1,0,-1, 0,0,-1, 0,-1,0, -1,-1,0, -1,-1,-1, 0,-1,-1 };
	int		E=0,newE=0;
	int		Ecompl=0,newEcompl=0;
	int		i,i0,j0,k0;
	unsigned char local_complement;
	short	ne0[8],bit[8]={1,0,2,3,5,4,7,6};
	
	for(i=0;i<8;i++)
	{
		// Compute the Euler characteristic of the complement (because Euler uses 26-neighbours instead of 6-neighbours)
		i0=x+K[i*3+0];
		j0=y+K[i*3+1];
		k0=z+K[i*3+2];
		
		local_complement = 255-ne[k0*dim[1]*dim[0]+j0*dim[0]+i0];
		E+=Ref[ne[k0*dim[1]*dim[0]+j0*dim[0]+i0]];
		Ecompl+=Ref[local_complement];
		
		ne0[i]=ne[k0*dim[1]*dim[0]+j0*dim[0]+i0]|(1<<bit[i]);
		local_complement = 255-ne0[i];
		newE=newE+Ref[ne0[i]];
		newEcompl = newEcompl + Ref[local_complement];
	}
	
	if(newE-E)		// voxel would change the topology: return
		return;
	
	// set voxel
	vol[z*dim[1]*dim[0]+y*dim[0]+x]=1;
	for(i=0;i<8;i++)
	{
		i0=x+K[i*3+0];
		j0=y+K[i*3+1];
		k0=z+K[i*3+2];
		ne[k0*dim[1]*dim[0]+j0*dim[0]+i0]=ne0[i];
	}
}
-(void)tpDilate:(int)iter
{
	int		*Ref;
	short	*tmp,*ne;
	int		i,j,k,l;
	int		a,b,c;

	// configure topology evaluation
	Ref=configureTable();	
	tmp=(short*)calloc(dim[0]*dim[1]*dim[2],sizeof(short));
	ne=(short*)calloc(dim[0]*dim[1]*dim[2],sizeof(short));
	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
		if(selection[i])
			tmp[i]=1;
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
		fillVertices(tmp,ne,dim,i,j,k);
	
	for(l=0;l<iter;l++)
	{
		// topology-preserving dilate
		for(i=0;i<dim[0];i++)
		for(j=0;j<dim[1];j++)
		for(k=0;k<dim[2];k++)
		if(selection[k*dim[1]*dim[0]+j*dim[0]+i]>0)
		{
			for(a=-1;a<=1;a++)
			for(b=-1;b<=1;b++)
			for(c=-1;c<=1;c++)
			if(	i+a>=0 && i+a<dim[0] &&
			   j+b>=0 && j+b<dim[1] &&
			   k+c>=0 && k+c<dim[2])
			if(a*a+b*b+c*c<=1)
			if(selection[(k+c)*dim[1]*dim[0]+(j+b)*dim[0]+(i+a)]==0)
				tpDilate_set(i+a,j+b,k+c,Ref,dim,ne,tmp);
		}
		for(i=0;i<dim[0]*dim[1]*dim[2];i++)
		if(selection[i]==0 && tmp[i]>0)
			selection[i]=sindex;
		sindex++;
	}

	free(tmp);
	free(ne);
}
-(void)tpDilateOnMask:(int)iter :(char*)path
{
	char			*addr;
	int				sz;
	AnalyzeHeader	*newhdr;
	char			*img;
	int				swapped;
	int				*Ref;
	short			*tmp,*ne;
	int				i,j,k,l;
	int				a,b,c;
	
	// load mask
	Analyze_load((char*)path, &addr,&sz,&swapped);
	newhdr=(AnalyzeHeader*)addr;
	img=addr+sizeof(AnalyzeHeader);
	if(newhdr->dim[1]!=dim[0] || newhdr->dim[2]!=dim[1] || newhdr->dim[3]!=dim[2])
	{
		printf("[tpDilateOnMask] ERROR: Cannot load selection - dimensions do not match.\n");
		return;
	}
		
	// configure topology evaluation
	Ref=configureTable();	
	tmp=(short*)calloc(dim[0]*dim[1]*dim[2],sizeof(short));
	ne=(short*)calloc(dim[0]*dim[1]*dim[2],sizeof(short));
	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
		if(selection[i])
			tmp[i]=1;
	for(i=0;i<dim[0];i++)
		for(j=0;j<dim[1];j++)
			for(k=0;k<dim[2];k++)
				fillVertices(tmp,ne,dim,i,j,k);
	
	for(l=0;l<iter;l++)
	{
		// topology-preserving dilate inside a mask
		for(i=0;i<dim[0];i++)
		for(j=0;j<dim[1];j++)
		for(k=0;k<dim[2];k++)
		if(selection[k*dim[1]*dim[0]+j*dim[0]+i]>0 && getValue(newhdr,img,i,j,k)>0)
		{
			for(a=-1;a<=1;a++)
			for(b=-1;b<=1;b++)
			for(c=-1;c<=1;c++)
			if(	i+a>=0 && i+a<dim[0] &&
			   j+b>=0 && j+b<dim[1] &&
			   k+c>=0 && k+c<dim[2])
			if(a*a+b*b+c*c<=1)
			if(selection[(k+c)*dim[1]*dim[0]+(j+b)*dim[0]+(i+a)]==0)
				tpDilate_set(i+a,j+b,k+c,Ref,dim,ne,tmp);
		}
		for(i=0;i<dim[0]*dim[1]*dim[2];i++)
		if(selection[i]==0 && tmp[i]>0)
			selection[i]=sindex;
		sindex++;
	}
	
	free(addr);
	free(tmp);
	free(ne);
}
void tpErode_unset(int x, int y, int z, int *Ref, int *dim, short *ne, short *vol)
{
	int		K[3*8]={ 0,0,0, -1,0,0, -1,0,-1, 0,0,-1, 0,-1,0, -1,-1,0, -1,-1,-1, 0,-1,-1 };
	int		E=0,newE=0;
	int		Ecompl=0,newEcompl=0;
	int		i,i0,j0,k0;
	unsigned char local_complement;
	short	ne0[8],bit[8]={1,0,2,3,5,4,7,6};
	
	for(i=0;i<8;i++)
	{
		// Compute the Euler characteristic of the complement (because Euler uses 26-neighbours instead of 6-neighbours)
		i0=x+K[i*3+0];
		j0=y+K[i*3+1];
		k0=z+K[i*3+2];
		
		local_complement = 255-ne[k0*dim[1]*dim[0]+j0*dim[0]+i0];
		E+=Ref[ne[k0*dim[1]*dim[0]+j0*dim[0]+i0]];
		Ecompl+=Ref[local_complement];
		
		ne0[i]=ne[k0*dim[1]*dim[0]+j0*dim[0]+i0]&(0xff-(1<<bit[i]));
		local_complement = 255-ne0[i];
		newE=newE+Ref[ne0[i]];
		newEcompl = newEcompl + Ref[local_complement];
	}
	
	if(newE-E)		// voxel would change the topology: return
		return;
	
	// unset voxel
	vol[z*dim[1]*dim[0]+y*dim[0]+x]=0;
	for(i=0;i<8;i++)
	{
		i0=x+K[i*3+0];
		j0=y+K[i*3+1];
		k0=z+K[i*3+2];
		ne[k0*dim[1]*dim[0]+j0*dim[0]+i0]=ne0[i];
	}
}
-(void)tpErode:(int)iter
{
	int		*Ref;
	short	*tmp,*ne;
	int		i,j,k,l;
	int		a,b,c;
	
	// configure topology evaluation
	Ref=configureTable();	
	tmp=(short*)calloc(dim[0]*dim[1]*dim[2],sizeof(short));
	ne=(short*)calloc(dim[0]*dim[1]*dim[2],sizeof(short));
	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
	if(selection[i])
		tmp[i]=1;
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
		fillVertices(tmp,ne,dim,i,j,k);
	
	for(l=0;l<iter;l++)
	{
		// topology-preserving erode
		for(i=0;i<dim[0];i++)
		for(j=0;j<dim[1];j++)
		for(k=0;k<dim[2];k++)
		if(selection[k*dim[1]*dim[0]+j*dim[0]+i]==0)
		{
			for(a=-1;a<=1;a++)
			for(b=-1;b<=1;b++)
			for(c=-1;c<=1;c++)
			if(a*a+b*b+c*c<=1)
			if(	i+a>=0 && i+a<dim[0] &&
			   j+b>=0 && j+b<dim[1] &&
			   k+c>=0 && k+c<dim[2])
			if(selection[(k+c)*dim[1]*dim[0]+(j+b)*dim[0]+(i+a)]>0)
				tpErode_unset(i+a,j+b,k+c,Ref,dim,ne,tmp);
		}
		
		for(i=0;i<dim[0]*dim[1]*dim[2];i++)
			if(selection[i]>0 && tmp[i]==0)
				selection[i]=0;
	}
	free(tmp);
	free(ne);
}
-(void)translateMesh:(float)x :(float)y :(float)z
{
    int i;
    int np;
    int nt;
    float3D *p;
    int3D *t;
    
    if(mesh==nil)
        printf("ERROR: no mesh loaded");
    np=mesh->np;
    nt=mesh->nt;
    p=mesh->p;
    t=mesh->t;
    
    for(i=0;i<np;i++)
        p[i]=add3D(p[i],(float3D){x,y,z});
}
-(void)translateSelection:(int)a :(int)b :(int)c
{
    short	*tmp;
    int		i,j,k;
    
    tmp=(short*)calloc(dim[0]*dim[1]*dim[2],sizeof(short));

    for(i=0;i<dim[0]*dim[1]*dim[2];i++)
        tmp[i]=selection[i];

    for(i=0;i<dim[0];i++)
    for(j=0;j<dim[1];j++)
    for(k=0;k<dim[2];k++)
    if((k-c)>=0&&(k-c)<dim[2]&&(j-b)>=0&&(j-b)<dim[1]&&(i-a)>=0&&(i-a)<dim[0])
        selection[k*dim[1]*dim[0]+j*dim[0]+i]=tmp[(k-c)*dim[1]*dim[0]+(j-b)*dim[0]+(i-a)];
    else
        selection[k*dim[1]*dim[0]+j*dim[0]+i]=0;
    
    free(tmp);
}
-(void)undo
{
	printf("> undo\n");
	int		i;
	
	if(sindex==1)
		return;

	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
	if(selection[i]==sindex-1)
		selection[i]=0;
	sindex--;
}
-(void)voxeliseMesh
{
    int i,j,k,l;
    int np,nt;
    float3D *p;
    int3D *t;
    float *pixdim=&(hdr->pixdim[1]);
    float3D mi,ma;
    
    if(mesh==nil)
        printf("ERROR: no mesh loaded");
    np=mesh->np;
    nt=mesh->nt;
    p=mesh->p;
    t=mesh->t;
    
    // scale mesh to voxel dimensions
    for(i=0;i<np;i++)
    {
        p[i].x/=pixdim[0];
        p[i].y/=pixdim[1];
        p[i].z/=pixdim[2];
    }
    
    // scan triangles
    for(l=0;l<nt;l++)
    {
        mi.x=Min(Min(p[t[l].a].x,p[t[l].b].x),p[t[l].c].x);
        mi.y=Min(Min(p[t[l].a].y,p[t[l].b].y),p[t[l].c].y);
        mi.z=Min(Min(p[t[l].a].z,p[t[l].b].z),p[t[l].c].z);
        ma.x=Max(Max(p[t[l].a].x,p[t[l].b].x),p[t[l].c].x)+0.5;
        ma.y=Max(Max(p[t[l].a].y,p[t[l].b].y),p[t[l].c].y)+0.5;
        ma.z=Max(Max(p[t[l].a].z,p[t[l].b].z),p[t[l].c].z)+0.5;
        for(i=mi.x;i<=ma.x;i++)
        for(j=mi.y;j<=ma.y;j++)
        for(k=mi.z;k<=ma.z;k++)
        {
            if(!triBoxOverlap((float3D){i+0.5,j+0.5,k+0.5},l,mesh))
                continue;
            selection[k*dim[1]*dim[0]+j*dim[0]+i]=sindex;
        }
    }
    sindex++;

    // scale mesh back to world dimensions
    for(i=0;i<np;i++)
    {
        p[i].x*=pixdim[0];
        p[i].y*=pixdim[1];
        p[i].z*=pixdim[2];
    }

}
@end
