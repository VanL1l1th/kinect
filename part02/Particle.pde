class Particle{
 PVector posP;
 PVector velP;
 int radiusP;
 float radiusA;
 float aP;
 float xG;
 int colorP;
 int explosion=0;
Particle(){
 posP=new PVector(random(0,width),random(0,height));
 velP=new PVector(random(-5,5),random(-5,5));
 radiusP=int(random(1,10)); colorP=int(random(150,255));
 radiusA=int(random(-height/10,height/10));
 aP=random(0,2*PI); xG=random(0,width);
} 
void display(){
fill(colorP); noStroke();
ellipse(posP.x,posP.y,radiusP,radiusP);
posP.add(velP); if(explosion<=0&&posP.y<height-200){ velP.mult(0.99); gravity();}
if(posP.x<5||posP.x>width-5){float x=velP.x*-1; velP=new PVector(x,velP.y);}
if(posP.y<5||posP.y>height-50){float y=velP.y*-1; velP=new PVector(velP.x,y);}
if(explosion>0){explosion--;}
}
void attract(PVector pa){
 PVector posAp= new PVector(pa.x+radiusA*cos(aP),pa.y+radiusA*sin(aP));
 PVector df=PVector.sub(posAp,posP);
  float d =PVector.dist(posP,posAp);
  df.mult(0.2/d);
  velP.add(df); velP.mult(0.96);
}
void repulse(PVector pa){
 PVector posAp= new PVector(pa.x+radiusA*cos(aP),pa.y+radiusA*sin(aP));
 PVector df=PVector.sub(posP,posAp);
  float d =PVector.dist(posP,posAp);
  df.mult(0.2/d);
  velP.add(df); velP.mult(0.96); 
}
void reset(int exp){
  explosion=exp;
if(resetP<particles.size()){velP=new PVector(random(-5,5),random(-5,5));}
}
void gravity(){
 PVector posG= new PVector(xG,height);
 PVector df=PVector.sub(posG,posP);
  float d =PVector.dist(posP,posG);
  df.mult(0.1/d);
  velP.add(df); //velP.mult(0.96);
}
}
