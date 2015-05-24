int bgcol;
Underbar mybar;

void setup (){
  size(300, 300);
  colorMode(HSB, 3600, 100, 100);
  blendMode(LIGHTEST);  // p5 2+  https://processing.org/reference/blendMode_.html
  smooth();
  
  //bgcol = #ff00ff;
  mybar = new Underbar();
}

void draw(){
  background(bgcol);
  mybar.tick();
  mybar.draw();
}


void keyPressed(){
  switch (key) {
     case '1':  bgcol = #000000; break;
     default:   break;
  } 
}
class Underbar{
  PVector p;
  float len;
  
  Underbar() {
    p = new PVector(random(1.0), random(1.0));
    len = 100;
  }
  void draw(){
    stroke(100, 100, 100);
    line(this.p.x, this.p.y, this.p.x+len, this.p.y);
  }
  void tick(){
    this.p.y += 1.0;
    if (this.p.y > height ) this.p.y = 0;
    if (this.p.y < 0) this.p.y = height;
  }
}


