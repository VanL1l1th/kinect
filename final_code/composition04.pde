import gab.opencv.*;
import SimpleOpenNI.*;
import KinectProjectorToolkit.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;

SimpleOpenNI kinect;
OpenCV opencv;
KinectProjectorToolkit kpc;
ArrayList<ProjectedContour> projectedContours;
int part=2; boolean switching=true;

ArrayList<Attractor> cAttractors;
ArrayList<Attractor> attractors;
ArrayList<Blob> blobs;

boolean markerDet=true;
ArrayList<Particle> particles;
ArrayList<Flash> flashs;
ArrayList<Lava> lavas;
ArrayList<Organ> organs;
ArrayList<Disease> diseases;
ArrayList<Disease> diseases2;
ArrayList<Particle> particles6;
ArrayList<Explosion> explosions;
ArrayList<Frame> frames;
ArrayList<ExplosionOr> explosionsOr;

float threshold=2400;
int resetP=2000;
int flash=0;
float rInput=1;
int c=0;
int spaceBlobs=10;
int tol=10;
int mode2=0;
int badOb=0;
int bColor=0;
int explosion=1;
int counterEx=0;

void setup()
{
  size(1024,768,P2D); 
  
  oscP5 = new OscP5(this,12000);  

  // setup Kinect
  kinect = new SimpleOpenNI(this); 
  kinect.enableDepth();
  kinect.enableUser();
  kinect.enableIR(); 
  
  cAttractors= new ArrayList<Attractor>();
  attractors= new ArrayList<Attractor>();
  blobs= new ArrayList<Blob>();
  particles= new ArrayList<Particle>();
  for(int i=0;i<100;i++){
  particles.add(new Particle());} 
  flashs=new ArrayList<Flash>(); 
  lavas= new ArrayList<Lava>();
  organs=new ArrayList<Organ>();
  diseases=new ArrayList<Disease>();
  diseases2= new ArrayList<Disease>();
  explosions= new ArrayList<Explosion>();
  frames= new ArrayList<Frame>();
  explosionsOr= new ArrayList<ExplosionOr>();
 
  kinect.alternativeViewPointDepthToImage();
  // setup OpenCV
  opencv = new OpenCV(this, kinect.depthWidth(), kinect.depthHeight());

  // setup Kinect Projector Toolkit
  kpc = new KinectProjectorToolkit(this, kinect.depthWidth(), kinect.depthHeight());
  kpc.loadCalibration("calibration.txt");
}

void draw(){
  
  switch(part){
   case 2: if(switching==true){setupPart2(); switching=false;}drawPart2(); break;
   case 3: if(switching==true){setupPart3(); switching=false;}drawPart3(); break;
   case 4: if(switching==true){setupPart4(); switching=false;}drawPart4(); break; 
   case 5: if(switching==true){setupPart5(); switching=false;}drawPart5(); break;
   case 6: if(switching==true){setupPart6(); switching=false;}drawPart6(); break;
   case 7: background(0); break;
  }
}

boolean sketchFullScreen() {
  return true;
}

void oscEvent(OscMessage theOscMessage) {
   if (theOscMessage.addrPattern().equals("/server")) {
    part=int(theOscMessage.get(0).floatValue()); switching=true;
  }
  
  if (theOscMessage.addrPattern().equals("/server/part2")) {
    rInput=theOscMessage.get(0).floatValue();      //0.5 bis 4 default 1
    flash=int(theOscMessage.get(1).floatValue()); //0 kein flash 1 flash
  }
 
  if (theOscMessage.addrPattern().equals("/server/part3")) {
    flash=int(theOscMessage.get(0).floatValue());
    threshold=theOscMessage.get(1).floatValue();
  }
  
  if (theOscMessage.addrPattern().equals("/server/part5")) {
      mode2=int(theOscMessage.get(0).floatValue());
  }
  
  if (theOscMessage.addrPattern().equals("/server/part6")) {
    badOb=int(theOscMessage.get(0).floatValue()); //0 one good object 1 all bad object
    explosion=int(theOscMessage.get(1).floatValue()); //0 normal state 1 the last particle explosion starts
  }
  /* get and print the address pattern and the typetag of the received OscMessage */
  println("### received an osc message with addrpattern "+theOscMessage.addrPattern()+" and typetag "+theOscMessage.typetag());
  theOscMessage.print();
 }
 
// void keyPressed(){
//  if(key=='2'){part=2; switching=true;}
//  if(key=='3'){part=3; switching=true;} 
//  if(key=='4'){part=4; switching=true;}
//  if(key=='5'){part=5; switching=true;}
//  if(key=='6'){part=6; switching=true;}
// }
