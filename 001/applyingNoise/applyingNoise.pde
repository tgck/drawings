float posx, x;
int w = 800;

void setup (){
  size(w, 300);  
  x = 0;
}

void draw(){
  x += 0.1;
  posx = noise(x);
  ellipse(map(posx, 0, 1, 0, w), 100, 30, 30);
}
