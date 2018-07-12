class Lava{
 float maxxL;
 float maxyL;
 float minxL;
 float minyL;
 int indexL;
 ArrayList<Drop> drops;
 ArrayList<DropS> dropS;
Lava(int ia){
  indexL=ia;
 maxxL=cAttractors.get(ia).maxxA+200; minxL=cAttractors.get(ia).minxA+200; 
 maxyL=cAttractors.get(ia).maxyA; minyL=cAttractors.get(ia).minyA; 
 drops= new ArrayList<Drop>();
 dropS= new ArrayList<DropS>();
 for(int i=0; i<5; i++){
   PVector pos=new PVector(random(minxL,maxxL),random(minyL,maxyL));
 drops.add(new Drop(pos));}
 for(int i=0; i<7; i++){
 PVector pos=new PVector(random(minxL,maxxL),random(minyL,maxyL));
 dropS.add(new DropS(pos,drops));}
}

void display(){
  maxxL=cAttractors.get(indexL).maxxA-50; minxL=cAttractors.get(indexL).minxA+50; 
  maxyL=cAttractors.get(indexL).maxyA; minyL=cAttractors.get(indexL).minyA; 
  for(Drop d: drops){
  d.display();
  d.radius();
  d.move(minxL,maxxL,minyL,maxyL);
  //d.repulse(drops);
  }
  for(DropS d: dropS){
  d.display();
  d.radius();
  d.move(minxL,maxxL,minyL,maxyL);
  }
}
}

class Drop{
 PVector velD;
 PVector posD;
 float rxD;
 float ryD;
 int maxrx;
 int maxry;
 int adderx=1;
 int addery=-1;
 float damp=0.9;
 float mr=random(0.08,0.3);
 boolean out=false;
 int cD=0;
 
 Drop(PVector pos){
 posD=pos; rxD=random(2,40); ryD=random(2,40); maxrx=int(random(30,60)); maxry=int(random(30,60));
 velD=new PVector(random(-3,3),random(-3,3));}
 
 void radius(){
 if(rxD>maxrx){adderx=-1;} if(ryD>maxry){addery=-1;}
 if(rxD<20){adderx=1;}   if(ryD<20){addery=1;}
 rxD+=(adderx)*0.1; ryD+=(addery)*0.2;
 }
 void move(float minx, float maxx, float miny, float maxy){
   posD.add(velD); //velD.mult(damp);
   PVector mPoint=new PVector(minx+((maxx-minx)*0.5),miny+((maxy-miny)*0.5));
   PVector df=PVector.sub(mPoint,posD);
   float dis=PVector.dist(mPoint,posD);
   df.mult(1.2/dis);
   if(posD.x>maxx||posD.x<minx){velD.add(df); velD.mult(0.8); out=true;}
   else if(posD.y>maxy||posD.y<miny){velD.add(df); velD.mult(0.8); out=true;}
   else if(out==true){velD=new PVector(random(-3,3),random(-3,3)); out=false;}
 }
 
 void display(){
 noStroke(); fill(cD);
 ellipse(posD.x,posD.y,rxD,ryD);
 ellipse(posD.x+(ryD)*mr,posD.y,rxD,ryD+10*mr);
 ellipse(posD.x+(rxD)*mr,posD.y+(ryD)*mr,rxD,ryD+10*mr);
 if(cD<240){cD+=10;}else{cD=255;}}
}
class DropS{
 PVector posDs;
 PVector velDs;
 float rDs;
 float dampD=0.5;
 int adderx=1;
 int indexD;
 ArrayList<Drop> drops2= new ArrayList<Drop>();
 int cDs=0;
 
 DropS(PVector pos,ArrayList<Drop> d){
   drops2=d;
   indexD=int(random(0,drops2.size()));
 posDs=pos; velDs=new PVector(random(-1,1),random(-1,1));
 rDs=random(2,10);}
 
 void move(float minx, float maxx, float miny, float maxy){
   posDs.add(velDs); velDs.mult(dampD); attract(); 
   //if(posDs.x>maxx||posDs.x<minx){float x=-1*velDs.x; float y=velDs.y; velDs= new PVector(x,y);}
   //if(posDs.y>maxy||posDs.y<miny){float y=-1*velDs.y; float x=velDs.x; velDs= new PVector(x,y);}
 }
 
 void radius(){
 if(rDs>10){adderx=-1;}// if(rDs>10){addery=-1;}
 if(rDs<2){adderx=1;}   //if(rDs<20){addery=1;}
 rDs+=(adderx)*0.09; 
 }
 
 void attract(){
 Drop d=drops2.get(indexD);
 float dis =PVector.dist(d.posD,posDs);
 for(Drop d2:drops2){
  float dis2=PVector.dist(d2.posD,posDs);
 if(dis2<dis){dis=dis2; d=d2;} 
 }
 if(dis>2*rDs){
 PVector df=PVector.sub(d.posD,posDs);
 df.mult(0.8/dis);
 velDs.add(df);
 }

 }
 void display(){
 noStroke(); fill(cDs);
 ellipse(posDs.x,posDs.y,rDs,rDs);
 if(cDs<240){cDs+=10;} else{cDs=255;}
}

}
