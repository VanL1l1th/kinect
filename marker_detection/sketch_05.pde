import SimpleOpenNI.*;
//import processing.opengl.*;
SimpleOpenNI kinect;
int c=0;
int spaceBlobs=10;
int tol=10;
ArrayList<Blob> blobs;
ArrayList<Marker> markers;
void setup(){
 size(640,480,P3D);
 kinect= new SimpleOpenNI(this);
kinect.enableIR(); 
kinect.enableDepth();
blobs= new ArrayList<Blob>();
markers= new ArrayList<Marker>();
}
void draw(){
 loadPixels();
 blobs.clear();
 markers.clear();
background(0);
 kinect.update();
 PImage irIm=kinect.irImage();
 image(irIm,0,0);
 for(int i=0;i<640;i++){
  for(int j=0;j<480;j++){
   int c=get(i,j);
   if(c==-1){
    pixels[i+(640*j)]=color(255,255,255); 
   }else{pixels[i+(640*j)]=color(0,0,0); }
  } 
 }
updatePixels();
sharp();
updatePixels();
sharp();
updatePixels();
createBlob();
PVector[] depthPoints = kinect.depthMapRealWorld();

for(int i=blobs.size()-1;i>=0;i--){
  boolean add=false;
if(blobs.get(i).col==color(0,255,0)){
markers.add(new Marker(blobs.get(i).index(),1,null,null)); add=true;}
else if(blobs.get(i).col==color(0,0,255)){
markers.add(new Marker(blobs.get(i).index(),2,null,null)); add=true;}
else if(add==false){
PVector p1= depthPoints[blobs.get(i).index()];
for(int j=blobs.size()-1;j>=0;j--){
PVector p2= depthPoints[blobs.get(j).index()];
float dist3=sqrt(sq(p1.x-p2.x)+sq(p1.y-p2.y)+sq(p1.z-p2.z));
if(dist3>50&&dist3<120){markers.add(new Marker(blobs.get(i).index(),3,p1,p2)); add=true;}
else if(dist3>120&&dist3<200){markers.add(new Marker(blobs.get(i).index(),4,p1,p2)); add=true;}
if(add==true){blobs.get(j).bool=false;}}}
if(add==false&&blobs.get(i).bool==true){markers.add(new Marker(blobs.get(i).index(),0,null,null)); println("wwwww");}
blobs.remove(i);}
blobs.clear();
background(0);
for(Marker m: markers){
m.display(); m.or();}

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
  pixels[i+(640*(j+l))]=color(255,255,255);}}} 
 }} 
}

void createBlob(){
 for(int i=0;i<640;i++){
 for(int j=0;j<480;j++){
 int c= get(i,j);
 if(c==-1){
  boolean found=false;
  for(Blob b:blobs){
  if(b.isNear(i,j)==true){
  b.addp(i,j); found=true;}  
  }
  if(found==false){
  blobs.add(new Blob(i,j));}
 }
 }}
 for(int i=blobs.size()-1;i>=0;i--){
  if(blobs.get(i).area()<160){blobs.remove(i);} 
 }
 for(Blob b:blobs){
  b.circles();
  b.display();
 }
}

float distSq(int x1, int y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}
