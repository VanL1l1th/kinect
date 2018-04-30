Cell cell1;
Organ organ;
PVector pos1;


void setup(){
  size(640,480);
 pos1=new PVector(width/2,height/2);
 cell1=new Cell(int(width/100),pos1);
 organ=new Organ(pos1,7);
}

void draw(){
  background(0);
 cell1.display();
 organ.display();
}
