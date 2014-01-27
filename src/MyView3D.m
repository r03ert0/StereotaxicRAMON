#import "MyView3D.h"

@implementation MyView3D

- (id)initWithFrame:(NSRect)frame
{
    GLuint attribs[] = 
    {
            NSOpenGLPFANoRecovery,
            NSOpenGLPFAWindow,
            NSOpenGLPFAAccelerated,
            NSOpenGLPFADoubleBuffer,
            NSOpenGLPFAColorSize, 24,
            NSOpenGLPFAAlphaSize, 8,
            NSOpenGLPFADepthSize, 24,
            //NSOpenGLPFAStencilSize, 8,
            NSOpenGLPFAAccumSize, 0,
            0
    };

    NSOpenGLPixelFormat* fmt = [[NSOpenGLPixelFormat alloc] initWithAttributes: (NSOpenGLPixelFormatAttribute*) attribs];
    
    self = [super initWithFrame:frame pixelFormat:[fmt autorelease]];
    if (!fmt)	NSLog(@"No OpenGL pixel format");
    [[self openGLContext] makeCurrentContext];
    
    // initialize the trackball
    m_trackball = [[Trackball alloc] init];
    m_rotation[0]=0.0; // angle
    m_rotation[1]=0.0; // x
    m_rotation[2]=1.0; // y
    m_rotation[3]=0.0; // z

    // init opengl
    glEnable(GL_SMOOTH);
	
	// init mesh
	np=nt=0;
	p=nil;
	t=nil;
	
	zoom=80;
    
    xslice=yslice=zslice=-1;
    
    return self;
}
- (void)drawRect:(NSRect)rect
{
    float	aspectRatio;
    
    if(p==nil)
		return;
	
	[self update];

    // init projection
        glViewport(0, 0, (GLsizei) rect.size.width, (GLsizei) rect.size.height);
        glClearColor(1,1,1, 1);
        glClear(GL_COLOR_BUFFER_BIT+GL_DEPTH_BUFFER_BIT+GL_STENCIL_BUFFER_BIT);
        glMatrixMode(GL_PROJECTION);
        glLoadIdentity();
        aspectRatio = (float)rect.size.width/(float)rect.size.height;
        //glOrtho(-aspectRatio*zoom, aspectRatio*zoom, -zoom, zoom, -1000.0, 1000.0);
        glOrtho(-aspectRatio*zoom, aspectRatio*zoom, -zoom, zoom, -crop, 500.0);

    // prepare drawing
        glMatrixMode(GL_MODELVIEW);
        glLoadIdentity();
        gluLookAt (0,0,-10, 0,0,0, 0,1,0); // eye,center,updir
        glRotatef(m_tbRot[0],m_tbRot[1], m_tbRot[2], m_tbRot[3]);
        glRotatef(m_rotation[0],m_rotation[1], m_rotation[2], m_rotation[3]);

    // draw mesh
        glEnable(GL_DEPTH_TEST);
    glDisable (GL_BLEND);
        glEnableClientState( GL_VERTEX_ARRAY);
		glVertexPointer( 3, GL_FLOAT, 0, p );
		glEnableClientState( GL_COLOR_ARRAY );
		glColorPointer( 3, GL_FLOAT, 0, c );
		glDrawElements( GL_TRIANGLES, nt*3, GL_UNSIGNED_INT, t );
		glDisableClientState( GL_VERTEX_ARRAY);
	
    // draw planes
        int	i;
        float	min[3],max[3];
        float	x,y,z;
        min[0]=min[1]=min[2]=max[0]=max[1]=max[2]=0;
        for(i=0;i<np;i++)
        {
            if(p[3*i+0]<min[0]) min[0]=p[3*i+0];
            if(p[3*i+1]<min[1]) min[1]=p[3*i+1];
            if(p[3*i+2]<min[2]) min[2]=p[3*i+2];
            if(p[3*i+0]>max[0]) max[0]=p[3*i+0];
            if(p[3*i+1]>max[1]) max[1]=p[3*i+1];
            if(p[3*i+2]>max[2]) max[2]=p[3*i+2];
        }
        glEnable (GL_BLEND);
        glBlendFunc (GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
        glBegin(GL_TRIANGLES);
        x=xslice*pix[0]-o[0];
        y=yslice*pix[1]-o[1];
        z=zslice*pix[2]-o[2];
        if([checkXPlane intValue])
        {
            glColor4f(1,0.8,0.8,0.5);
            glVertex3f(x,min[1],min[2]);	glVertex3f(x,max[1],min[2]);	glVertex3f(x,max[1],max[2]);
            glVertex3f(x,min[1],min[2]);	glVertex3f(x,min[1],max[2]);	glVertex3f(x,max[1],max[2]);
        }
        if([checkYPlane intValue])
        {
            glColor4f(0.8,1,0.8,0.5);
            glVertex3f(min[0],y,min[2]);	glVertex3f(max[0],y,min[2]);	glVertex3f(max[0],y,max[2]);
            glVertex3f(min[0],y,min[2]);	glVertex3f(min[0],y,max[2]);	glVertex3f(max[0],y,max[2]);
        }
        if([checkZPlane intValue])
        {
            glColor4f(0.8,0.8,1,0.5);
            glVertex3f(min[0],min[1],z);	glVertex3f(max[0],min[1],z);	glVertex3f(max[0],max[1],z);
            glVertex3f(min[0],min[1],z);	glVertex3f(min[0],max[1],z);	glVertex3f(max[0],max[1],z);
        }
        glEnd();
	

    [[self openGLContext] flushBuffer];
}
-(void)rotateBy:(float *)r
{
    m_tbRot[0] = r[0];
    m_tbRot[1] = r[1];
    m_tbRot[2] = r[2];
    m_tbRot[3] = r[3];
}
-(void)mouseDown:(NSEvent *)theEvent
{
	// event: rotate
	[m_trackball  start:[theEvent locationInWindow] sender:self];
}
- (void)mouseUp:(NSEvent *)theEvent
{
    // Accumulate the trackball rotation
    // into the current rotation.
    [m_trackball add:m_tbRot toRotation:m_rotation];

    m_tbRot[0]=0;
    m_tbRot[1]=1;
    m_tbRot[2]=0;
    m_tbRot[3]=0;
}
- (void)mouseDragged:(NSEvent *)theEvent
{
    [self lockFocus];
	[m_trackball rollTo:[theEvent locationInWindow] sender:self];
    [self unlockFocus];
	[self setNeedsDisplay:YES];
}
#pragma mark -
-(IBAction)setStandardRotation:(id)sender
{
	int	tag=[[sender selectedCell] tag];
    
    m_rotation[0] = m_tbRot[0] = 0.0;
    m_rotation[1] = m_tbRot[1] = 0.0;
    m_rotation[2] = m_tbRot[2] = 1.0;
    m_rotation[3] = m_tbRot[3] = 0.0;
    
    switch(tag)
    {
		case 1:m_rotation[0]= 90;	m_rotation[1]=1;m_rotation[2]=0; break; //sup
        case 4:m_rotation[0]= 90;	break; //frn
        case 5:m_rotation[0]=  0;	break; //lat
        case 6:m_rotation[0]=270;	break; //pos
        case 7:m_rotation[0]=180;	break; //med
        case 9:m_rotation[0]=270;	m_rotation[1]=1;m_rotation[2]=0; break; //inf
    }
    
    [self setNeedsDisplay:YES];
}
-(IBAction)changeView:(id)sender
{
	switch([sender tag])
	{
		case 1:			// reset button
			break;
		case 2:			// x stepper
			break;
		case 3:			// y stepper
			break;
		case 4:			// z stepper
			break;
		case 5:			// zoom slider
			zoom=80*pow(2,-[sender floatValue]);
			break;
		case 6:			// zoom slider
			crop=[sender floatValue];
			break;
	}
	[self setNeedsDisplay:YES];
}
-(void)newMesh:(int)mynp :(int)mynt :(float**)myp :(int**)myt :(int *)mydim;
{
	if(p)
		free(p);
	if(t)
		free(t);
	p=(float*)calloc(mynp*3,sizeof(float));
	t=(int*)calloc(mynt*3,sizeof(int));
	np=mynp;
	nt=mynt;
	*myp=p;
	*myt=t;
    
    dim[0]=mydim[0];
    dim[1]=mydim[1];
    dim[2]=mydim[2];
    if(xslice<0)
        xslice=dim[0]/2;
    if(yslice<0)
        yslice=dim[1]/2;
    if(zslice<0)
        zslice=dim[2]/2;
}
-(void)setOrigin:(float*)origin
{
	o[0]=origin[0];
	o[1]=origin[1];
	o[2]=origin[2];
}
-(void)depth
{
	int		i;
	float	pmin[3],pmax[3];
	float	d,max;
	
	// configure surface depth
	if(c)
		free(c);
	c=(float*)calloc(3*np,sizeof(float));
	pmin[0]=pmax[0]=p[0];
	pmin[1]=pmax[1]=p[1];
	pmin[2]=pmax[2]=p[2];
	for(i=0;i<np;i++)
	{
		if(p[3*i+0]<pmin[0])	pmin[0]=p[3*i+0];
		if(p[3*i+1]<pmin[1])	pmin[1]=p[3*i+1];
		if(p[3*i+2]<pmin[2])	pmin[2]=p[3*i+2];
		if(p[3*i+0]>pmax[0])	pmax[0]=p[3*i+0];
		if(p[3*i+1]>pmax[1])	pmax[1]=p[3*i+1];
		if(p[3*i+2]>pmax[2])	pmax[2]=p[3*i+2];
	}

	max=0;
	for(i=0;i<np;i++)
	{
		d=	pow(2*(p[3*i+0]-o[0])/(pmax[0]-pmin[0]),2) +
			pow(2*(p[3*i+1]-o[1])/(pmax[1]-pmin[1]),2) +
			pow(2*(p[3*i+2]-o[2])/(pmax[2]-pmin[2]),2);
		
		p[3*i+0]-=o[0];
		p[3*i+1]-=o[1];
		p[3*i+2]-=o[2];

		c[3*i+0]=c[3*i+1]=c[3*i+2]=sqrt(d);
		if(sqrt(d)>max)
			max=sqrt(d);
	}
	max*=1.05;	// pure white is not nice...
	for(i=0;i<np;i++)
		c[3*i+0]=c[3*i+1]=c[3*i+2]=c[3*i+0]/max;
}
-(void)setXSlice:(float)x
{
	xslice=x;
	[self setNeedsDisplay:YES];
}
-(void)setYSlice:(float)y
{
	yslice=y;
	[self setNeedsDisplay:YES];
}
-(void)setZSlice:(float)z
{
	zslice=z;
	[self setNeedsDisplay:YES];
}
-(void)setScale:(float)theScale
{
	scale=theScale;
}
-(void)setPixdim:(float*)thePixdim
{
	pix[0]=thePixdim[0];
	pix[1]=thePixdim[1];
	pix[2]=thePixdim[2];
}
@end
