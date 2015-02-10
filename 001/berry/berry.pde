float r, g, b;
final float PARAM_R = 0.04;
final float PARAM_G = 0.1;
final float PARAM_B = 0.07;

void setup (){
  size(800, 300);
  strokeWeight(22);
  smooth();
  
  r = 0;
  g = 0;
  b = 0;
}

void draw(){
  // fill black inside the circles
  fill(0);
  ellipse(50 + 800/4, 300/2, 260, 260);
  ellipse(-50 + 800/4 * 3, 300/2, 260, 260);  
  
  // fill rings with changing color
  fill(128);
  background(128);
  r += PARAM_R;
  g += PARAM_G;
  b += PARAM_B;
  int r_normed = (int)map(noise(r), 0, 1, 128, 155);
  int g_normed = (int)map(noise(g), 0, 1, 128, 155);
  int b_normed = (int)map(noise(b), 0, 1, 128, 155);
  
  println(r_normed + "  " + g_normed + "  " + b_normed);
  stroke(r_normed, g_normed, b_normed);
  
  ellipse(50 + 800/4, 300/2, 260, 260);
  ellipse(-50 + 800/4 * 3, 300/2, 260, 260);
}
