Disease disease;
Disease dis2;
void setup(){
 disease=new Disease();
 dis2=new Disease();
 size(400,400); 
}
void draw(){
 background(255);
 disease.display(width/3,height/2); 
 println(frameRate);
}
