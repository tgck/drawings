int bgcol;
Underbar mybar;
//float K_WIDTH = 0.667; // drawing width ratio
float K_WIDTH = 1.0; // drawing width ratio
boolean bEnableTurn = true;

void setup (){
  size(300, 300);
  colorMode(HSB, 3600, 100, 100);
  blendMode(LIGHTEST);  // p5 2+  https://processing.org/reference/blendMode_.html
  smooth();
  frameRate(60);

  //bgcol = #ff00ff;
  mybar = new Underbar();
}

void draw(){
  background(bgcol);

  pushMatrix();
  translate(width/2, 0);
  scale(K_WIDTH, 1);
  mybar.tick();
  mybar.draw();

  popMatrix();
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
  float speed;

  Underbar() {
    p = new PVector(0, 0);
    len = width * 0.8;
    speed = 0.5;
  }
  void draw(){
    stroke(100, 100, 100);
    line(this.p.x - len/2, this.p.y, this.p.x + len/2, this.p.y);
  }
  void tick(){
    if (bEnableTurn) {
      this.p.y += speed;
      if (this.p.y >= height || this.p.y <= 0) turn();
    } else { // wrap at border
      this.p.y += speed;
      if (this.p.y > height ) this.p.y = 0;
      if (this.p.y < 0) this.p.y = height;
    }
  }
  private void turn(){
    this.speed *= -1;
  }
}


