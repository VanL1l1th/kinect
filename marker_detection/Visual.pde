class Visual{
PVector pos=new PVector(0,0);
 int uId;
 int mId;
Visual(PVector ip,int u, int m){
 pos=ip; uId=u; mId=m; 
}
 
 void display(){
   switch(mId){
    case 1: noFill(); stroke(0,255,0); strokeWeight(3); ellipse(pos.x,pos.y,30,30); break;
    case 2: noStroke(); fill(255,0,0); ellipse(pos.x,pos.y,30,30); break;
    case 3: noStroke(); fill(204,10,255); ellipse(pos.x,pos.y,30,30); break;
    case 4: noStroke(); fill(255,229,204); ellipse(pos.x,pos.y,30,30); break;
   }
   update();
 }
 void update(){
  kinect.getCoM(uId,pos);
 kinect.convertRealWorldToProjective(pos, pos); 
 }
}
