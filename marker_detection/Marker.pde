class Marker{
 int type;
 //PVector or= new PVector(0,0);
 PVector realW= new PVector(0,0);
 int indexM;
 float x; float y;
 Marker(int i, int t,PVector r){
  indexM=i; type=t; realW=r;
  //if(type==3||type==4){or=PVector.sub(e,s);}
  x=indexM%640; y=(indexM-x)/640;
 }
 void display(){
  switch(type){
    case 1: noFill(); stroke(0,255,0); strokeWeight(3); ellipse(x,y,20,20); break;//5cm radius circle with hole of 3cm radius
    case 2: noStroke(); fill(255,0,0);  ellipse(x,y,20,20); break;//two stripes with 3cm distance
    case 3: noStroke(); fill(204,10,255); ellipse(x,y,20,20); break; //two stripes with 8cm distance
    case 4: noStroke(); fill(255,229,204); ellipse(x,y,20,20); break; //two stripes with 12cm distance
  }
 }

}
