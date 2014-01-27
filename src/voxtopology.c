#include <stdio.h>
#include <stdlib.h>

int Ref[256];

// Creation of reference table to calculate X
int* configureTable(void)
{	
	Ref[0x00] = 0;// 0 neighbour voxel over MD => X = 0 localement
	Ref[0x01] = 1;// 1 voxel
	Ref[0x02] = 1;// 1 voxel
	Ref[0x03] = 0;// 2 contiguous voxels
	Ref[0x04] = 1;// 1 voxel
	Ref[0x05] = 0;// 2 contiguous voxels
	Ref[0x06] = -2;// 2 voxels
	Ref[0x07] = -1;// 3 contiguous voxels
	Ref[0x08] = 1;// 1 voxel
	Ref[0x09] = -2;// 2 voxels
	Ref[0x0A] = 0;// 2 contiguous voxels
	Ref[0x0B] = -1;// 3 contiguous voxels
	Ref[0x0C] = 0;// 2 contiguous voxels
	Ref[0x0D] = -1;// 3 contiguous voxels
	Ref[0x0E] = -1;// 3 contiguous voxels
	Ref[0x0F] = 0;// 4 voxels in a block
	Ref[0x10] = 1;// 1 voxel
	Ref[0x11] = 0;// 2 contiguous voxels
	Ref[0x12] = -2;// 2 voxels
	Ref[0x13] = -1;// 3 contiguous voxels
	Ref[0x14] = -2;// 2 voxels
	Ref[0x15] = -1;// 3 contiguous voxels
	Ref[0x16] = -1;// 3 voxels
	Ref[0x17] = -2;// 4 voxels : 1 et 3 face connectés à lui
	Ref[0x18] = -6;// 2 voxels sommet connectés
	Ref[0x19] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x1A] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x1B] = -2;// 4 voxels face connectée en tortillon
	Ref[0x1C] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x1D] = -2;// 4 voxels face connectée en tortillon
	Ref[0x1E] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux 
	Ref[0x1F] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0x20] = 1;// 1 voxel
	Ref[0x21] = -2;// 2 voxels
	Ref[0x22] = 0;// 2 contiguous voxels
	Ref[0x23] = -1;// 3 contiguous voxels
	Ref[0x24] = -6;// 2 voxels sommet connectés
	Ref[0x25] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x26] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x27] = -2;// 4 voxels face connectée en tortillon
	Ref[0x28] = -2;// 2 voxels
	Ref[0x29] = -1;// 3 voxels
	Ref[0x2A] = -1;// 3 contiguous voxels
	Ref[0x2B] = -2;// 4 voxels : 1 et 3 face connectés à lui
	Ref[0x2C] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x2D] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x2E] = -2;// 4 voxels face connectée en tortillon
	Ref[0x2F] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0x30] = 0;// 2 contiguous voxels
	Ref[0x31] = -1;// 3 contiguous voxels
	Ref[0x32] = -1;// 3 contiguous voxels
	Ref[0x33] = 0;// 4 voxels en bloc
	Ref[0x34] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x35] = -2;// 4 voxels face connectée en tortillon
	Ref[0x36] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x37] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0x38] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x39] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x3A] = -2;// 4 voxels face connectée en tortillon
	Ref[0x3B] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0x3C] = 0;// 4 voxels : 2 blocs de 2 arete-connecté
	Ref[0x3D] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0x3E] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0x3F] = 0;// 6 voxels : 2 autres contiguous
	Ref[0x40] = 1;// 1 voxel
	Ref[0x41] = -6;// 2 voxels sommet connectés
	Ref[0x42] = -2;// 2 voxels
	Ref[0x43] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x44] = -2;// 2 voxels
	Ref[0x45] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x46] = -1;// 3 voxels
	Ref[0x47] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x48] = 0;// 2 contiguous voxels
	Ref[0x49] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x4A] = -1;// 3 contiguous voxels
	Ref[0x4B] = -2;// 4 voxels face connectée en tortillon
	Ref[0x4C] = -1;// 3 contiguous voxels
	Ref[0x4D] = -2;// 4 voxels face connectée en tortillon
	Ref[0x4E] = -2;// 4 voxels : 1 et 3 face connectés à lui
	Ref[0x4F] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0x50] = -2;// 2 voxels
	Ref[0x51] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x52] = -1;// 3 voxels
	Ref[0x53] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x54] = -1;// 3 voxels
	Ref[0x55] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x56] = 4;// 4 voxels : 1 dans chaque angle
	Ref[0x57] = 3;// 5 voxels
	Ref[0x58] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x59] = 0;// 4 voxels : 2 blocs de 2 arete-connecté
	Ref[0x5A] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x5B] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0x5C] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x5D] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0x5E] = 3;// 5 voxels
	Ref[0x5F] = 2;// 6 voxels
	Ref[0x60] = 0;// 2 contiguous voxels
	Ref[0x61] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x62] = -1;// 3 contiguous voxels
	Ref[0x63] = -2;// 4 voxels face connectée en tortillon
	Ref[0x64] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x65] = 0;// 4 voxels : 2 blocs de 2 arete-connecté
	Ref[0x66] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x67] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0x68] = -1;// 3 contiguous voxels
	Ref[0x69] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x6A] = 0;// 4 voxels en bloc
	Ref[0x6B] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0x6C] = -2;// 4 voxels face connectée en tortillon
	Ref[0x6D] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0x6E] = -1;// 5 voxels : les 3 autres contiguous;
	Ref[0x6F] = 0;// 6 voxels : 2 autres contiguous
	Ref[0x70] = -1;// 3 contiguous voxels
	Ref[0x71] = -2;// 4 voxels face connectée en tortillon
	Ref[0x72] = -2;// 4 voxels : 1 et 3 face connectés à lui
	Ref[0x73] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0x74] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x75] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0x76] = 3;// 5 voxels
	Ref[0x77] = 2;// 6 voxels
	Ref[0x78] = -2;// 4 voxels face connectée en tortillon
	Ref[0x79] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0x7A] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0x7B] = 0;// 6 voxels : 2 autres contiguous
	Ref[0x7C] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0x7D] = 2;// 6 voxels : 2 autres opposés
	Ref[0x7E] = 2;// 6 voxels
	Ref[0x7F] = 1;// 7 voxels
	Ref[0x80] = 1;// 1 voxel
	Ref[0x81] = -2;// 2 voxels
	Ref[0x82] = -6;// 2 voxels sommet connectés
	Ref[0x83] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x84] = 0;// 2 contiguous voxels
	Ref[0x85] = -1;// 3 contiguous voxels
	Ref[0x86] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x87] = -2;// 4 voxels face connectée en tortillon
	Ref[0x88] = -2;// 2 voxels
	Ref[0x89] = -1;// 3 voxels
	Ref[0x8A] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x8B] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x8C] = -1;// 3 contiguous voxels
	Ref[0x8D] = -2;// 4 voxels : 1 et 3 face connectés à lui
	Ref[0x8E] = -2;// 4 voxels face connectée en tortillon
	Ref[0x8F] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0x90] = 0;// 2 contiguous voxels
	Ref[0x91] = -1;// 3 contiguous voxels
	Ref[0x92] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x93] = -2;// 4 voxels face connectée en tortillon
	Ref[0x94] = -1;// 3 contiguous voxels
	Ref[0x95] = 0;// 4 voxels en bloc
	Ref[0x96] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x97] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0x98] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0x99] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0x9A] = 0;// 4 voxels : 2 blocs de 2 arete-connecté
	Ref[0x9B] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0x9C] = -2;// 4 voxels face connectée en tortillon
	Ref[0x9D] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0x9E] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0x9F] = 0;// 6 voxels : 2 autres contiguous
	Ref[0xA0] = -2;// 2 voxels
	Ref[0xA1] = -1;// 3 voxels
	Ref[0xA2] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0xA3] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0xA4] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0xA5] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0xA6] = 0;// 4 voxels : 2 blocs de 2 arete-connecté
	Ref[0xA7] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0xA8] = -1;// 3 voxels
	Ref[0xA9] = 4;// 4 voxels : 1 dans chaque angle
	Ref[0xAA] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0xAB] = 3;// 5 voxels
	Ref[0xAC] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0xAD] = 3;// 5 voxels
	Ref[0xAE] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0xAF] = 2;// 6 voxels
	Ref[0xB0] = -1;// 3 contiguous voxels
	Ref[0xB1] = -2;// 4 voxels : 1 et 3 face connectés à lui
	Ref[0xB2] = -2;// 4 voxels face connectée en tortillon
	Ref[0xB3] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0xB4] = -2;// 4 voxels face connectée en tortillon
	Ref[0xB5] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0xB6] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0xB7] = 0;// 6 voxels : 2 autres contiguous
	Ref[0xB8] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0xB9] = 3;// 5 voxels
	Ref[0xBA] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0xBB] = 2;// 6 voxels
	Ref[0xBC] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0xBD] = 2;// 6 voxels
	Ref[0xBE] = 2;// 6 voxels : 2 autres opposés
	Ref[0xBF] = 1;// 7 voxels
	Ref[0xC0] = 0;// 2 contiguous voxels
	Ref[0xC1] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0xC2] = -3;// 3 voxels : 2 contiguous et 1 arete connectée
	Ref[0xC3] = 0;// 4 voxels : 2 blocs de 2 arete-connecté
	Ref[0xC4] = -1;// 3 contiguous voxels
	Ref[0xC5] = -2;// 4 voxels face connectée en tortillon
	Ref[0xC6] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0xC7] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0xC8] = -1;// 3 contiguous voxels
	Ref[0xC9] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0xCA] = -2;// 4 voxels face connectée en tortillon
	Ref[0xCB] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0xCC] = 0;// 4 voxels en bloc
	Ref[0xCD] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0xCE] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0xCF] = 0;// 6 voxels : 2 autres contiguous
	Ref[0xD0] = -1;// 3 contiguous voxels
	Ref[0xD1] = -2;// 4 voxels face connectée en tortillon
	Ref[0xD2] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0xD3] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0xD4] = -2;// 4 voxels : 1 et 3 face connectés à lui
	Ref[0xD5] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0xD6] = 3;// 5 voxels
	Ref[0xD7] = 2;// 6 voxels
	Ref[0xD8] = -2;// 4 voxels face connectée en tortillon
	Ref[0xD9] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0xDA] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0xDB] = 2;// 6 voxels : 2 autres opposés
	Ref[0xDC] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0xDD] = 0;// 6 voxels : 2 autres contiguous
	Ref[0xDE] = 2;// 6 voxels
	Ref[0xDF] = 1;// 7 voxels
	Ref[0xE0] = -1;// 3 contiguous voxels
	Ref[0xE1] = 0;// 4 voxels : 3 voxels face connectée et 1 arÍte-connecté à eux
	Ref[0xE2] = -2;// 4 voxels face connectée en tortillon
	Ref[0xE3] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0xE4] = -2;// 4 voxels face connectée en tortillon
	Ref[0xE5] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0xE6] = 1;// 5 voxels : 2 autres contiguous et 3eme arrete-connecté
	Ref[0xE7] = 2;// 6 voxels : 2 autres opposés
	Ref[0xE8] = -2;// 4 voxels : 1 et 3 face connectés à lui
	Ref[0xE9] = 3;// 5 voxels
	Ref[0xEA] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0xEB] = 2;// 6 voxels
	Ref[0xEC] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0xED] = 2;// 6 voxels
	Ref[0xEE] = 0;// 6 voxels : 2 autres contiguous
	Ref[0xEF] = 1;// 7 voxels
	Ref[0xF0] = 0;// 4 voxels en bloc
	Ref[0xF1] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0xF2] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0xF3] = 0;// 6 voxels : 2 autres contiguous
	Ref[0xF4] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0xF5] = 0;// 6 voxels : 2 autres contiguous
	Ref[0xF6] = 2;// 6 voxels
	Ref[0xF7] = 1;// 7 voxels
	Ref[0xF8] = -1;// 5 voxels : les 3 autres contiguous
	Ref[0xF9] = 2;// 6 voxels
	Ref[0xFA] = 0;// 6 voxels : 2 autres contiguous
	Ref[0xFB] = 1;// 7 voxels
	Ref[0xFC] = 0;// 6 voxels : 2 autres contiguous
	Ref[0xFD] = 1;// 7 voxels
	Ref[0xFE] = 1;// 7 voxels
	Ref[0xFF] = 0;// 8 voxels
	
	return Ref;
}

int calcEuler(short *ne, int *dim)
{
	int		X=dim[0];
	int		Y=dim[1];
	int		Z=dim[2];
	int		E=0;
	int		Ecompl=0;
	int		i,j,k;
	unsigned char local_complement;

	for(i=0;i<X;i++)
	for(j=0;j<Y;j++)
	for(k=0;k<Z;k++)
	{
		// We compute the Euler characteristic of the complement (because Euler uses 26-neighbours instead of 6-neighbours)
		local_complement = 255-ne[k*Y*X+j*X+i];
		E=E+Ref[ne[k*Y*X+j*X+i]];
		Ecompl = Ecompl + Ref[local_complement];
	}
	if(E-8*(E/8) != 0)
	{
		printf("ERROR: Bad Euler characteristic: %i\n",E);
		return 1;
	}
	if(Ecompl-8*(Ecompl/8) != 0)
	{
		printf("ERROR: Bad Euler characteristic complement: %i\n",Ecompl);
		return 1;
	}
	E = E/8;

	return E;
}
void fillVertices(short *vol, short *ne, int *dim, int x, int y, int z)
{
	int	X=dim[0];
	int	Y=dim[1];
	
	if(x>=X-1 || y>=Y-1 || z>=dim[2]-1)
		return;
	
	ne[z*Y*X+y*X+x] |= vol[z*Y*X+y*X+x]<<1;
	ne[z*Y*X+y*X+x] |= vol[z*Y*X+y*X+(x+1)]<<0; 
	ne[z*Y*X+y*X+x] |= vol[(z+1)*Y*X+y*X+(x+1)]<<2;
	ne[z*Y*X+y*X+x] |= vol[(z+1)*Y*X+y*X+x]<<3;
	ne[z*Y*X+y*X+x] |= vol[z*Y*X+(y+1)*X+x]<<5; 
	ne[z*Y*X+y*X+x] |= vol[z*Y*X+(y+1)*X+(x+1)]<<4; 
	ne[z*Y*X+y*X+x] |= vol[(z+1)*Y*X+(y+1)*X+(x+1)]<<7;
	ne[z*Y*X+y*X+x] |= vol[(z+1)*Y*X+(y+1)*X+x]<<6;
}
int euler(short *vol, int *dim)
{
	short	*tmp,*ne;
	int		i,x,y,z;
	int		X;
	
	configureTable();
	
	tmp=(short*)calloc(dim[0]*dim[1]*dim[2],sizeof(short));
	ne=(short*)calloc(dim[0]*dim[1]*dim[2],sizeof(short));
	for(i=0;i<dim[0]*dim[1]*dim[2];i++)
		if(vol[i])
			tmp[i]=1;
	for(x=0;x<dim[0];x++)
	for(y=0;y<dim[1];y++)
	for(z=0;z<dim[2];z++)
		fillVertices(tmp,ne,dim,x,y,z);
	free(tmp);
	X=calcEuler(ne,dim);
	free(ne);
	
	return X;
}
