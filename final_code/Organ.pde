class Organ{
 PVector posO=new PVector(0,0);
 PVector posOm;
 PVector velO=new PVector(-1,1);
 float dampO=0.3;
 float oppaO=0;
 ArrayList<Cell> cells;
 ArrayList<Puls> puls;
 boolean attract=true;
 colorC cO;
 int r=int(width/200);
 int nc=8;
 int np=18;
 int atIndex=0;
 Organ(int at){
   atIndex=at;
   float ax=attractors.get(atIndex).posA.x; float ay=attractors.get(atIndex).posA.y;
   posOm=new PVector(ax,ay);
   posO=new PVector(0,0);
   cells= new ArrayList<Cell>();
   puls= new ArrayList<Puls>();
   for(int i=0;i<=np;i++){
     puls.add(new Puls(posO));
   }
   for(int i=0;i<nc;i++){
     float a=(2*PI)/(nc-1); float x=(r*9)*cos(a*i); float y=(r*9)*sin(a*i);
     PVector p2=new PVector(x,y);
   cells.add(new Cell(r+(i/10),p2,a*i));}
   cO= new colorC(80);
 }
 
 void display(){
 float xa=attractors.get(atIndex).posA.x; float ya=attractors.get(atIndex).posA.y;
 PVector posAo= new PVector(xa,ya);
 PVector df=PVector.sub(posAo,posOm);
  float d =PVector.dist(posOm,posAo);
  //df.mult(0.4/d);
  df.mult(0.2);
  velO.add(df);
  posOm.add(velO); velO.mult(dampO);
 pushMatrix(); translate(posOm.x,posOm.y); scale(2);
 //println(xa);
 for(Cell c: cells){
 c.display(oppaO);
if(c.max==false){c.repulse(posO);}
else{c.attract(posO);}
 //if(c.max=true){c.attract(posO);}
 c.rotateC(posO);}
  //popMatrix();
 for(Puls p: puls){
 p.display(); //p.update(aO.posA);
 if(attract==true){p.repulse();}
 else{p.attract();}}popMatrix();
 
 update();}
 
 void update(){
 //posO=aO.posA;
 cO.update();
 if(cO.c<92){attract=false;}
 //if(cO.c==110){attract=false; }
 if(cO.c>250){attract=true; }
 if(attractors.get(atIndex).type==1&&part==4){oppaO=0;}
 else if(part==4){oppaO=map(attractors.get(atIndex).speedA,0,100,150,0);}
 }
}

class Cell{
 PVector posC=new PVector(0,0);
 PVector velC;
 float dampC;
 int radiusC;
 ArrayList<colorC> colores;
 int nC=10;
 float distC=0;
 float angleC;
 float grades;
 boolean max=false;
 
 Cell(int r,PVector p,float a){
   angleC=a; grades=random(0.5,3);
 posC=p; radiusC=r;
 colores= new ArrayList<colorC>();
 for(int i=0;i<nC;i++){
   int c=int((175/(nC-1))*i);
 colores.add(new colorC(c+80));}
 dampC=random(0.1,0.5); velC=new PVector(random(-1,1),random(-1,1));
 }
 void display(float op){
   int j=0;
   for(int i=nC;i>0;i--){
   int r=int(i*radiusC);
   int c2=colores.get(j).c;
   fill(c2-op);
   noStroke();
   ellipse(posC.x,posC.y,r,r);
   j++; 
   }
   posC.add(velC); velC.mult(dampC); 
   for(colorC c: colores){c.update();}
 }
 void attract(PVector m){
  PVector df=PVector.sub(m,posC);
  float d =PVector.dist(posC,m);
  distC=d;
  df.mult(0.5/d);
  if(d>radiusC){
  velC.add(df);}else{max=false;}
  //dampP=random(0.3,0.8);
}
void repulse(PVector m){
  PVector df=PVector.sub(posC,m);
  float d =PVector.dist(posC,m);
  distC=d;
  df.mult(0.5/d);
  if(d<radiusC*10){
  velC.add(df);}else{max=true;}
  //dampP=random(0.3,0.8);
}
void rotateC(PVector p){
 angleC+=radians(grades);
 float x=p.x+cos(angleC)*distC; float y=p.y+sin(angleC)*distC;
 PVector pn=new PVector(x,y);
 posC=pn;
}
void update(PVector p){
 posC=p; 
}
}
class colorC{
boolean max=false;
int c=80;
colorC(int ic){
c=ic;}

void update(){
 if(max==false){c+=2;}
 if(max==true){c-=2;}
 if(c>255){max=true;}
 if(c<90){max=false;}
}}


  class Puls{
 PVector midP;
 PVector velP;
 PVector posP;
 float dampP;
 int rP;
 int cP;
 Puls(PVector m){
 rP=int(random(2,6)); cP=int(random(100,255));
 midP=m; float a=random(0,2*PI); float x=midP.x+(cos(a)*5*rP); float y=midP.y+(sin(a)*5*rP);
 posP=new PVector(x,y);
 velP=new PVector(random(-5,5),random(-5,5));
 dampP=random(0.3,0.7);}

void attract(){
  PVector df=PVector.sub(midP,posP);
  float d =PVector.dist(posP,midP);
  df.mult(0.4/d);
  velP.add(df);
  //dampP=random(0.3,0.8);
}
void repulse(){
  PVector df=PVector.sub(posP,midP);
  float d =PVector.dist(posP,midP);
  if(d<rP*20){
  df.mult(0.4/d);
  velP.add(df);}
  //dampP=random(0.3,0.8);
}
void display(){
  fill(cP);
  ellipse(posP.x,posP.y,rP,rP);
  posP.add(velP); velP.mult(dampP); 
}
void update(PVector p){midP=p;}
}
