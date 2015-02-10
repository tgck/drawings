int w = 800;
int h = 300;
float x, y;
float posx, posy;

void setup (){
  size(w, 300); 
 frame.setTitle("applyingNoise: x+=0.05, y+=0.001"); 
  x = 0;
  y = 0;
}

void draw(){
  x += 0.05;    // important
  y += 0.001;  // important
  posx = noise(x);
  posy = noise(y);
  ellipse(map(posx, 0, 1, 0, w), 
          map(posy, 0, 1, 0, h),
          30, 30);
}
