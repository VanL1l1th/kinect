class Attractor{
 int type=0;
 int coA=0;
 int countA=0;
 int count2A=0;
 int countSpeed=0;
 float speedA=0;
 PVector posAp= new PVector(0,0);
 PVector posA= new PVector(0,0);
 boolean match=false;
 float minxA; float minyA; float maxxA; float maxyA;
Attractor(int c){coA=c;
if(coA==0){type=0;}
else{type=1;}
}

void update(float x,float y){
posA=new PVector(x,y);  
}

void display(){
 switch(type){
  case 0: fill(255); ellipse(posA.x,posA.y,20,20); break;
  case 1: fill(255,0,0); ellipse(posA.x,posA.y,20,20); break;
  case 2: fill(0,255,0); ellipse(posA.x,posA.y,20,20); break;
 }
}
void matched(){match=true;} 
void dematch(){match=false;}

void become(Attractor other){
 if(type==0){type=other.type;}
 posA=other.posA;
}
void getRect(float mix, float max, float miy, float may){
minxA=mix; minyA=miy; maxxA=max; maxyA=may;
}
void speed(){
if(countSpeed<2){posAp=posA;}
if(countSpeed>10){
  float d =PVector.dist(posA,posAp);
  speedA=d;
  countSpeed=0;}
  countSpeed++;
}
}
