class Voxel{

    Vertex[] voxelVertex;
    Edge[] voxelEdges;
    //int cubeIndex = 1;

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
        for(int i = 0; i < 8 ; i++){
            text("v"+i, voxelVertex[i].vertex.x,
                        voxelVertex[i].vertex.y,
                        voxelVertex[i].vertex.z);
        }
    }
    
    void drawEdges(){
        for(int i = 0; i < 12; i++){
            print("edge" + i + " is --- ");
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



}