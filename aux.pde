int voxelResolution = 15;
int gridScale = 10;

void voxel(float i, float j, float k, int s){

  Voxel vox = new Voxel(new PVector(i, j, k), s);
  vox.drawVertex();
  vox.drawEdges();
  calculateIsoLevel(vox);
  int cubeindex = vox.calculateCubeIndex(100);
  // println("cube: "+ cubeindex);
  //vox.renderCase(cubeindex);

}

void drawGrid(){

  for(int i=0; i< voxelResolution; i++){
    for(int j=0; j< voxelResolution; j++){
      for(int k=0; k< voxelResolution; k++){
      //drawVoxel(i,j,k, gridScale);
      voxel(i,j,k,gridScale);
      }
    }
  }
}

void calculateIsoLevel(Voxel vox){
  for (Vertex v: vox.voxelVertices){
    v.isoValue = isoFunction(v.vertex);
  }  
}

float isoFunction(PVector vert){
  return sqrt( pow(vert.x-15, 2) + pow(vert.y-15, 2) + pow(vert.z-15, 2) );
}