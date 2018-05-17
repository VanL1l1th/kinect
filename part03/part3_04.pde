import gab.opencv.*;
import SimpleOpenNI.*;
import KinectProjectorToolkit.*;
int part=3;
SimpleOpenNI kinect;
OpenCV opencv;
KinectProjectorToolkit kpc;
ArrayList<ProjectedContour> projectedContours;

ArrayList<Attractor> cAttractors;
ArrayList<Particle> particles;
ArrayList<Lava> lavas;
int resetP=2000;
void setup()
{
  size(1600,900,P2D); 

  // setup Kinect
  kinect = new SimpleOpenNI(this); 
  kinect.enableDepth();
  kinect.enableUser();
  kinect.enableIR(); 
  
  cAttractors= new ArrayList<Attractor>();
  particles= new ArrayList<Particle>();
  for(int i=0;i<100;i++){
  particles.add(new Particle());} 
  lavas= new ArrayList<Lava>();
 
  kinect.alternativeViewPointDepthToImage();
  // setup OpenCV
  opencv = new OpenCV(this, kinect.depthWidth(), kinect.depthHeight());

  // setup Kinect Projector Toolkit
  kpc = new KinectProjectorToolkit(this, kinect.depthWidth(), kinect.depthHeight());
  kpc.loadCalibration("calibration.txt");
  //kpc.setContourSmoothness(40);
}

void draw()
{ cAttractors.clear();
  kinect.update();
  background(0);
  kpc.setDepthMapRealWorld(kinect.depthMapRealWorld()); 
  
  kpc.setKinectUserImage(kinect.userImage());//kinect.userImage()
  opencv.loadImage(kpc.getImage());//kpc.getImage()
  
  // get projected contours
  projectedContours = new ArrayList<ProjectedContour>();
  ArrayList<Contour> contours = opencv.findContours();
  for (Contour contour : contours) {
    if (contour.area() > 2000) {
      ArrayList<PVector> cvContour = contour.getPoints();
      //loop1 for minx maxx...
      int minY=10000; int maxY=0; PVector Pminy=new PVector(0,0); PVector Pmaxy=new PVector(0,0);
      for(PVector p: cvContour){
      float y=p.y;
      if(y<minY){minY=int(y); Pminy=p;} if(y>maxY){maxY=int(y); Pmaxy=p;}}
      int mx=int(Pminy.x+((Pmaxy.x-Pminy.x)/2));
      int my=int(Pminy.y+((Pmaxy.y-Pminy.y)/2));
      int[] depthValues = kinect.depthMap();
      int midPosition = mx + (my * 640);
      int midDepth = depthValues[midPosition];
     //println(midDepth);
     if(midDepth<1900&&midDepth>10){
       cAttractors.add(new Attractor());
     ProjectedContour projectedContour = kpc.getProjectedContour(cvContour, 1.0);
     projectedContours.add(projectedContour);}
    }
  }
  
  // draw projected contours
  background(0);
  for (int i=0; i<projectedContours.size(); i++) {
    ProjectedContour projectedContour = projectedContours.get(i);
 
    float minY=10000; float maxY=0; PVector Pminy=new PVector(0,0); PVector Pmaxy=new PVector(0,0);
    float minX=10000; float maxX=0;
    for (PVector p : projectedContour.getProjectedContours()) {
      float y=p.y; float x=p.x;
      if(y<minY){minY=y; Pminy=p;} if(y>maxY){maxY=y; Pmaxy=p;}
      if(x<minX){minX=x;} if(x>maxX){maxX=x;}
    }
    float mx=Pminy.x+((Pmaxy.x-Pminy.x)/2);
    float my=Pminy.y+((Pmaxy.y-Pminy.y)/3);
    cAttractors.get(i).update(mx,my);
    cAttractors.get(i).getRect(minX,maxX,minY,maxY);
    //update attractor with new midpoint
  }
  
  //loop to draw visual
  for(Attractor a: cAttractors){a.display(); a.drawRect();}
  drawParticles();
  addLava();
  for (Lava l: lavas){
  l.display();}
//  if(cAttractors.size()>0){
//println(lavas.size());
  //println(frameRate);
}

void drawParticles(){
 for(Particle p: particles){
     if(cAttractors.size()>0){
     for(Attractor a:cAttractors){p.attract(a.posA);} resetP=0;}
     if(resetP<200*particles.size()&&cAttractors.size()==0){p.reset(0); resetP++;}
   p.display();} 
}
void addLava(){
  if(lavas.size()==0&&cAttractors.size()!=0){
 for(int i=0;i<cAttractors.size();i++){
 lavas.add(new Lava(i));}
 }
 if(lavas.size()<cAttractors.size()){
 for(int i=lavas.size();i<cAttractors.size();i++){
 lavas.add(new Lava(i));}
 }
 if(lavas.size()>cAttractors.size()){
 for(int i=lavas.size()-1;i>cAttractors.size()-1;i--){
 lavas.remove(i);}
 }
 if(cAttractors.size()==0){lavas.clear();}
}

float distSq(int x1, int y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}




