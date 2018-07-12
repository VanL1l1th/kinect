class Blob{
int minx;
int maxx;
int miny;
int maxy;
color col=color(255,0,0);
ArrayList<PVector> points;
Blob(int x,int y){
 minx=x; maxx=x; miny=y; maxy=y;
 points= new ArrayList<PVector>();
 points.add(new PVector(x,y));
}

void addp(int x,int y){
 minx=min(minx,x); maxx=max(maxx,x);
 miny=min(miny,y); maxy=max(maxy,y);
 if(minx==x||miny==y||maxx==x||maxy==y){
 points.add(new PVector(x,y)); }
}
void display(){
  rectMode(CORNERS);
  fill(255,10);
  stroke(col);
  strokeWeight(2);
 rect(minx,miny,maxx,maxy); 
}
int area(){
 return (maxx-minx)*(maxy-miny); 
}

boolean isNear(int x,int y){
  float dis=100000;
  for(PVector p: points){
   float d= distSq(x,y,p.x,p.y);
  if(d<dis){
   dis=d;} 
  }
  if(dis<(spaceBlobs*spaceBlobs)){
  return true;}
  else{return false; }
 }
 
 float mx(){float m=minx+((maxx-minx)/2); return m; }
 float my(){float m=miny+((maxy-miny)/2); return m;}
}
float distSq(int x1, int y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}

