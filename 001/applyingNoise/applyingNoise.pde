int w = 800;
int h = 300;
int x;
float posx, posy;

void setup (){
  size(w, 300);  
  x = 0;
}

void draw(){
  x += 1;
  posx = noise(x);
  posy = noise(x+10000);
  ellipse(map(posx, 0, 1, 0, w), 
          map(posy, 0, 1, 0, 0.3*h + h/2),
          30, 30);
}
