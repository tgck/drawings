int w = 800;
int h = 300;
float x, y, r;
float posx, posy, rad;

void setup (){
  size(w, h); 
  frame.setTitle("applyingNoise: x+=0.05, y+=0.001"); 
  x = 0;
  y = 0;
  r = 0;
}

void draw(){
  x += 0.05;    // important
  y += 0.001;  // important
  r += 0.05;
  posx = noise(x);
  posy = noise(y);
  rad  = noise(r);
  ellipse(map(posx, 0, 1, 0, w), 
          map(posy, 0, 1, 0, h),
          map(rad, 0, 1, 0, 20),
          1);
}
