import peasy.*;
PeasyCam cam;
//peasy

int voxelResolution = 15;
int gridScale = 10;



void setup(){
  size(1200, 600, P3D);
  //peasy vars
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  //peasy vars
  
  noStroke();

}

void draw(){
  background(125);
  fill(255,0,0);
  stroke(255);
  
  pushMatrix();  
  //box(30);
  drawGrid();
  //drawVoxel(0,0,0,gridScale);
  //voxel(0,0,0,gridScale);

  popMatrix();
  
 
}

void voxel(int i, int j, int k, int s){

  Voxel vox = new Voxel(new PVector(i, j, k), s);
  //vox.drawVertex();
  //vox.drawEdges();
  calculateIsoLevel(vox);
  int cubeindex = vox.calculateCubeIndex(100);
  // println("cube: "+ cubeindex);
  vox.renderCase(cubeindex);

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

void drawVoxel(int i, int j, int k, int s){
  textSize(10);
  text("v0", i*s, j*s, k*s);
  text("v1", (i+1)*s, j*s, k*s);
  text("v2", (i+1)*s, (j+1)*s, k*s);
  text("v3", i*s, (j+1)*s, k*s);

  text("v4", i*s, j*s, (k+1)*s);
  text("v5", (i+1)*s, j*s, (k+1)*s); 
  text("v6", (i+1)*s, (j+1)*s, (k+1)*s);
  text("v7", i*s, (j+1)*s, (k+1)*s);

  
  
  line(i*s,j*s,k*s, i*s,j*s,(k+1)*s);
  line(i*s,j*s,k*s, i*s,(j+1)*s,k*s);
  line(i*s,j*s,k*s, (i+1)*s,j*s,k*s);
  
  line((i+1)*s,j*s,k*s, (i+1)*s,j*s,(k+1)*s);
  line((i+1)*s,j*s,k*s, (i+1)*s,(j+1)*s,k*s);
  
  line(i*s,(j+1)*s,k*s, i*s,(j+1)*s,(k+1)*s);
  line(i*s,(j+1)*s,k*s, (i+1)*s,(j+1)*s,k*s);
  
  line(i*s,j*s,(k+1)*s, i*s,(j+1)*s,(k+1)*s);
  line(i*s,j*s,(k+1)*s, (i+1)*s,j*s,(k+1)*s);
   
  line((i+1)*s,(j+1)*s,k*s, (i+1)*s,(j+1)*s,(k+1)*s);
  line(i*s,(j+1)*s,(k+1)*s, (i+1)*s,(j+1)*s,(k+1)*s);
  line((i+1)*s,j*s,(k+1)*s, (i+1)*s,(j+1)*s,(k+1)*s);
  
}

void calculateIsoLevel(Voxel vox){
  for (Vertex v: vox.voxelVertex){
    v.isoValue = isoFunction(v.vertex);
  }  
}

float isoFunction(PVector vert){
  return sqrt( pow(vert.x-15, 2) + pow(vert.y-15, 2) + pow(vert.z-15, 2) );
}