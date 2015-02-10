float r;
final float PARAM_R = 1.3;

void setup (){
  size(800, 300);
  strokeWeight(22);
  smooth();
  
  r = 0;
}

void draw(){
  
  r += PARAM_R;
  int r_normed = (int)map(r, 0, 1, 0, 255);
  stroke(color(r_normed, 0, 0));
  
  ellipse(50 + 800/4, 300/2, 260, 260);
  ellipse(-50 + 800/4 * 3, 300/2, 260, 260);
}
