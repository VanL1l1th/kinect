class Disease{ 
 PVector mDis=new PVector(0,0);
 ArrayList<PVector> pointsDis;
 ArrayList<PVector> pointsShape;
 Organ orDis;
 float rDis=10;
 int counterDis=0;
 int atIndexD;
 PVector velD=new PVector(-1,1);
 PVector posDm;
 float dampD=0.3;
 int ytran=0;
 
 Disease(int ai, int y){
   ytran=y;
   atIndexD=ai;
   orDis=new Organ(atIndexD);
   float dx=attractors.get(atIndexD).posA.x; float dy=attractors.get(atIndexD).posA.y;
   posDm=new PVector(dx,dy);
 pointsDis=new ArrayList<PVector>();
 pointsDis.add(new PVector(0,0));
 pointsShape=new ArrayList<PVector>();
 float a=0;
 for(int i=0;i<10;i++){
  float ap=random(0,PI*0.5);
  float xs=(150+ap)*cos(a); float ys=(ap+200)*sin(a);
  pointsShape.add(new PVector(xs,ys));
 if(a<2*PI){a+=ap;} 
 }
 }
 
 void display(){
   if(part==6){int typeD=attractors.get(atIndexD).type;
     if(typeD==1&&badOb==0){disOrgan();}
     else{disDis();}}
   else{
   float xd=attractors.get(atIndexD).posA.x; float yd=attractors.get(atIndexD).posA.y;
 PVector posAd= new PVector(xd,yd);
 PVector df=PVector.sub(posAd,posDm);
  //float d =PVector.dist(posDm,posAd);
  //df.mult(0.4/d);
  df.mult(0.2);
  velD.add(df);
  posDm.add(velD); velD.mult(dampD);
 pushMatrix(); translate(posDm.x,posDm.y+ytran);
 if(ytran==0){fill(255); noStroke(); //shapeMode(CENTER);
  beginShape();
  for(PVector p: pointsShape){
   vertex(p.x,p.y); 
  }
   endShape();}
   fill(0); stroke(0);
   for(PVector p: pointsDis){
    //point(p.x,p.y); 
    PVector p1=p;
   for(PVector pp: pointsDis){
     PVector p2=pp;
     float d =PVector.dist(p1,p2);
     if(d<38){ strokeWeight(1);
     line(p1.x,p1.y,p2.x,p2.y);}
   } 
   }
   popMatrix();
   if(counterDis<100){grow();}
   else if(counterDis<510){counterDis++;}
   //addDis();
   if(frameCount%10==0){frame();}
   }
 }
 void grow(){
  if(counterDis%10==0){
  for(int i=0;i<(counterDis/8)+5;i++){float a=random(0,2*PI);
  float x=rDis*(counterDis/10)*cos(a); float y=rDis*(counterDis/10)*sin(a);
  pointsDis.add(new PVector(x,y));
  }}
  counterDis++; 
 }
 void frame(){
   pointsShape.clear();
   float a=0;
  for(int i=0;i<10;i++){
  float ap=random(0,PI*0.5);
  float xs=(150+ap)*cos(a); float ys=(ap+200)*sin(a);
  pointsShape.add(new PVector(xs,ys));
 if(a<2*PI){a+=ap;} 
 } 
 }
 void disDis(){
   float xd=attractors.get(atIndexD).posA.x; float yd=attractors.get(atIndexD).posA.y;
   PVector posAd= new PVector(xd,yd);
   PVector df=PVector.sub(posAd,posDm);

   df.mult(0.2);
  velD.add(df);
  posDm.add(velD); velD.mult(dampD);
 pushMatrix(); translate(posDm.x,posDm.y+ytran);
 if(ytran==0){fill(255); noStroke(); //shapeMode(CENTER);
  beginShape();
  for(PVector p: pointsShape){
   vertex(p.x,p.y); 
  }
   endShape();}
   fill(0); stroke(0);
   for(PVector p: pointsDis){
    //point(p.x,p.y); 
    PVector p1=p;
   for(PVector pp: pointsDis){
     PVector p2=pp;
     float d =PVector.dist(p1,p2);
     if(d<38){ strokeWeight(1);
     line(p1.x,p1.y,p2.x,p2.y);}
   } 
   }
   popMatrix();
   if(counterDis<100){grow();}
   else if(counterDis<510){counterDis++;}
   //addDis();
   if(frameCount%10==0){frame();}
 }
 void disOrgan(){
  orDis.display(); 
 }
}


