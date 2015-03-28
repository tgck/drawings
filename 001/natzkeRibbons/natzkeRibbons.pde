// Dec 2008 
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

void setup() {
  size(500, 300);
  smooth(); 
  frameRate(30);
  background(0);
  
  sampleColour();
  clearBackground();
  
  _centx = (width / 2);
  _centy = (height / 2);
  restart();
}    

void restart() {
  _noiseoff = random(1);
  _angle = 1; 
  _a = 3.5;
  _b = _a + (noise(_noiseoff) * 1) - 0.5;
  
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



