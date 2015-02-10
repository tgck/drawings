float r, g, b;
final float PARAM_R = 0.004;
final float PARAM_G = 0.1;
final float PARAM_B = 0.007;

void setup (){
  size(800, 300);
  colorMode(HSB, 3600, 100, 100);
  blendMode(LIGHTEST);  // p5 2+  https://processing.org/reference/blendMode_.html
  noStroke();
  smooth();
  
  r = 0;
  g = 0;
  b = 0;
}

void draw(){
  
  background(128);
  r += PARAM_R;
  g += PARAM_G;
  b += PARAM_B;
  int r_normed = (int)map(noise(r), 0, 1, 0, 120);
  int g_normed = (int)map(noise(g), 0, 1, 100, 255);
  int b_normed = (int)map(noise(b), 0, 1, 0, 120);
  
  println(r_normed + "  " + g_normed + "  " + b_normed);
  fill(r_normed, g_normed, b_normed);

  ellipse(120 + 800/4, 300/2, 260, 260);
  
  fill(244, 244, 244);
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
