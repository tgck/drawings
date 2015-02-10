int w = 800;
int h = 300;
float x, y, r;
float posx, posy, rad;

final float paramX = 0.05;
final float paramY = 0.01;
final float paramR = 0.3;

void setup (){
  size(w, h); 
  frame.setTitle("applyingNoise: x+= " + paramX 
                  + "   y+= " + paramY
                  + "   r+= " + paramR); 
  x = 0;
  y = 0;
  r = 0;
  smooth();
  noStroke();

}

void draw(){
  x += paramX;    // important
  y += paramY;  // important
  r += paramR;
  posx = noise(x);
  posy = noise(y);
  rad  = noise(r);
  ellipse(map(posx, 0, 1, 0, w), 
          map(posy, 0, 1, 0, h),
          map(rad, 0, 1, 0, 20),
          map(rad, 0, 1, 0, 20)
          );
}
