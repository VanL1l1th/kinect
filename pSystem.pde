class pSystem{
 ArrayList<particle> par;
 PVector origin;
pSystem(PVector o){
 origin = o.get(); par= new ArrayList<particle>();
}
void addPar(){
 par.add(new particle(origin)); 
}
void display(){
 for(int i=par.size()-1;i>=0;i--){
 particle p= par.get(i);
 p.display();
 if(p.dead()){
  par.remove(i);} 
 }
 for(int i=0;i<3;i++){
 addPar();}}
 void updateO(PVector o){
  origin = o; 
 }
}
