class Disease{
 PVector mDis=new PVector(0,0);
 ArrayList<PVector> pointsDis;
 float rDis=10;
 int counterDis=0;
 Disease(){
 pointsDis=new ArrayList<PVector>();
 pointsDis.add(new PVector(0,0));}
 
 void display(float x, float y){
   pushMatrix();
   translate(x,y);
   fill(0);
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
   //println(pointsDis.size());
 }
 void grow(){
  if(counterDis%10==0){
  for(int i=0;i<(counterDis/8)+5;i++){float a=random(0,2*PI);
  float x=rDis*(counterDis/10)*cos(a); float y=rDis*(counterDis/10)*sin(a);
  pointsDis.add(new PVector(x,y));
  }}
  counterDis++; 
 }
}
