class Explosion{
 int indexEx;
 PVector originEx;
 ArrayList<ParticleEx> particlesEx;
 Explosion(int at){
   indexEx=at;
  float ax=attractors.get(indexEx).posA.x; float ay=attractors.get(indexEx).posA.y;
  originEx=new PVector(ax,ay);
  particlesEx=new ArrayList<ParticleEx>();
  for(int i=0;i<50;i++){
  particlesEx.add(new ParticleEx(ax,ay));}
 }
 void display(){
  for(ParticleEx p: particlesEx){p.display();} 
 }
}

class ParticleEx{
 PVector posPe= new PVector(0,0);
 PVector velPe;
 int radiusPe;
 int colorPe; 
 ParticleEx(float x,float y){
   posPe=new PVector(x,y);
   radiusPe=int(random(1,10)); colorPe=int(random(150,255));
   velPe=new PVector(random(-6,6),random(-8,7));
 }
 void display(){
   fill(colorPe); noStroke();
   ellipse(posPe.x,posPe.y,radiusPe,radiusPe);
   posPe.add(velPe);
 }
 void changeC(){
  colorPe--; 
 }
}

class ExplosionOr{
 PVector originEx=new PVector(0,0);
 ArrayList<ParticleEx> particlesExO;
 boolean removeEx=false;
 ExplosionOr(PVector p){
  originEx=p; 
  particlesExO=new ArrayList<ParticleEx>();
  for(int i=0;i<50;i++){
  particlesExO.add(new ParticleEx(originEx.x,originEx.y));}
 }
 void display(){
  for(int i=particlesExO.size()-1;i>=0;i--){particlesExO.get(i).display(); particlesExO.get(i).changeC();
  float c=particlesExO.get(i).colorPe; if(c<10){particlesExO.remove(i);}} 
  if(particlesExO.size()<5){removeEx=true;}
 }
}
