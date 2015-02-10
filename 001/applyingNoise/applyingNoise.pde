int x;

void setup (){
  size(800, 300);  
  x = 0;
}

void draw(){
  x += 1;
  ellipse(x, 100, 30, 30);
}
