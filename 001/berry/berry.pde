float h, s, v;
final float PARAM_H = 0.001;
final float PARAM_S = 0.03;
final float PARAM_V = 0.007;

void setup (){
  size(800, 300);
  colorMode(HSB, 3600, 100, 100);
  //blendMode(LIGHTEST);  // p5 2+  https://processing.org/reference/blendMode_.html
  noStroke();
  smooth();
  
  h = 0; // 
  s = 0; // 0: dull white -> 100: 
  v = 0; // 0: dark black -> 100: blight
}

void draw(){
  
  background(128);
  h += PARAM_H;
  s += PARAM_S;
  v += PARAM_V;
  int r_normed = (int)map(noise(h), 0, 1, 0, 3600);
  int g_normed = (int)map(noise(s), 0, 1, 80, 100);
  int b_normed = (int)map(noise(v), 0, 1, 80, 100);
  
  println(r_normed + "  " + g_normed + "  " + b_normed);
  fill(r_normed, g_normed, b_normed);

  ellipse(120 + 800/4, 300/2, 260, 260);
  
  fill(0, 0, 100);
  ellipse(-120 + 800/4 * 3, 300/2, 260, 260);
}

//BLEND - linear interpolation of colours: C = A*factor + B. This is the default blending mode.
//ADD - additive blending with white clip: C = min(A*factor + B, 255)
//SUBTRACT - subtractive blending with black clip: C = max(B - A*factor, 0)
//DARKEST - only the darkest colour succeeds: C = min(A*factor, B)
//LIGHTEST - only the lightest colour succeeds: C = max(A*factor, B)
//DIFFERENCE - subtract colors from underlying image.
//EXCLUSION - similar to DIFFERENCE, but less extreme.
//MULTIPLY - multiply the colors, result will always be darker.
//SCREEN - opposite multiply, uses inverse values of the colors.
//REPLACE - the pixels entirely replace the others and don't utilize alpha (transparency) values
