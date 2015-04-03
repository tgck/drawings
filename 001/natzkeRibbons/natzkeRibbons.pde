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

//final PVector window = new PVector(600, 450);
final PVector window = new PVector(640, 480);
final int FPS = 24;

int _numRibbons = 5;
int _numParticles = 20;
float _randomness = .05;
RibbonManager ribbonManager;

float _a, _b, _centx, _centy, _x, _y;
float _noiseoff;
int _angle;

boolean isDebugView;
float myNoiseOffset;
boolean isRecording = false;
//boolean isRecording = true;
String initTime;

// 背景色
color _BGColor;
color _targetBGColor;

//================================= init
// setup
// - 色配列の作成
// - 描画中心の決定
//

void setup() {

  initTime = getTime();

  size((int)window.x, (int)window.y); // きれいではないのだが、後でマネージャで管理できるよう、この形態にしておく。

  // enable full screen
  if (frame != null) {
    frame.setResizable(true);
  }

  smooth(); 
  frameRate(FPS);
  background(0);
 
  // OSCイベントハンドラ
  setupReceiver();

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
  changeRibbonColour(0);
  _BGColor = _targetBGColor = #88FF88;

  // debug view
  isDebugView = false;

  clearBackground();
  
  _centx = (width / 2);   // drawの中で使うのみ. ribbonManagerに渡してはいない
  _centy = (height / 2);  // 
  restart();
} 

void restart() {
  _noiseoff = random(1);
  _angle = 1; 
 
  // 楕円からの歪みの表現 //

  if (isDebugView){
    _a = _b = 0; // 歪みなし
    myNoiseOffset = 0.02; // angleの進捗に対するノイズ
  } else {
    _a = 3.5;     
    _b = _a + (noise(_noiseoff) * 1) - 0.5;
    // myNoiseOffset = 0.02; // angleの進捗に対するノイズ
  }

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

  // debug info
  frame.setTitle("R:N:R=[" + _numRibbons 
                    + ":" + _numParticles
                    + ":" + _randomness + "]"
                    + " col:" + _colIndex);
}

// 背景色設定
void clearBackground() {
 // background(0);
  background(_BGColor, 22);
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
  
  if (isDebugView) {

    _angle += 90 * 0.1;

    if (_angle > 360) { _angle = 0; }
    if (_angle < 0) { _angle = 360; }
  
    translate(_centx, _centy);
    ribbonManager.update(newx* 0.5, newy*0.5);

    drawDebug(newx, newy);

  } else {
    // TODO: 
    // here is the magic
    _angle += (random(180) - 90);

    //myNoiseOffset += 0.01;
    //int aaa = (int) map(noise(myNoiseOffset), 0, 1, 0, 30);
    //_angle += ( aaa - 90);

    if (_angle > 360) { _angle = 0; }
    if (_angle < 0) { _angle = 360; }
  
    translate(_centx, _centy);
    ribbonManager.update(newx* 0.5, newy*0.5);
  }

  // 録画
  if (isRecording) {
    saveFrame("out/nR_"+initTime+"_######.tif");

    // 出力コマ数の表示(10秒毎)
    if (frameCount % (10 * FPS) == 0) {
      println("picture exported.[" + frameCount / (10 * FPS) + "]*10sec." );
    }
  }
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
      case '1': changeRibbonColour(0); break;
      case '2': changeRibbonColour(1); break;
      case '3': changeRibbonColour(2); break;
      case 'c': setRandomBackGround(); break;
      case 'd':
        isDebugView = !isDebugView;
        println("isDebugView:[" + isDebugView + "]");
        break;
      case 'f': alterFullScreen(); break;
      default:  break;
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

// FIXME
// サイズ変更できるのだけど、描画系の中心をアップデートする必要あり。

// フルスクリーン化されていなければ、する。
// されていれば、初期値に戻す
void alterFullScreen(){
  if (width != displayWidth) {
    frame.setSize(displayWidth, displayHeight);
    _centx = (displayWidth / 2);  // restartの中だとうまくtoggleされないのでframeのサイズと同期するようここにもってきた
    _centy = (displayHeight / 2); // 同上
  } else {
    frame.setSize((int)window.x, (int)window.y);
    _centx = ((int)window.x / 2); // 同上
    _centy = ((int)window.y / 2); // 同上
  }
  restart();
}

// 現在時刻を文字列形式で返却する
String getTime(){
  return ""+year()+month()+day()+"_"+hour()+minute()+second();
}
