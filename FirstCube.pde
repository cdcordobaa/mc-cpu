// -------------
/*
  CRISTIAN DANIEL CORDOBA
  Marching Cubes Algorithm CPU Implementation in Processing
  
  Reference CODE used can be found here 
  ---> 
  http://paulbourke.net/geometry/polygonise/
  https://github.com/cloudlab/ComputationalGeometry-P5/blob/master/src/ComputationalGeometry/IsoSurface.java 
  https://github.com/stemkoski/stemkoski.github.com/blob/master/Three.js/Marching-Cubes.html
  <---
*/
  //  Press key 1 or 2 to change between function based surface
  //  or a surface calculated from a random points cloud
   
// -------------

import peasy.*;
PeasyCam cam;
//peasy

IsoSurface volumeFunc;
IsoSurface volumePcloud;
int volumeType = 1;

void setup(){
  size(1200, 600, P3D);

  //peasy 
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  //peasy 

  int resolution = 20;
  float axisMin = -10; 
  float axisMax = 10;
  float sizeScale = 10;

  volumeFunc = new IsoSurface(resolution,axisMin,axisMax,sizeScale);

  PVector[] pCloud = randomPoints(10, axisMin, axisMax);

  volumePcloud = new IsoSurface(resolution,axisMin*2,axisMax*2,sizeScale,pCloud,1);

}

void draw(){

  background(200);
  fill(0,255,0);
  stroke(255);

  float isolevel = mouseX/10000.0;

  if(volumeType == 1)
    volumeFunc.renderSurface(0);
  if(volumeType == 2)
    volumePcloud.renderSurface(isolevel, true);
  
  println("mouseX: "+ isolevel);
}

PVector[] randomPoints(int numPoints, float min, float max){

  PVector[] pointsCloud = new PVector[numPoints];
  for(int i=0; i<numPoints; i++){
      float xr=random(min,max);
      float yr=random(min,max);
      float zr=random(min,max);            
      pointsCloud[i] = new PVector( xr, yr, zr );
  }  
  return pointsCloud;
}

void keyPressed() {
  if (key == '1')
    volumeType = 1;
  if (key == '2')
    volumeType = 2;
}

