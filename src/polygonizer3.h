/*
 * C code from the article
 * "An Implicit Surface Polygonizer"
 * http::www.unchainedgeometry.com/jbloom/papers/polygonizer.pdf
 * by Jules Bloomenthal, jules@bloomenthal.com
 * in "Graphics Gems IV", Academic Press, 1994 */

/* implicit.c
 *	 an implicit surface polygonizer, translated from Mesa
 *	 applications should call polygonize()
 *
 * To compile a test program for ASCII output:
 *	 cc implicit.c -o implicit -lm
 *
 * To compile a test program for display on an SGI workstation:
 *	 cc -DSGIGFX implicit.c -o implicit -lgl_s -lm
 *
 * Authored by Jules Bloomenthal, Xerox PARC.
 * Copyright (c) Xerox Corporation, 1991.  All rights reserved.
 * Permission is granted to reproduce, use and distribute this code for
 * any and all purposes, provided that this notice appears in all copies.  */

/* A Brief Explanation
 * The code consists of a test program and the polygonizer itself.
 *
 * In the test program:
 * torus(), sphere() and blob() are primitive functions used to calculate
 *	the implicit value at a point (x,y,z)
 * triangle() is a 'callback' routine that is called by the polygonizer
 *	whenever it produces a new triangle
 * to select torus, sphere or blob, change the argument to polygonize()
 * if openGL supported, open window, establish perspective and viewport,
 *	create closed line loops, during polygonization, and slowly spin object
 * if openGL not supported, output vertices and triangles to stdout
 *
 * The main data structures in the polygonizer represent a hexahedral lattice,
 * ie, a collection of semi-adjacent cubes, represented as cube centers, corners,
 * and edges. The centers and corners are three-dimensional indices rerpesented
 * by integer i,j,k. The edges are two three-dimensional indices, represented
 * by integer i1,j1,k1,i2,j2,k2. These indices and associated data are stored
 * in hash tables.
 *
 * The client entry to the polygonizer is polygonize(), called from main().
 * This routine first allocates memory for the hash tables for the cube centers,
 * corners, and edges that define the polygonizing lattice. It then finds a start
 * point, ie, the center of the first lattice cell. It pushes this cell onto an
 * initially empty stack of cells awaiting processing. It creates the first cell
 * by computing its eight corners and assigning them an implicit value.
 *
 * polygonize() then enters a loop in which a cell is popped from the stack,
 * becoming the 'active' cell c. c is (optionally) decomposed (ie, subdivided)
 * into six tetrahedra; within each transverse tetrahedron (ie, those that
 * intersect the surface), one or two triangles are produced.
 *
 * The six faces of c are tested for intersection with the implicit surface; for
 * a transverse face, a new cube is generated and placed on the stack.

 * Some of the more important routines include:
 *
 * testface (called by polygonize): test given face for surface intersection;
 *	if transverse, create new cube by creating four new corners.
 * setcorner (called by polygonize, testface): create new cell corner at given
 *	(i,j,k), compute its implicit value, and add to corners hash table.
 * find (called by polygonize): search for point with given polarity
 * dotet (called by polygonize) set edge vertices, output triangle by
 *	invoking callback
 *
 * The section Cubical Polygonization contains routines to polygonize directly
 * from the lattice cell rather than first decompose it into tetrahedra;
 * dotet, however, is recommended over docube.
 *
 * The section Storage provides routines to handle the linked lists
 * in the hash tables.
 *
 * The section Vertices contains the following routines.
 * vertid (called by dotet): given two corner indices defining a cell edge,
 *	test whether the edge has been stored in the hash table; if so, return its
 *	associated vertex index. If not, compute intersection of edge and implicit
 *	surface, compute associated surface normal, add vertex to mesh array, and
 *	update hash tables
 * converge (called by polygonize, vertid): find surface crossing on edge */

#define TET   0	/* use tetrahedral decomposition */
#define NOTET 1	/* no tetrahedral decomposition  */

typedef struct			/* a three-dimensional point */
{
	double x, y, z;		/* its coordinates */
}POINT;

typedef struct				/* surface triangle */
{
	int	i,j,k;				/* indices of the its vertices */
}TRIANGLE;
typedef struct				/* list of triangles in polygonization */
{
	int 		count,max;	/* # triangles, max # allowed */
	TRIANGLE	*ptr;		/* dynamically allocated */
}TRIANGLES;
typedef struct					/* surface vertex */
{
	POINT	position,normal;	/* position and surface normal */
} VERTEX;
typedef struct				/* list of vertices in polygonization */
{
	int		count,max;		/* # vertices, max # allowed */
	VERTEX	*ptr;			/* dynamically allocated */
}VERTICES;
typedef struct				/* corner of a cube */
{
	int		i, j, k;		/* (i, j, k) is index within lattice */
	double	x, y, z, value;	/* location and function value */
}CORNER;
typedef struct				/* partitioning cell (cube) */
{
	int i, j, k;			/* lattice location of cube */
	CORNER *corners[8];		/* eight corners */
}CUBE;
typedef struct cubes 		/* linked list of cubes acting as stack */
{
	CUBE			cube;	/* a single cube */
	struct cubes	*next;	/* remaining elements */
}CUBES;
typedef struct centerlist			/* list of cube locations */
{
	int					i, j, k;	/* cube location */
	struct centerlist	*next;		/* remaining elements */
}CENTERLIST;
typedef struct cornerlist			/* list of corners */
{
	int					i, j, k;	/* corner id */
	double				value;		/* corner value */
	struct cornerlist	*next;		/* remaining elements */
}CORNERLIST;
typedef struct edgelist						/* list of edges */
{
	int				i1, j1, k1, i2, j2, k2;	/* edge corner ids */
	int				vid;					/* vertex id */
	struct edgelist	*next;					/* remaining elements */
}EDGELIST;
typedef struct
{
	int		*dim;
	float	*pix;
	int		datatype;
	char	*vol;
}VOLUME;
typedef struct		// RT: Garbage collection
{
	long	ptr;
	long	next;
}Trash;
typedef struct process			/* parameters, function, storage */
{
	double		size,delta;		/* cube size, normal delta */
	int			bounds;			/* cube range within lattice */
	POINT		start;			/* start point on surface */
	CUBES		*cubes;			/* active cubes */
	TRIANGLES	triangles;		/* surface triangles */
	VERTICES	vertices;		/* surface vertices */
	CENTERLIST	**centers;		/* cube center hash table */
	CORNERLIST	**corners;		/* corner value hash table */
	EDGELIST	**edges;		/* edge and vertex id hash table */
	Trash		*trash;
}PROCESS;

char *polygonize (PROCESS *p,VOLUME *vol,double size,int bounds,double x,double y,double z,int mode);
void freeprocess(PROCESS p);