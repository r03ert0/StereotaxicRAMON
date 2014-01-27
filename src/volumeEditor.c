/*
 *  volumeEditor.c
 *
 *  Created by rOBERTO tORO on 08/06/2006.
 *  Copyright 2006 __MyCompanyName__. All rights reserved.
 *
 */

#include "volumeEditor.h"

void box(Volume *v,int a, int b, int c, int d, int e, int f)
{
	int	i,j,k;
	
	for(i=a;i<=d;i++)
	for(j=b;j<=e;j++)
	for(k=c;k<=f;k++)
	if(i>=0&&i<dim[0] && j>=0&&j<dim[1] && k>=0&&k<dim[2])
		selection[k*dim[1]*dim[0]+j*dim[0]+i]=sindex;
	sindex++;
}
void getCrop(char **crop, int *cdim)
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
	}
}
void getScaled(char **scaled float factor, int *sdim)
{
	int	i,j,k;
	sdim[0]=ceil(dim[0]*f);
	sdim[1]=ceil(dim[1]*f);
	sdim[2]=ceil(dim[2]*f);

	switch(dataType)
	{
		case UCHAR:
			*scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(char));
			for(i=0;i<sdim[0];i++)
			for(j=0;j<sdim[1];j++)
			for(k=0;k<sdim[2];k++)
				((unsigned char*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=((unsigned char*)data)[((int)(k/f))*dim[1]*dim[0]+((int)(j/f))*dim[0]+(int)(i/f)];
			break;
		case SHORT:
			*scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(short));
			for(i=0;i<sdim[0];i++)
			for(j=0;j<sdim[1];j++)
			for(k=0;k<sdim[2];k++)
				((short*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=((short*)data)[((int)(k/f))*dim[1]*dim[0]+((int)(j/f))*dim[0]+(int)(i/f)];
			break;
		case INT:
			*scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(int));
			for(i=0;i<sdim[0];i++)
			for(j=0;j<sdim[1];j++)
			for(k=0;k<sdim[2];k++)
				((int*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=((int*)data)[((int)(k/f))*dim[1]*dim[0]+((int)(j/f))*dim[0]+(int)(i/f)];
			break;
		case FLOAT:
			*scaled=calloc(sdim[2]*sdim[1]*sdim[0],sizeof(float));
			for(i=0;i<sdim[0];i++)
			for(j=0;j<sdim[1];j++)
			for(k=0;k<sdim[2];k++)
				((float*)*scaled)[k*sdim[1]*sdim[0]+j*sdim[0]+i]=((float*)data)[((int)(k/f))*dim[1]*dim[0]+((int)(j/f))*dim[0]+(int)(i/f)];
			break;
	}
}
void setThresholdWidth(float w)
{
	thresholdWidth=w;
}
#define STACK 600000
void selectCoord(int x, int y, int z,float min, float max)
{
	printf("> select\n");
	int		n,k;
	int		dx,dy,dz;
	int		dire[6]={0,0,0,0,0,0};
	int		nstack=0;
	short	stack[STACK][3];
	char	dstack[STACK];
	int		empty,mark;
	int		val;
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
}
void deselect(void)
{
	printf("> deselect\n");
	int		i;
	
	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
		selection[i]=0;
	sindex=1;
}
void undo(void)
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
void invert(void)
{
	printf("> invert\n");
	int		i;
	
	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
		selection[i]=1-(selection[i]>0);
	sindex=2;
}
void stdevNeigh(int neigh, float maxstd)
{
	printf("> std\n");
    int				x,y,z,i,j,k;
	float			tmp[3],tmpd[3],tmpx[3];
	int				dim1[3],x1,y1,z1;
	float			val;
	unsigned char	c[3];
	float			*P,invP[16],n,s,ss,std;
	float			mx,mn;
	
	switch(plane)
	{
		case 1: P=C; break;
		case 2: P=S; break;
		case 3: P=A; break;
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
    unsigned char *baseaddr=[bmp bitmapData];
	
	z=(slice/100.0)*(dim1[2]-1);
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
		colourmap(std/maxstd,c,JET);
		baseaddr[y*[bmp bytesPerRow]+4*x+0]=c[0];
		baseaddr[y*[bmp bytesPerRow]+4*x+1]=c[1];
		baseaddr[y*[bmp bytesPerRow]+4*x+2]=c[2];
		baseaddr[y*[bmp bytesPerRow]+4*x+3]=255;
		
	}
    image = [NSImage new];
    [image addRepresentation:bmp];
	printf("stdev in [%f,%f]\n",mn,mx);
}
void dilate(int a)
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
void erode(int a)
{
	printf("> erode\n");
	int		i,j,k;
	int		a,b,c;
	char	*tmp=calloc(dim[0]*dim[1]*dim[2],1);
	
	for(i=0;i<dim[0]*dim[1]*dim[2];i++) tmp[i]=selection[i];

	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	if(selection[k*dim[1]*dim[0]+j*dim[0]+i]==0)
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

	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
	if(selection[i]>0 && tmp[i]==0)
		selection[i]=0;
	free(tmp);
}
void set(float x)
{
	printf("> set\n");
	int		i,j,k;
	
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	if(selection[k*dim[1]*dim[0]+j*dim[0]+i]>0)
		[self setValue:val at:i:j:k];
}
void smooth(int level, int iter)
{
	int		i;
	char	kwhite=4; // voxel is selected
	char	*mask=calloc(dim[0]*dim[1]*dim[2],1);
	
	for(i=0;i<dim[2]*dim[1]*dim[0];i++)
		mask[i]=kwhite*(selection[i]>0);
		
	for(i=0;i<iter;i++)
		[self smoothStep:mask:level];
	
	for(i=0;i<dim[2]*dim[1]*dim[0];i++)
		selection[i]=sindex*(mask[i]&kwhite);
	sindex++;

	free(mask);
}
void smoothStep(char *mask, int level)
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
void boxFilter(int r)
{
	int	i,j,k;
	int	sum,val;
	int	*tmpx=(int*)calloc(dim[0]*dim[1]*dim[2],sizeof(int));
	int	*tmpy=(int*)calloc(dim[0]*dim[1]*dim[2],sizeof(int));
	int	*tmpz=(int*)calloc(dim[0]*dim[1]*dim[2],sizeof(int));
	
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
void boxStdevNeigh(int r)
{
	int	i,j,k;
	int	*tmpn=(int*)calloc(dim[0]*dim[1]*dim[2],sizeof(int));
	int	*tmp0=(int*)calloc(dim[0]*dim[1]*dim[2],sizeof(int));
	int	*tmpv=(int*)calloc(dim[0]*dim[1]*dim[2],sizeof(int));
	int	n,v,v2,std;
	
	// 1. store original values
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
		tmp0[k*dim[1]*dim[0]+j*dim[0]+i]=[self getValueAt:i:j:k];
	
	// 2. compute the size of the neighbourhoods
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
		[self setValue:1 at:i:j:k];
	boxFilter(r);
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
		n[k*dim[1]*dim[0]+j*dim[0]+i]=[self getValueAt:i:j:k];
	
	// 3. compute local sum of values
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
		[self setValue:(float)tmp0[k*dim[1]*dim[0]+j*dim[0]+i] at:i:j:k];
	boxFilter(r);

	// 4. store sum of values, then compute local sum of values^2
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	{
		tmpv[k*dim[1]*dim[0]+j*dim[0]+i]=[self getValueAt:i:j:k];
		[self setValue:pow(tmp0[k*dim[1]*dim[0]+j*dim[0]+i],2) at:i:j:k];
	}
	boxFilter(r);
	
	// 5. compute local standard deviation
	for(i=0;i<dim[0];i++)
	for(j=0;j<dim[1];j++)
	for(k=0;k<dim[2];k++)
	{
		n=tmpn[k*dim[1]*dim[0]+j*dim[0]+i];
		v=tmpv[k*dim[1]*dim[0]+j*dim[0]+i];
		v2=[self getValueAt:i:j:k];
		std=sqrt((n*ss-s*s)/n/(n-1));
		
		[self setValue:(float)std at:i:j:k];
	}
}