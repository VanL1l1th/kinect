class particle{
PVector pos;
PVector vel;
PVector acc;
int life;
particle(PVector p){
 pos= p.get(); vel= new PVector(random(-3,3),random(-3,3));
acc= new PVector(0,0.05); life=255; 
}
void update(){
 vel.add(acc);
 pos.add(vel);
 life-=4; 
}
void display(){
 update();
 noStroke();
 fill(255,life);
 ellipse(pos.x,pos.y,5,5); 
}
boolean dead(){
 if(life<0){
 return true;}
else{
return false;} 
}
}
