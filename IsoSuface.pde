class IsoSurface{

    int size = 15;
    float axisMin = -10;
    float axisMax =  10;
    float axisRange = axisMax - axisMin;
    float scale = 15;
    float weight = 1;
    // 3D array in 1D array
    Voxel[] voxelList;
    PVector pointsCloud[];

    IsoSurface(){

        voxelList = new Voxel[size*size*size];

        int numPoints= 3;
        pointsCloud = new PVector[numPoints];

        for(int i=0; i<numPoints; i++){
            float xr=random(axisMin,axisMax);
            float yr=random(axisMin,axisMax);
            float zr=random(axisMin,axisMax);
            
            PVector pt = new PVector( xr*scale, yr*scale, zr*scale );
            pointsCloud[i] = pt;
        }
        
        //pointsCloud[0] = new PVector(0 , 0 , 0);

    }

    void createVoxels(){
                
        float x;
        float y;
        float z;
        float delta = axisRange/(size);
        int index;

        for(int k=0; k< size; k++){
            for(int j=0; j< size; j++){
                for(int i=0; i< size; i++){
                    x = ((delta*i)+axisMin)*scale;
                    y = ((delta*j)+axisMin)*scale;
                    z = ((delta*k)+axisMin)*scale;
                    //[x][y][z] position mapped to [index]  position 
                    index = i + (j*size) + (k*size*size);
                    voxelList[index] = new Voxel (new PVector(x, y, z), delta*scale); 
                    //FunctionIsoValue(index);
                    pointsCloudIsovalues(index);
                    //println(index + " x y z " + " , " + x + " , "+ y + " , " + z );
                }
            }
        }
    }


    void FunctionIsoValue(int index){
        for (Vertex v: voxelList[index].voxelVertices){
            v.isoValue = isoFunction(v.vertex); 
        }  
    }

    float isoFunction(PVector vert){
        return pow(vert.x, 2) + pow(vert.y, 2) - pow(vert.z, 2) - 25*pow(scale,2);
    }

    void pointsCloudIsovalues(int index){
        for(int i=0; i<pointsCloud.length; i++){
            voxelList[index].pointsCloudIsovalues(pointsCloud[i], weight, scale);
        }
    }

    void renderSurface(float isolevel){
        int cubeindex;
        for(Voxel vox: voxelList){
            
            cubeindex = vox.calculateCubeIndex(isolevel);            
            vox.renderCase(cubeindex,isolevel);
            vox.drawEdges();
            //vox.drawVertex();
            //drawPointsCloud();
        }
    }

    void drawPointsCloud(){
        for(PVector pt: pointsCloud){
            pushMatrix();
            translate(pt.z, pt.y, pt.z);
            sphere(1);
            popMatrix();
        }
            
    }

}