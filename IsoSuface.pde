class IsoSurface{

    int size = 4;
    float axisMin = -10;
    float axisMax =  10;
    float axisRange = axisMax - axisMin;
    float scale = 1;
    // 3D array in 1D array
    Voxel[] voxelList;

    IsoSurface(){

        voxelList = new Voxel[size*size*size];

        
    }

    void createVoxels(){
                
        float x;
        float y;
        float z;
        float delta = axisRange/(size-1);
        int index;

        for(int k=0; k< size; k++){
            for(int j=0; j< size; j++){
                for(int i=0; i< size; i++){
                    x = ((delta*i)+axisMin)*scale;
                    y = ((delta*j)+axisMin)*scale;
                    z = ((delta*k)+axisMin)*scale;
                    //[x][y][z] position mapped to [index]  position //<>//
                    index = i + (j*size) + (k*size*size);
                    voxelList[index] = new Voxel (new PVector(x, y, z), delta*scale); //<>//
                    calculateIsoValue(index); //<>//
                    //println(index + " x y z " + " , " + x + " , "+ y + " , " + z );
                }
            }
        }
    }


    void calculateIsoValue(int index){
        for (Vertex v: voxelList[index].voxelVertices){
            v.isoValue = isoFunction(v.vertex); //<>// //<>//
        }  
    }

    float isoFunction(PVector vert){
        return pow(vert.x, 2) + pow(vert.y, 2) + pow(vert.z, 2) - 25;
    }

    void renderSurface(float isolevel){
        int cubeindex;
        for(Voxel vox: voxelList){
            
            cubeindex = vox.calculateCubeIndex(isolevel);  
            vox.renderCase(cubeindex);
            vox.drawEdges();
        }
    } 

}