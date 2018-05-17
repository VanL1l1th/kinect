import gab.opencv.*;
import SimpleOpenNI.*;
import KinectProjectorToolkit.*;

SimpleOpenNI kinect;
OpenCV opencv;
KinectProjectorToolkit kpc;
ArrayList<ProjectedContour> projectedContours;

ArrayList<Attractor> cAttractors;
ArrayList<Particle> particles;
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
      int co=0; float minX=10000; float maxX=0; float minY=10000; float maxY=0;
      PVector Pminy=new PVector(0,0); PVector Pmaxy=new PVector(0,0);
      //loop1 for minx maxx...
      
     
     ProjectedContour projectedContour = kpc.getProjectedContour(cvContour, 1.0);
     projectedContours.add(projectedContour);
    }
  }
  
  // draw projected contours
  background(0);
  for (int i=0; i<projectedContours.size(); i++) {
    ProjectedContour projectedContour = projectedContours.get(i);
 
    float minY=10000; float maxY=0; PVector Pminy=new PVector(0,0); PVector Pmaxy=new PVector(0,0);
    for (PVector p : projectedContour.getProjectedContours()) {
      float y=p.y;
      if(y<minY){minY=y; Pminy=p;} if(y>maxY){maxY=y; Pmaxy=p;} 
    }
    float mx=Pminy.x+((Pmaxy.x-Pminy.x)/2);
    float my=Pminy.y+((Pmaxy.y-Pminy.y)/3);
    cAttractors.add(new Attractor(mx,my));
    //update attractor with new midpoint
  }
  
  //loop to draw visual
  for(Attractor a: cAttractors){a.display();}
  drawParticles();
  //println(mode);
  //println(frameRate);
}

void drawParticles(){
 for(Particle p: particles){
     if(cAttractors.size()==1){p.attract(cAttractors.get(0).posA); resetP=0;}
     if(resetP<particles.size()&&cAttractors.size()==0){p.reset(0); resetP++;}
     if(cAttractors.size()>1){
     p.reset(200); resetP++;}
   p.display();} 
}


float distSq(int x1, int y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}




