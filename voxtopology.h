/* Based on code from Franck Hetroy
 
Franck Hétroy, Stéphanie Rey, Carlos Andújar, Pere Brunet, Álvar Vinacua
"Mesh repair with user-friendly topology control"
INRIA, 655 avenue de l’Europe, F-38334 Saint Ismier, France
Phone: +33 476 615 504
Fax: + 33 476 615 466
*/

int euler(short *vol, int *dim);
void fillVertices(short *vol, short *ne, int *dim, int x, int y, int z);
int* configureTable(void);