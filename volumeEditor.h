/*
 *  volumeEditor.h
 *
 *  Created by rOBERTO tORO on 08/06/2006.
 *  Copyright 2006 __MyCompanyName__. All rights reserved.
 *
 */
typedef struct
{
	char	*selection;
	int		dim[3];
}Volume;

void box(int a, int b, int c, int d, int e, int f);
void getCrop(char **crop, int *cdim);
void getScaled(char **scaled, float factor, int *sdim);
void setThresholdWidth(float w);
void selectCoord(int x, int y, int z,float min, float max);
void deselect(void);
void undo(void);
void invert(void);
void stdevNeigh(int neigh, float maxstd);
void dilate(int a);
void erode(int a);
void set(float x);
void smooth(int level, int iter);
void smoothStep(char *mask, int level);
void boxFilter(int r);
void boxStdevNeigh(int r);
