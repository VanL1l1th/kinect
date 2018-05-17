class Attractor{
 int type=0;
 int coA=0;
 int countA=0;
 int count2A=0;
 PVector posA= new PVector(0,0);
 boolean match=false;

Attractor(float x, float y){posA=new PVector(x+120,y);}


void display(){
 fill(255); ellipse(posA.x,posA.y,20,20);
}

}
