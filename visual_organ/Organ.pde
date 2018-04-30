class Organ{
 PVector posO=new PVector(0,0);
 ArrayList<Cell> cells;
 int nc;
 Organ(PVector p,int n){
   posO=p; nc=n+1;
   cells= new ArrayList<Cell>();
   for(int i=0;i<nc;i++){
     int r=int(width/100);
     float a=(2*PI)/(nc-1); float x=posO.x+(r*9)*cos(a*i); float y=posO.y+(r*8)*sin(a*i);
     PVector p2=new PVector(x,y);
   cells.add(new Cell(r,p2));}
 }
 
 void display(){
 for(Cell c: cells){
 c.display();}}
 
}
