/* based on : abandondart.org NatzkeRibbons.pde */
// http://www.abandonedart.org
// http://www.zenbullets.com
//
// with lots of thanks to Erik Natzke (obviously)
// http://jot.eriknatzke.com/
//
// and James Alliban, who saved me the job of doing the conversion
// http://jamesalliban.wordpress.com/2008/12/04/2d-ribbons/
//
//
// This work is licensed under a Creative Commons 3.0 License.
// (Attribution - NonCommerical - ShareAlike)
// http://creativecommons.org/licenses/by-nc-sa/3.0/
// 
// This basically means, you are free to use it as long as you:
// 1. give http://www.zenbullets.com a credit
// 2. don't use it for commercial gain
// 3. share anything you create with it in the same way I have
//
// These conditions can be waived if you want to do something groovy with it 
// though, so feel free to email me via http://www.zenbullets.com

//================================= colour sampling
// 画像ファイルを元に、600の長さを持つcolor配列を作成する。
// 呼び出しは、setup()の中で一回だけ。

int numcols = 600; // 30x20
color[] colArr = new color[numcols];  // temp

ArrayList<color[]> colorCollection; // そのうち、色管理クラスを作成する

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

// 所定のColor配列に、ファイルからColorを詰めていく
color[] sampleColour(color[] colarr, String path){
  PImage img;
  img = loadImage(path);
  image(img, 0, 0);
  //int count = 0;
  for (int count=0, x=0; x < img.width; x++){
    for (int y=0; y < img.height; y++) {
      if (count < numcols) {
        color c = get(x,y);
        colarr[count] = c;
      }
      count++;
    }
  }
  return colarr;
}

//================================= global vars
int ww = 600;
int hh = 450;

int _numRibbons = 5;       // 3
int _numParticles = 20;    // 40 //  20 is good
float _randomness = .05;   // .2
RibbonManager ribbonManager;

float _a, _b, _centx, _centy, _x, _y;
float _noiseoff;
int _angle;

float myNoiseOffset;


//================================= init
// setup
// - 色配列の作成
// - 描画中心の決定
//

void setup() {
  size(ww, hh);
  //size(1000, 300);
  smooth(); 
  frameRate(30);
  background(0);
 
  setupReceiver(); // OSC

  // sampleColour(); // old
 
  // インスタンス作成
  color[] colArr1 = new color[numcols]; 
  color[] colArr2 = new color[numcols]; 
  color[] colArr3 = new color[numcols]; 
  // 色をロード
  colArr1 = sampleColour(colArr1, "tricolpalette.jpg");
  colArr2 = sampleColour(colArr2, "moody.jpg");
  colArr3 = sampleColour(colArr3, "yellowpalette.jpg");

  colorCollection = new ArrayList<color[]>();
  colorCollection.add(colArr1);
  colorCollection.add(colArr2);
  colorCollection.add(colArr3);

  print("colorCollection size:[" + colorCollection.size() + "]");

  clearBackground();
  
  _centx = (width / 2);   // drawの中で使うのみ. ribbonManagerに渡してはいない
  _centy = (height / 2);  // 
  restart();
} 

void restart() {
  // これは何に使ってる？
  _noiseoff = random(1);
  _angle = 1; 
 
  // 楕円からの歪みの表現 //
  //_a = 3.5;     
  //_b = _a + (noise(_noiseoff) * 1) - 0.5;
  _a = _b = 0; // 歪みなし

  myNoiseOffset = 0.02; // angleの進捗に対するノイズ
    
  // マネージャインスタンスの作成。毎回同じ値を引数に渡す。
  ribbonManager = new RibbonManager(_numRibbons, _numParticles, _randomness);   
  ribbonManager.setRadiusMax(12);                 // default =  8
  ribbonManager.setRadiusDivide(10);              // default = 10
  ribbonManager.setGravity(.0);                   // default =  0.03
  ribbonManager.setFriction(1.1);                 // default =  1.1
  ribbonManager.setMaxDistance(40);               // default = 40
  ribbonManager.setDrag(2.5);                     // default =  2
  ribbonManager.setDragFlare(.015);               // default =  0.008

  dumpParam();
  dumpManagerParam(); // TODO
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
  
  // windowの大きさに合わせてる
  float newx = sin(_a + radians(_angle) + PI / 2) * _centx;
  float newy = sin(_b + radians(_angle)) * _centy; 
  
// TODO: 
// here is the magic
//  _angle += (random(180) - 90);
  _angle += 90 * 0.1;

  //myNoiseOffset += 0.01;
  //int aaa = (int) map(noise(myNoiseOffset), 0, 1, 0, 30);
  //_angle += ( aaa - 90);

  if (_angle > 360) { _angle = 0; }
  if (_angle < 0) { _angle = 360; }
  
  translate(_centx, _centy);
  ribbonManager.update(newx* 0.5, newy*0.5);
  drawDebug(newx, newy);

}



//================================= interaction

void mousePressed() { 
//  restart();
}
void keyPressed() { 
  switch (key) {
    case 'a':
      print("aaa"); break;
    case 'b':
      print("bbb"); break;
    default:
      print("keydown!"); break;
  }
}

//================================= debug draw

void drawDebug(float x, float y){
  noFill(); /* 軌道 */
  stroke(188);
  ellipse(0, 0, 2*_centx, 2*_centy);

  stroke(color(0, 212, 0));
  fill(color(2,212,0));
  ellipse(x, y, 10, 10);

  noFill();
  line(0, 0, x, y); 
}

void changeRibbonCoor(){


}

void dumpParam(){
  println("=============================================");
  println("_numRibbons:[" + _numRibbons + "]");
  println("_numParticl:[" + _numParticles + "]");
  println("_randomness:[" + _randomness + "]");
  println("_a, _b:[" + _a + "],[" + _b + "]");
  println("_noiseoff:[" + _noiseoff + "]");
}

void dumpManagerParam() {
  ; // TODO ParticleConfigの内容をprintする
  ; 
}