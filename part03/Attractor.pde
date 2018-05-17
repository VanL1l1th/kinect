class Attractor{
 int type=0;
 int coA=0;
 int countA=0;
 int count2A=0;
 PVector posA= new PVector(0,0);
 boolean match=false;
 float minxA; float minyA; float maxxA; float maxyA;
Attractor(){}

void display(){
 fill(255); ellipse(posA.x,posA.y,20,20); 
}
void update(float x, float y){
 posA=new PVector(x+120,y); 
}
void getRect(float mix, float max, float miy, float may){
minxA=mix; minyA=miy; maxxA=max; maxyA=may;
}
void drawRect(){
    rectMode(CORNERS);
  noFill();
  stroke(255);
  strokeWeight(2);
 rect(minxA,minyA,maxxA,maxyA); }
}
