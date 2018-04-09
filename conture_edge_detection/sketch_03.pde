import SimpleOpenNI.*;
SimpleOpenNI kinect;
int c=0;
IntList cIndex = new IntList();
void setup(){
 size(640,480);
 kinect= new SimpleOpenNI(this);
kinect.enableIR(); 
}
void draw(){
 loadPixels();
 cIndex.clear();
 for(int i=0;i<(640*480);i++){
  pixels[i]=color(0,0,0); 
 }
 kinect.update();
 PImage irIm=kinect.irImage();
 image(irIm,0,0);
 for(int i=0;i<640;i++){
  for(int j=0;j<480;j++){
   int c=get(i,j);
   if(c==-1){
    pixels[i+(640*j)]=color(255,255,255); 
   }
  } 
 }
updatePixels();
sharp();
updatePixels();
sharp();
updatePixels();
cornerDet();
updatePixels();
c=cIndex.size();
println(c);
for(int i=0;i<=cIndex.size()-1;i+=2){
  fill(0,255,0);
  
ellipse(cIndex.get(i),cIndex.get(i+1),10,10);  
}
}

void cornerDet(){
 for(int i=2;i<(640-2);i++){
 for(int j=2;j<(480-2);j++){
  int c0=get(i,j);
  int c1=get(i-1,j-1);
  int c2=get(i,j-1);
  int c3=get(i+1,j-1);
  int c4=get(i+1,j);
  int c5=get(i+1,j+1);
  int c6=get(i,j+1);
  int c7=get(i-1,j+1);
  int c8=get(i-1,j);

  if(c0==-1){
   if(c8==-1&&c1==-1&&c2==-1&&c3!=-1&&c4!=-1&&c5!=-1&&c6!=-1&&c7!=-1){
   pixels[i+(j*640)]=color(255,0,0); cIndex.append(i); cIndex.append(j);}
  else if(c2==-1&&c3==-1&&c4==-1&&c5!=-1&&c6!=-1&&c7!=-1&&c8!=-1&&c1!=-1){
  pixels[i+(j*640)]=color(255,0,0); cIndex.append(i); cIndex.append(j);}
  else if(c4==-1&&c5==-1&&c6==-1&&c7!=-1&&c8!=-1&&c1!=-1&&c2!=-1&&c3!=-1){
  pixels[i+(j*640)]=color(255,0,0); cIndex.append(i); cIndex.append(j);} 
  else if(c6==-1&&c7==-1&&c8==-1&&c1!=-1&&c2!=-1&&c3!=-1&&c4!=-1&&c5!=-1){
  pixels[i+(j*640)]=color(255,0,0); cIndex.append(i); cIndex.append(j);}
  //else {pixels[i+(j*640)]=color(0,0,0);}
  }
 } 
} 
}
void sharp(){
 for(int i=0;i<640-2;i++){
 for(int j=0;j<480-2;j++){
int c0=get(i,j);
for(int k=2;k<10;k++){
int c1=get(i+k,j);
int c2=get(i,j+k);
if(c0==-1&&c1==-1){
  for(int l=1;l<k;l++){
 pixels[i+l+(640*j)]=color(255,255,255);}}
if(c0==-1&&c2==-1){
  for(int l=1;l<k;l++){
  pixels[i+(640*(j+l))]=color(255,255,255);}}
 } 
 }} 
}
