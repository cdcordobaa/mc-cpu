import peasy.*;
PeasyCam cam;
//peasy


float size = 20;
float	axisMin = -10;
float axisMax =  10;
float axisRange = axisMax - axisMin;
float scale = 5;
void setup(){
  size(1200, 600, P3D);

  //peasy 
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  //peasy 

}

void draw(){

  background(125);
  fill(0,255,0);
  stroke(255);

  float x;
  float y;
  float z;
  
  float delta = axisRange/(size-1);

  for(int i=0; i< size; i++){
    for(int j=0; j< size; j++){
      for(int k=0; k< size; k++){
        x = ((delta*i)+axisMin)*scale;
        y = ((delta*j)+axisMin)*scale;
        z = ((delta*k)+axisMin)*scale;

        drawVoxel(x,y,z, delta*scale);

        //println("delta "+ i + " is " + x);
      }
    }
  }

  
  pushMatrix();  
  
  //drawGrid();
  
  //voxel(delta,0,0,gridScale);

  popMatrix();
}

void drawVoxel(float i, float j, float k, float s){


  
  
  line(i,j,k, i,j,(k+s));
  line(i,j,k, i,(j+s),k);
  line(i,j,k, (i+s),j,k);
  
  line((i+s),j,k, (i+s),j,(k+s));
  line((i+s),j,k, (i+s),(j+s),k);
  
  line(i,(j+s),k, i,(j+s),(k+s));
  line(i,(j+s),k, (i+s),(j+s),k);
  
  line(i,j,(k+s), i,(j+s),(k+s));
  line(i,j,(k+s), (i+s),j,(k+s));
   
  line((i+s),(j+s),k, (i+s),(j+s),(k+s));
  line(i,(j+s),(k+s), (i+s),(j+s),(k+s));
  line((i+s),j,(k+s), (i+s),(j+s),(k+s));
  
}