float h, s, v;
final float PARAM_H = 0.001;
final float PARAM_S = 0.03;
final float PARAM_V = 0.007;
int cnt;
int bgcol;

void setup (){
  size(800, 300);
  colorMode(HSB, 3600, 100, 100);
  blendMode(LIGHTEST);  // p5 2+  https://processing.org/reference/blendMode_.html
  noStroke();
  smooth();
  
  h = 0; // 
  s = 0; // 0: dull white -> 100: 
  v = 0; // 0: dark black -> 100: blight
  
  cnt = 0; 
  bgcol = #ff00ff;
}

void draw(){
  background(bgcol);
  
  h += PARAM_H;
  s += PARAM_S;
  v += PARAM_V;
  int r_normed = (int)map(noise(h), 0, 1, 0, 3600);
  int g_normed = (int)map(noise(s), 0, 1, 80, 100);
  int b_normed = (int)map(noise(v), 0, 1, 80, 100);
  
  // left circle
  println(r_normed + "  " + g_normed + "  " + b_normed);
  
  fill(r_normed, g_normed, b_normed);
  ellipse(120 + 800/4, 300/2, 260, 260);
  
  // for compare
  fill(0, 0, 100);
  ellipse(-120 + 800/4 * 3, 300/2, 260, 260);
}

// switch blend mode,  
// or switch background color
void keyPressed(){
  switch (key) {
     case 'a':
     case ' ':  windowSetTitle(toggleBlendMode()); break;
     case '1':  bgcol = #000000; break;
     case '2':  bgcol = #770000; break;
     case '3':  bgcol = #ff0000; break; 
     case '4':  bgcol = #007700; break;
     case '5':  bgcol = #00ff00; break;
     case '6':  bgcol = #000077; break;
     case '7':  bgcol = #0000ff; break;
     case '8':  bgcol = #ffff00; break;
     case '9':  bgcol = #00ffff; break;
     case '0':  bgcol = #ff00ff; break;
     case '-':  bgcol = #ffffff; break;
     case '=':  bgcol = #777777; break;
     default:   break;
  } 
}

void windowSetTitle(String str){
  frame.setTitle(str);  
}

// uses Enum
String toggleBlendMode(){
  MyBlendModes next = MyBlendModes.values()[(cnt++)%10];
  blendMode(next.ordinal());
  return next.toString();
}



