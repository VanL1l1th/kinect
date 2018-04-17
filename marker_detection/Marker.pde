class Marker{
 int type;
 PVector or= new PVector(0,0);
 int indexM;
 float x; float y;
 Marker(int i, int t,PVector s,PVector e){
  indexM=i; type=t; 
  if(type==3||type==4){or=PVector.sub(e,s);}
  x=indexM%640; y=(indexM-x)/640;
 }
 void display(){
  switch(type){
    case 0: fill(255,0,0); noStroke(); ellipse(x,y,20,20); break;// single stripe
    case 1: fill(0,255,0); noStroke(); ellipse(x,y,20,20); break;// full circle with 5cm radius
    case 2: stroke(0,255,0); noFill(); strokeWeight(3); ellipse(x,y,20,20); break;//5cm radius circle with hole of 3cm radius
    case 3: noStroke(); fill(204,255,255); ellipse(x,y,20,20); break; //two stripes with 10cm distance
    case 4: noStroke(); fill(255,229,204); ellipse(x,y,20,20); break; //two stripes with 15cm distance
  }
 }
}
