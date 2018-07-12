class Flash{
PVector mFla=new PVector(0,0);
 ArrayList<PVector> pointsShape;
 int atIndexF;
 PVector velF=new PVector(-1,1);
 PVector posFm;
 float dampF=0.3;
 
 Flash(int ai){
   atIndexF=ai;
   float dx=cAttractors.get(atIndexF).posA.x; float dy=cAttractors.get(atIndexF).posA.y;
   posFm=new PVector(dx,dy);
 pointsShape=new ArrayList<PVector>();
 float a=0;
 for(int i=0;i<15;i++){
  float ap=random(0,PI*0.5);
  float xs=(150+ap)*cos(a); float ys=(ap+200)*sin(a);
  pointsShape.add(new PVector(xs,ys));
 if(a<2*PI){a+=ap;} 
 }
 }
 
 void display(){
   float xd=cAttractors.get(atIndexF).posA.x; float yd=cAttractors.get(atIndexF).posA.y;
 PVector posAd= new PVector(xd,yd);
 PVector df=PVector.sub(posAd,posFm);
  //float d =PVector.dist(posDm,posAd);
  //df.mult(0.4/d);
  df.mult(0.2);
  velF.add(df);
  posFm.add(velF); velF.mult(dampF);
 pushMatrix(); translate(posFm.x,posFm.y);
 fill(255); noStroke(); //shapeMode(CENTER);
  beginShape();
  for(PVector p: pointsShape){
   vertex(p.x,p.y); 
  }
   endShape();
   popMatrix();
   if(frameCount%2==0){frame();}
 }
 void frame(){
   pointsShape.clear();
   float a=0;
  for(int i=0;i<15;i++){
  float ap=random(0,PI*0.5);
  float r=random(0,100);
  float xs=(150+(ap*0.3)+r)*cos(a); float ys=((0.3*ap)+200+r)*sin(a);
  pointsShape.add(new PVector(xs,ys));
 if(a<2*PI){a+=ap;} 
 } 
 }
}

class Frame{
 PVector mFrame= new PVector(0,0);
 ArrayList<PVector> pointsFrame; 
 int cFrame=255;
 Frame(PVector mf){
  mFrame=mf; 
  pointsFrame=new ArrayList<PVector>();
  float a=0;
  for(int i=0;i<15;i++){
  float ap=random(0,PI*0.5);
  float xs=(150+ap)*cos(a); float ys=(ap+200)*sin(a);
  pointsFrame.add(new PVector(xs,ys));
 if(a<2*PI){a+=ap;} 
 } 
 }
 
 void display(){
 pushMatrix(); translate(mFrame.x,mFrame.y);
 fill(cFrame); noStroke(); //shapeMode(CENTER);
  beginShape();
  for(PVector p: pointsFrame){
   vertex(p.x,p.y); 
  }
   endShape();
   popMatrix();
  if(frameCount%2==0){cFrame--;} 
 }
}


