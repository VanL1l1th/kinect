class Cell{
 PVector posC=new PVector(0,0);
 int radiusC;
 ArrayList<colorC> colores;
 int nC=10;
 boolean max=false;
 
 Cell(int r,PVector p){
 posC=p; radiusC=r;
 colores= new ArrayList<colorC>();
 for(int i=0;i<nC;i++){
   int c=int((255/(nC-1))*i);
 colores.add(new colorC(c));}
 }
 void display(){
   int j=0;
   for(int i=nC;i>0;i--){
   int r=int(i*radiusC);
   int c2=colores.get(j).c;
   fill(c2);
   noStroke();
   ellipse(posC.x,posC.y,r,r);
   j++; 
   }
   for(colorC c: colores){c.update();}
 }
 

}
class colorC{
boolean max=false;
int c=0;
colorC(int ic){
c=ic;}

void update(){
 if(max==false){c++;}
 if(max==true){c--;}
 if(c>250){max=true;}
 if(c<10){max=false;}
}}
