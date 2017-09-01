class Voxel{

    Vertex[] voxelVertex;
    Edge[] voxelEdges;
    int cubeIndex = 0;

    Voxel(PVector position, int scale){

        voxelVertex = new Vertex[8];
        voxelEdges = new Edge[12];
        createVertex(position.x, position.y, position.z, scale);
        createEdges();

    }

    void createEdges(){
        
        for (int i=0; i<4; i++){
            voxelEdges[i] = new Edge(voxelVertex[i], voxelVertex[(i+1)%4]);
        }
        for (int i=4; i<8; i++){
            voxelEdges[i] = new Edge(voxelVertex[i], voxelVertex[(i+1)%4 + 4 ]);
        }
        for (int i=0; i<4; i++){
            voxelEdges[i+8] = new Edge(voxelVertex[i], voxelVertex[(i+4)]);
        }
    }

    void createVertex(float i, float j, float k, float s){
        voxelVertex[0] = new Vertex(i  , j  , k  , s);
        voxelVertex[1] = new Vertex(i+1, j  , k  , s);
        voxelVertex[2] = new Vertex(i+1, j+1, k  , s);
        voxelVertex[3] = new Vertex(i  , j+1, k  , s);

        voxelVertex[4] = new Vertex(i  , j  , k+1, s);
        voxelVertex[5] = new Vertex(i+1, j  , k+1, s);
        voxelVertex[6] = new Vertex(i+1, j+1, k+1, s);
        voxelVertex[7] = new Vertex(i  , j+1, k+1, s);
    }

    void drawVertex(){
        textSize(15);
        for(int i = 0; i < 8 ; i++){
            text("v"+i, voxelVertex[i].vertex.x,
                        voxelVertex[i].vertex.y,
                        voxelVertex[i].vertex.z);
        }
    }
    
    void drawEdges(){
        for(int i = 0; i < 12; i++){            
            voxelEdges[i].draw();
        }
    }

    void drawVoxel(){    
    
    }

    void renderCase(int cubeindex){
        for (int i=0;triTable[cubeindex][i]!=-1;i+=3) {
            beginShape(TRIANGLES);
                for(int e = 0; e<3; e++){
                    int edge = triTable[cubeindex][i+e];
                    PVector interSectPoint =  voxelEdges[edge].midPoint();
                    vertex(interSectPoint.x, interSectPoint.y, interSectPoint.z); 
                }                   
            endShape();

        }
    
    }

    int calculateCubeIndex(float isolevel){
        int cubeindex = 0;
        if (voxelVertex[0].getIsovalue() < isolevel) cubeindex |= 1;
        if (voxelVertex[1].getIsovalue() < isolevel) cubeindex |= 2;
        if (voxelVertex[2].getIsovalue() < isolevel) cubeindex |= 4;
        if (voxelVertex[3].getIsovalue() < isolevel) cubeindex |= 8;
        if (voxelVertex[4].getIsovalue() < isolevel) cubeindex |= 16;
        if (voxelVertex[5].getIsovalue() < isolevel) cubeindex |= 32;
        if (voxelVertex[6].getIsovalue() < isolevel) cubeindex |= 64;
        if (voxelVertex[7].getIsovalue() < isolevel) cubeindex |= 128;
        return cubeindex;
    }



}