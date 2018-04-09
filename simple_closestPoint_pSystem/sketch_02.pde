import SimpleOpenNI.*;
SimpleOpenNI kinect;
int nValue=8000;
int nX;
int nY;
PVector pos = new PVector(300,200);
pSystem s = new pSystem(pos);
void setup(){
 kinect= new SimpleOpenNI(this);
kinect.enableDepth(); 
size(640,480);
}
void draw(){
  nValue=8000;
  background(0);
  kinect.update();
int[] dValues= kinect.depthMap();
for(int x=0;x<640;x++){
 for(int y=0;y<480;y++){
  int rx=640-x-1;
  int i=rx+(640*y);
  int v=dValues[i];
  if(v>0&&v<nValue){
    nValue=v;
    nX=x; nY=y;}
 } 
}
pos.set(nX,nY);
s.display();
s.updateO(pos);
}


