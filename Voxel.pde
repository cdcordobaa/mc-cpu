class Voxel{

    Vertex[] voxelVertices;
    Edge[] voxelEdges;
    int cubeIndex = 0;

    Voxel(PVector position, float scale){

        voxelVertices = new Vertex[8];
        voxelEdges = new Edge[12];
        createVertex(position.x, position.y, position.z, scale);
        createEdges();

    }

    void createEdges(){
        
        for (int i=0; i<4; i++){
            voxelEdges[i] = new Edge(voxelVertices[i], voxelVertices[(i+1)%4]);
        }
        for (int i=4; i<8; i++){
            voxelEdges[i] = new Edge(voxelVertices[i], voxelVertices[(i+1)%4 + 4 ]);
        }
        for (int i=0; i<4; i++){
            voxelEdges[i+8] = new Edge(voxelVertices[i], voxelVertices[(i+4)]);
        }
    }

    void createVertex(float i, float j, float k, float s){
        voxelVertices[0] = new Vertex(i  , j  , k  );
        voxelVertices[1] = new Vertex(i+s, j  , k  );
        voxelVertices[2] = new Vertex(i+s, j+s, k  );
        voxelVertices[3] = new Vertex(i  , j+s, k  );

        voxelVertices[4] = new Vertex(i  , j  , k+s);
        voxelVertices[5] = new Vertex(i+s, j  , k+s);
        voxelVertices[6] = new Vertex(i+s, j+s, k+s);
        voxelVertices[7] = new Vertex(i  , j+s, k+s);
    }

    void drawVertex(){        
        for(int i = 0; i < 8 ; i++){
            voxelVertices[i].draw(i);
        }
    }
    
    void drawEdges(){
        for(int i = 0; i < 12; i++){            
            voxelEdges[i].draw();
        }
    }

    void renderCase(int cubeindex, float isolevel){
        for (int i=0;triTable[cubeindex][i]!=-1;i+=3) {
            beginShape(TRIANGLES);
                for(int e = 0; e<3; e++){
                    int edge = triTable[cubeindex][i+e];
                    //PVector interSectPoint =  voxelEdges[edge].midPoint();
                    PVector interSectPoint = voxelEdges[edge].linearInterpolation(isolevel);
                    vertex(interSectPoint.x, interSectPoint.y, interSectPoint.z); 
                }                   
            endShape();

        }
    
    }

    int calculateCubeIndex(float isolevel){
        int cubeindex = 0;
        if (voxelVertices[0].getIsovalue() < isolevel) cubeindex |= 1;
        if (voxelVertices[1].getIsovalue() < isolevel) cubeindex |= 2;
        if (voxelVertices[2].getIsovalue() < isolevel) cubeindex |= 4;
        if (voxelVertices[3].getIsovalue() < isolevel) cubeindex |= 8;
        if (voxelVertices[4].getIsovalue() < isolevel) cubeindex |= 16;
        if (voxelVertices[5].getIsovalue() < isolevel) cubeindex |= 32;
        if (voxelVertices[6].getIsovalue() < isolevel) cubeindex |= 64;
        if (voxelVertices[7].getIsovalue() < isolevel) cubeindex |= 128;
        return cubeindex;
    }

     void  pointsCloudIsovalues(PVector point, float weight, float scale){
        for (Vertex v: voxelVertices){
            v.setIsovalueFromPoint(point, weight, scale);
            //println("v.isoValue: "+v.isoValue);
        }
    }
}