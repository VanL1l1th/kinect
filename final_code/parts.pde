void drawPart2()
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
    cAttractors.add(new Attractor(0));
    cAttractors.get(cAttractors.size()-1).update(mx,my);
    //update attractor with new midpoint
  }
  
  if(flash==0){drawParticles(); flashs.clear();}
  if(flash==1){addFlash();}
}

void drawPart3()
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
     if(midDepth<threshold&&midDepth>10){
       cAttractors.add(new Attractor(0));
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
  drawParticles3();
  addLava();
  for (Lava l: lavas){
  l.display();}
  if(flash==1){addFlash();}else{flashs.clear();}
}

void drawPart4()
{ cAttractors.clear();
  kinect.update();
  //irMan();
  if(markerDet==true){irMan();}
  if(attractors.size()<1){markerDet=true;}
  //blobdetection
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
      for(PVector p: cvContour){
      if(p.x<minX){minX=p.x;}if(p.x>maxX){maxX=p.x;}
      if(p.y<minY){minY=p.y; Pminy=p;}if(p.y>maxY){maxY=p.y; Pmaxy=p;}}
      //loop2 for number of counter
      for(Blob b: blobs){
      if(b.mx()<maxX&&b.mx()>minX&&b.my()<maxY&&b.my()>minY){co++;}}
      //add attractor with an id
      cAttractors.add(new Attractor(co));
     
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
    cAttractors.get(i).update(mx,my);
    //update attractor with new midpoint
  }
  aTracking();
  addOrgan();

  for(Organ o: organs){
  o.display();}
  //loop to draw visual
  for(Attractor a: attractors){a.speed();}
}

void drawPart5()
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
      for(PVector p: cvContour){
      if(p.x<minX){minX=p.x;}if(p.x>maxX){maxX=p.x;}
      if(p.y<minY){minY=p.y; Pminy=p;}if(p.y>maxY){maxY=p.y; Pmaxy=p;}}
      //loop2 for number of counter
      for(Blob b: blobs){
      if(b.mx()<maxX&&b.mx()>minX&&b.my()<maxY&&b.my()>minY){co++;}}
      //add attractor with an id
      cAttractors.add(new Attractor(co));
     
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
    cAttractors.get(i).update(mx,my);
    //update attractor with new midpoint
  }
  aTracking();
  if(mode2==0){addOrgan();
  for(Organ o: organs){o.display();}}
  else{organs.clear();}
  if(mode2==1){ addFrame(); addDisease();}
  else{diseases.clear(); frames.clear();}
  //loop to draw visual
  //for(Attractor a: attractors){a.display();}
  //println(diseases.size());
  //println(frameRate);
}

void drawPart6()
{  
  cAttractors.clear();
  kinect.update();
  //irMan();
  if(markerDet==true){irMan();}
  if(attractors.size()<1){markerDet=true;}
  //blobdetection
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
      for(PVector p: cvContour){
      if(p.x<minX){minX=p.x;}if(p.x>maxX){maxX=p.x;}
      if(p.y<minY){minY=p.y; Pminy=p;}if(p.y>maxY){maxY=p.y; Pmaxy=p;}}
      //loop2 for number of counter
      for(Blob b: blobs){
      if(b.mx()<maxX&&b.mx()>minX&&b.my()<maxY&&b.my()>minY){co++;}}
      //add attractor with an id
      cAttractors.add(new Attractor(co));
     
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
    cAttractors.get(i).update(mx,my);
    //update attractor with new midpoint
  }
  aTracking();
  if(explosion==0){explosions.clear();
  background(bColor);
  addDisease();
  if(bColor<255){bColor++;}}
  else{diseases.clear(); diseases2.clear();
   background(0);
   if(counterEx>150){explosions.clear();
    for(Particle p:particles6){p.display();}
   }else{counterEx++; addExplosion();} 
  }
}

void aTracking(){
if(attractors.size()==0&&cAttractors.size()!=0){int i=0;
   for(Attractor a: cAttractors){attractors.add(new Attractor(a.coA)); attractors.get(i).become(a); i++;}
   }
   
else if(cAttractors.size()>=attractors.size()){
for(Attractor a: attractors){
float dist=10000; PVector pa=a.posA; Attractor am=new Attractor(0);
for(Attractor a2: cAttractors){
 PVector pa2=a2.posA; float d=sqrt(sq(pa2.x-pa.x)+sq(pa2.y-pa.y));
 if(d<dist){dist=d; am=a2;}
}
a.become(am);
am.matched();
}
int i=0;
for(Attractor a: cAttractors){
if(a.match==false){attractors.add(new Attractor(a.coA)); attractors.get(i).become(a); i++;}}
}

else if(cAttractors.size()<attractors.size()){
 for(Attractor a: cAttractors){
  float dist=10000; PVector pa=a.posA; Attractor am=new Attractor(0);
  for(Attractor a2: attractors){
  PVector pa2=a2.posA; float d=sqrt(sq(pa2.x-pa.x)+sq(pa2.y-pa.y));
  if(d<dist){dist=d; am=a2;}}
  am.become(a);
  am.matched();
 }
for(int i=attractors.size()-1;i>=0;i--){
    if(attractors.get(i).match==false){attractors.remove(i);}
    else{attractors.get(i).dematch();}}
}
else{attractors.clear();}
}

void addOrgan(){
 if(organs.size()==0&&attractors.size()!=0){
 for(int i=0;i<attractors.size();i++){
 organs.add(new Organ(i));}
 }
 if(organs.size()<attractors.size()){
 for(int i=organs.size();i<attractors.size();i++){
 organs.add(new Organ(i));}
 }
 if(organs.size()>attractors.size()){
 for(int i=organs.size()-1;i>attractors.size()-1;i--){PVector p=organs.get(i).posOm;
 organs.remove(i); explosionsOr.add(new ExplosionOr(p));}
 }
 if(attractors.size()==0){organs.clear();}
 for(int i=explosionsOr.size()-1;i>=0;i--){explosionsOr.get(i).display();
 boolean r=explosionsOr.get(i).removeEx;
 if(r==true){explosionsOr.remove(i);}}
}

void irMan(){
  //loadPixels();
 blobs.clear();
 PImage irIm=kinect.irImage();
 image(irIm,0,0);

createBlob();
}

void createBlob(){
 for(int i=0;i<640;i++){
 for(int j=0;j<480;j++){
 int c= get(i,j);
 if(c==-1){
  boolean found=false;
  for(Blob b:blobs){
  if(b.isNear(i,j)==true){
  b.addp(i,j); found=true;}  
  }
  if(found==false){
  blobs.add(new Blob(i,j));}
 }
 }}
 for(int i=blobs.size()-1;i>=0;i--){if(blobs.get(i).area()<160){blobs.remove(i);}}
}


void drawParticles3(){
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
void drawParticles(){
 for(Particle p: particles){
     if(cAttractors.size()==1){p.attract(cAttractors.get(0).posA); resetP=0;}
     if(resetP<particles.size()&&cAttractors.size()==0){p.reset(0); resetP++;}
     if(cAttractors.size()>1){
     p.reset(200); resetP++;}
   p.display(); p.setrad(rInput);} 
}

void addFlash(){
 if(flashs.size()==0&&cAttractors.size()!=0){
 for(int i=0;i<cAttractors.size();i++){
 flashs.add(new Flash(i));}
 }
 if(flashs.size()<cAttractors.size()){
 for(int i=flashs.size();i<cAttractors.size();i++){
 flashs.add(new Flash(i));}
 }
 if(flashs.size()>cAttractors.size()){
 for(int i=flashs.size()-1;i>cAttractors.size()-1;i--){
 flashs.remove(i);}
 }
 if(cAttractors.size()==0){flashs.clear();}
 if(frameCount%5==0){for(Flash f: flashs){f.display();}}
 }
 void setupPart2(){
  cAttractors= new ArrayList<Attractor>();
  particles= new ArrayList<Particle>();
  for(int i=0;i<100;i++){
  particles.add(new Particle());}  
}

void addDisease(){
 if(diseases.size()==0&&attractors.size()!=0){
 for(int i=0;i<attractors.size();i++){
 diseases.add(new Disease(i,0));}
 }
 if(diseases.size()<attractors.size()){
 for(int i=diseases.size();i<attractors.size();i++){
 diseases.add(new Disease(i,0));}
 }
 if(diseases.size()>attractors.size()){
 for(int i=diseases.size()-1;i>attractors.size()-1;i--){
   int ind=diseases.get(i).atIndexD; if(diseases2.size()!=0){for(int j=diseases2.size()-1;j>=0;j--){
   if(ind==diseases2.get(j).atIndexD){diseases2.remove(j);}}}
 diseases.remove(i);}
 }
 for(Disease d: diseases){d.display(); 
 if(d.counterDis%100==0){ int y=int(random(-100,100)); if(y==0){y=10;} diseases2.add(new Disease(d.atIndexD,y));}}
 if(diseases.size()==0){diseases2.clear();}
 for(Disease d: diseases2){d.display();}
 }
 
 void addExplosion(){
 if(explosions.size()==0&&attractors.size()!=0){
 for(int i=0;i<attractors.size();i++){
 explosions.add(new Explosion(i));}
 }
 if(explosions.size()<attractors.size()){
 for(int i=explosions.size();i<attractors.size();i++){
 explosions.add(new Explosion(i));}
 }
 if(explosions.size()>attractors.size()){
 for(int i=explosions.size()-1;i>attractors.size()-1;i--){
 explosions.remove(i);}
 }
for(Explosion e: explosions){e.display();}
 }
 
 void addFrame(){
  if(attractors.size()>0&&frameCount%100==0){
  frames.add(new Frame(attractors.get(0).posA));
  } 
  for(int i=frames.size()-1;i>=0;i--){
  frames.get(i).display();
  int col=frames.get(i).cFrame;
  if(col<10){frames.remove(i);}}
 }

 void setupPart3(){
  cAttractors= new ArrayList<Attractor>();
  particles= new ArrayList<Particle>();
  for(int i=0;i<100;i++){
  particles.add(new Particle());} 
  lavas= new ArrayList<Lava>();
  flash=0;
 }
 
 void setupPart4(){
  organs=new ArrayList<Organ>(); 
  cAttractors= new ArrayList<Attractor>();
  attractors= new ArrayList<Attractor>();
  blobs= new ArrayList<Blob>();
  explosionsOr= new ArrayList<ExplosionOr>();
  
  c=0;
  spaceBlobs=10;
  tol=10;
  markerDet=true;
 }
 
 void setupPart5(){
  explosionsOr= new ArrayList<ExplosionOr>();
  organs=new ArrayList<Organ>();
  cAttractors= new ArrayList<Attractor>();
  attractors= new ArrayList<Attractor>();
  diseases=new ArrayList<Disease>();
  diseases2= new ArrayList<Disease>();
  blobs= new ArrayList<Blob>();
  frames= new ArrayList<Frame>();
  mode2=0;
 }
 
 void setupPart6(){
  frames= new ArrayList<Frame>();
  organs=new ArrayList<Organ>();
  cAttractors= new ArrayList<Attractor>();
  attractors= new ArrayList<Attractor>();
  diseases=new ArrayList<Disease>();
  diseases2= new ArrayList<Disease>();
  blobs= new ArrayList<Blob>();
  explosions= new ArrayList<Explosion>();
  particles6= new ArrayList<Particle>();
  for(int i=0;i<100;i++){
  particles6.add(new Particle());} 
  badOb=0;
  bColor=0;
  explosion=0;
  counterEx=0;
  }

