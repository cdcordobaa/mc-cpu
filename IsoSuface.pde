class IsoSurface{

    int resolution = 25;
    float axisMin = -20;
    float axisMax =  20;
    float axisRange = axisMax - axisMin;
    float scale = 15;
    float weight = 1;
    // 3D array in 1D array
    Voxel[] voxelList;
    PVector pointsCloud[];
    boolean isPointsVolume = false;

    IsoSurface(int resolution, float axisMin, float axisMax, float scale){

        this.resolution = resolution;
        this.axisMin = axisMin;
        this.axisMax = axisMax;
        this.scale = scale;
        this.axisRange = axisMax - axisMin;
        this.weight = 1;        

        voxelList = new Voxel[resolution*resolution*resolution];
        createVoxels();
        
    }

    IsoSurface(int resolution, float axisMin, float axisMax, float scale, PVector[] PCloud, float weight){
        this.weight = weight;
        this.pointsCloud = PCloud;

        if (scale != 1){
            for(int i=0; i<PCloud.length; i++){
                pointsCloud[i].x = PCloud[i].x*scale;
                pointsCloud[i].y = PCloud[i].y*scale;
                pointsCloud[i].z = PCloud[i].z*scale;
            }
        }

        isPointsVolume = true;
        this.resolution = resolution;
        this.axisMin = axisMin;
        this.axisMax = axisMax;
        this.scale = scale;
        axisRange = axisMax - axisMin; 
        voxelList = new Voxel[resolution*resolution*resolution];
        createVoxels();
    }

    void createVoxels(){               
        float x;
        float y;
        float z;
        float delta = axisRange/(resolution);
        int index;
        for(int k=0; k< resolution; k++){
            for(int j=0; j< resolution; j++){
                for(int i=0; i< resolution; i++){
                    x = ((delta*i)+axisMin)*scale;
                    y = ((delta*j)+axisMin)*scale;
                    z = ((delta*k)+axisMin)*scale;
                    //[x][y][z] position mapped to [index]  position 
                    index = i + (j*resolution) + (k*resolution*resolution);
                    voxelList[index] = new Voxel (new PVector(x, y, z), delta*scale);

                    if (isPointsVolume){
                        pointsCloudIsovalues(index);
                    }
                    else{
                        functionIsoValues(index);   
                    }                 
                }
            }
        }
    }


    void functionIsoValues(int index){
        for (Vertex v: voxelList[index].voxelVertices){
            v.isoValue = isoFunction(v.vertex);
            //println("v.isoValue: "+v.isoValue); 
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

    void renderSurface(float isolevel, boolean edges){
        int cubeindex;
        for(Voxel vox: voxelList){            
            cubeindex = vox.calculateCubeIndex(isolevel);            
            vox.renderCase(cubeindex,isolevel);
            if(edges)
                vox.drawEdges();            
        }
    }

    void renderSurface(float isolevel){
        renderSurface(isolevel, false);
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