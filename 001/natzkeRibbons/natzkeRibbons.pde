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

 // 色管理
  colorCollection = new ArrayList<color[]>();
  colorCollection.add(sampleColour("tricolpalette.jpg"));
  colorCollection.add(sampleColour("moody.jpg"));
  colorCollection.add(sampleColour("yellowpalette.jpg"));
  colorCollection.add(sampleColour("pic/A1.jpg"));
  colorCollection.add(sampleColour("pic/A2.jpg"));
  colorCollection.add(sampleColour("pic/A3.jpg"));
  colorCollection.add(sampleColour("pic/D1.jpg"));
  colorCollection.add(sampleColour("pic/E1.jpg"));
  colorCollection.add(sampleColour("pic/L1.jpg"));
  colorCollection.add(sampleColour("pic/P1.jpg"));
  colorCollection.add(sampleColour("pic/S1.jpg"));
  println("colorCollection size:[" + colorCollection.size() + "]");
 
  // define initial color
  // sampleColour(); // old
  changeRibbonColour(0);
 
  clearBackground();
  
  _centx = (width / 2);   // drawの中で使うのみ. ribbonManagerに渡してはいない
  _centy = (height / 2);  // 
  restart();
} 

void restart() {
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
  if (key == CODED){
    switch (keyCode) {
      case UP:
      case DOWN:
        changeRibbonColour(); break;
      default:
        break;
    }
  } else {
    switch (key) {
      case '1':
        changeRibbonColour(0); break;
      case '2':
        changeRibbonColour(1); break;
      case '3':
        changeRibbonColour(2); break;
      default:
        break;
    }
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