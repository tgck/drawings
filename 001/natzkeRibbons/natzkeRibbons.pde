

//================================= colour sampling
// 画像ファイルを元に、600の長さを持つcolor配列を作成する。
// 呼び出しは、setup()の中で一回だけ。

int numcols = 600; // 30x20
color[] colArr = new color[numcols];

void sampleColour() {
  PImage img;
  // img = loadImage("tricolpalette.jpg");
  // img = loadImage("moody.jpg");
  img = loadImage("yellowpalette.jpg");
  image(img,0,0);
  int count = 0;
  for (int x=0; x < img.width; x++){
    for (int y=0; y < img.height; y++) {
      if (count < numcols) {
        color c = get(x,y);
        colArr[count] = c;
      }
      count++;
    }
  }  
}

//================================= global vars

int _numRibbons = 5;  // 3
int _numParticles = 20; // 40 //  20 is good
float _randomness = .05; // .2
RibbonManager ribbonManager;

float _a, _b, _centx, _centy, _x, _y;
float _noiseoff;
int _angle;

//================================= init
// setup
// - 色配列の作成
// - 描画中心の決定
//


void setup() {
  //size(500, 300);
  size(1000, 300);
  smooth(); 
  frameRate(30);
  background(0);
 
  setupReceiver(); // OSC

  sampleColour();
  clearBackground();
  
  _centx = (width / 2);   // drawの中で使うのみ. ribbonManagerに渡してはいない
  _centy = (height / 2);  // 
  restart();
} 

void restart() {
  // これは何に使ってる？
  _noiseoff = random(1);
  _angle = 1; 
  _a = 3.5;     
  _b = _a + (noise(_noiseoff) * 1) - 0.5;
  
  // マネージャインスタンスの作成。毎回同じ値を引数に渡す。
  ribbonManager = new RibbonManager(_numRibbons, _numParticles, _randomness);   
  ribbonManager.setRadiusMax(12);                 // default = 8
  ribbonManager.setRadiusDivide(10);              // default = 10
  ribbonManager.setGravity(.0);                   // default = .03
  ribbonManager.setFriction(1.1);                  // default = 1.1
  ribbonManager.setMaxDistance(40);               // default = 40
  ribbonManager.setDrag(2.5);                      // default = 2
  ribbonManager.setDragFlare(.015);                 // default = .008
  
}

void clearBackground() {
  background(0);
}


//================================= frame loop
// アニメーション, movement
// _angleはカウントアップしてる 
// 


void draw() {
  clearBackground();
  
  float newx = sin(_a + radians(_angle) + PI / 2) * _centx;  
  float newy = sin(_b + radians(_angle)) * _centy; 
  
  _angle += (random(180) - 90);
  if (_angle > 360) { _angle = 0; }
  if (_angle < 0) { _angle = 360; }
  
  translate(_centx, _centy);
  ribbonManager.update(newx* 0.5, newy*0.5);
}



//================================= interaction

void mousePressed() { 
  restart();
}


