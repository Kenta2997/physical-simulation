 
// pay_off 'c'
// Throw ' '
 
 
float vx=3;
float vy=0;
float e = 0.05;
int width=540,height=1000;
float x = width/2.0;
float y = 0;
float g = width*0.01;
float coind = width/9*0.8;
float point_r = 0.1;
bar bar1;

int have_coin = 30;

coin[] coins = new coin[100];
int ci = 0;

li[] lines = new li[8];
int pi = 0;
point[] points = new point[150];

int[] stock = new int[10];
int stocki = 0;


//x%9==0
void setup(){
  size(540, 1000);
  noStroke();
  frameRate(50);
  smooth();
  
  for (int i=0;i<8;i++){
    li lin = new li();
    lin.x1 = width/9*(i+1);
    lin.y1 = height;
    lin.x2 = width/9*(i+1);
    lin.y2 = height-width*0.2;
    lines[i] = lin;
    float yyy = height-width*0.2;
    while(yyy <= height) {
      point ppp = new point();
      ppp.x = width/9*(i+1);
      ppp.y = yyy;
      ppp.r = point_r;
      points[pi] = ppp;
      pi++;
      yyy += coind/2.0;
    }
  }
  for(int i=0;i<2;i++){
    points[pi+i] = new point();
    points[pi+i].x = width*i;
    points[pi+i].y = height-width*0.2;
    points[pi+i].r = point_r;
   }
  pi += 2;
  bar b1=new bar(),b2=new bar();
  b1.r = width*0.2;
  b1.si = b2.si = PI/2.0;
  b1.x = width/2;
  b1.y = 0;
  bar1 = b1;
  
  for(int i=0;i<7;i++){
    float py = height-width*0.2-width/9.0*(i+1.2);
    float pc = width / 9.0;
    float px = width/2.0 - 4.0*pc;
    if(i%2==1){
      px -= pc/2.0;
    }else{
        for(int j=0;j<2;j++){
        points[pi] = new point();
        points[pi+1] = new point();
        points[pi].y = py-pc*0.2*(j+1.0);
        points[pi+1].y = py-pc*0.2*(j+1.0);
        points[pi].x = px-pc*0.2*(j+1.0);
        points[pi+1].x = points[pi].x+(width/2.0-points[pi].x)*2;
        points[pi].r = point_r;
        points[pi+1].r = point_r;
        pi+=2;
      }
    }
    while(px<width){
      point ppp = new point();
      ppp.x = px;
      ppp.y = py;
      ppp.r = point_r;
      points[pi] = ppp;
      pi++;
      px += pc;
    }
  }
  
  
  
}

void draw() {
  background(255);
  fill(color(255, 0, 0));
  stroke(0,0,0);
  for(int i=0;i<8;i++){
    lines[i].dr();
  }
  fill(0);
  if(y>height-width*0.2){
    vx = 0;
  }
  y += vy;
  x += vx;
  vy += g;
  range_out();  
  coll_point();
  ellipse(x, y, coind, coind);
  
  bar1.dr();
  bar1.rote();
  for(int i=0;i<pi;i++){
     points[i].render();
  }
  
  for(int i=0;i<stocki;i++){
     //ellipse(width/18.0+stock[stocki]*coind, height-coind/2.0, coind, coind);
     ellipse(width/18.0+(stock[i]*width/9.0), height-coind/2.0, coind, coind);
  }


  if(y>height-coind*1.1){
     int coinxnow=-1;
     float xbar = width/9.0;
     while(xbar<=width){
       if(x<xbar){
         coinxnow++;
         xbar += width;
       }else{
         coinxnow++;
         xbar += width/9.0;
       }
     }
     for(int i=0;i<stocki;i++){
       if(coinxnow == stock[i]){
         stocki = -1;
       }
     }
     if(stocki!=-1){
       if(coinxnow!=0&&coinxnow!=8){
         stock[stocki] = coinxnow;
         stocki++;
       }else{
         int rnd = (int)random(0,100);
         if(rnd<4){
           println("....+3");
           have_coin += 3;
         }else if(rnd<7){
           println("....+5");
           have_coin += 5;
         }else if(rnd<9){
           println("....+10");
           have_coin += 10;
         }else if(rnd<10){
           println("....+30");
           have_coin += 30;
         }else{
           println("....+0");
         }
       }
     }else{
       stocki = 0;
       //delay(500);
     }
     x = width/2;
     y = 0;
     g = 0;
     vx = 0;
     vy = 0;
  }
  
  fill(color(0, 0, 255));
  textSize(32);
  text("WIN:"+Integer.toString(win()), width/5.0, height/3.0);
  text("CREDIT:"+Integer.toString(have_coin), width*3.0/5.0, height/3.0);
}







class li{
  float x1,x2,y1,y2;
  void dr(){
    line(this.x1,this.y1,this.x2,this.y2);
  }
}
class bar{
  float x,y,r,si=PI*3/2,vsi=0.039;
  float si_range = PI/4.0;
  void dr(){
    line(this.x,this.y,this.x-cos(this.si)*r,this.y-sin(this.si)*r);
  }
  void rote(){
    this.si += this.vsi;
    if(this.si>(this.si_range+PI*3/2)){
      this.vsi *= -1;
      this.si=(this.si_range+PI*3/2);
    }else if(this.si<(PI*3/2-this.si_range)){
      this.vsi *= -1;
      this.si=(PI*3/2-this.si_range);
    }
  }
}
class point{
  float x,y,r;
  void render() {
    ellipse(this.x, this.y, this.r * 2, this.r * 2);
  }
}
class coin{
  float x=width/2.0,y=height/2.0,vx=0,vy=0,r=coind;
  //float x=1/2.0,y=1/2.0,vx=0,vy=0,r=1;
  int position;
  void render() {
    ellipse(this.x, this.y, this.r * 2, this.r * 2);
  }
  void go(){
    this.vy += 1.5;
  }
}
void keyPressed() {
  if ( key == ' ' && y==0) {
     x = width/2;
     y = 0;
     g = width*0.01;
     vx = -30*cos(bar1.si);
     vy = -20*sin(bar1.si);
     have_coin--;
     if(have_coin<0)have_coin=30;
     println(have_coin);
  }
  if(key  == 'c'){
    int[] there = new int[9];
    for(int i=0;i<9;i++){
      there[i]=0;
    }
    for(int i=0;i<stocki;i++){
      there[stock[i]]=1;
    }
    int getc = 0;
    int ren = 0;
    for(int i=1;i<9;i++){
      if(there[i]==1){
        ren++;
      }else{
        if(ren==2)getc+=4;
        if(ren==3)getc+=6;
        if(ren==4)getc+=20;
        if(ren==5)getc+=60;
        if(ren==6)getc+=120;
        if(ren==7)getc+=240;
        ren = 0;
      }
    }
    if(getc>0){
      println("Good!! get",getc,"coins");
      have_coin += getc;
      stocki=0;
    }
  }
}
void range_out(){
  if(x-coind/2<0){
    x = coind/2;
    if(vx<0)vx = -vx*e;
  }
  if(x+coind/2>width){
    x = width-coind/2;
    if(vx>0)vx = -vx*e;
  }
  if(y+coind/2>height){
    y = height-coind/2;
    if(vy>0)vy = -vy*e;
  }
}
void coll_point(){
  for(int i=0;i<pi;i++){
     float dx = points[i].x - x;
     float dy = points[i].y - y;
     float d = sqrt(dx * dx + dy * dy);
     /*if(d<coind/2+points[i].r){
       dx /= d;
       dy /= d;
       float naiseki = vx*dx+vy*dy;
       vx -= naiseki*dx*(1.0+e);
       vy -= naiseki*dy*(1.0+e);
       x = points[i].x - dx*(coind+points[i].r);
       y = points[i].y - dy*(coind+points[i].r);
     }*/
     if(d<coind/2){
       dx /= d;
       dy /= d;
       float naiseki = vx*dx+vy*dy;
       vx -= naiseki*dx*(1.0+e);
       vy -= naiseki*dy*(1.0+e);
       x = points[i].x - dx*(coind+points[i].r);
       y = points[i].y - dy*(coind+points[i].r);
     }
  }
}
int win(){
    int[] there = new int[9];
    for(int i=0;i<9;i++){
      there[i]=0;
    }
    for(int i=0;i<stocki;i++){
      there[stock[i]]=1;
    }
    int getc = 0;
    int ren = 0;
    for(int i=1;i<9;i++){
      if(there[i]==1){
        ren++;
      }else{
        if(ren==2)getc+=4;
        if(ren==3)getc+=6;
        if(ren==4)getc+=20;
        if(ren==5)getc+=60;
        if(ren==6)getc+=120;
        if(ren==7)getc+=240;
        ren = 0;
      }
    }
    return getc;
}