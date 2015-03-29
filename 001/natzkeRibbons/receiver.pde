import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setupReceiver(){		
	oscP5 = new OscP5(this,12000);
	oscP5.plug(this,"test","/test");
	oscP5.plug(this,"setNumRibbons","/setNumRibbons");
	oscP5.plug(this,"setNumParticles","/setNumParticles");
	oscP5.plug(this,"setRandomness","/setRandomness");

	oscP5.plug(this,"setFramerate","/setFramerate");
	oscP5.plug(this,"resetFramerate","/resetFramerate");

	oscP5.plug(this,"changeRibbonColour","/changeRibbonColour");

	oscP5.plug(this,"restart","/restart");	// main

}

//
// Event Handlers
//
public void test(int theA, int theB) {
  println("### plug event method. received a message /test.");
  println(" 2 ints received: "+theA+", "+theB);  
}

// 1) Ribbons
public void setNumRibbons(int num){
	println("### plug event method. received a message /setNumRibbons.");
	_numRibbons = num;
	restart();
}

// 2) Particles (trail resolution)
public void setNumParticles(int num){
	println("### plug event method. received a message /setNumParticles.");
	_numParticles = num;
	restart();
}

// 3) Randomness
public void setRandomness(float flonum){
	println("### plug event method. received a message /setRandomness.");
	_randomness = flonum;
	restart();
}

// // FrameRate // // 
public void setFramerate(int theRate){
	println("### plug event method. received a message /setFramerate.");
	if (theRate > 0 && theRate <= 60) {
		frameRate(theRate);
		setRandomness(2.0);
		makeFlash();
	}
}

// // FrameRate // // 
public void resetFramerate(){
	println("### plug event method. received a message /resetFramerate.");
	frameRate(24);
	setRandomness(0.2);
	makeFlash();
}

// TODO: tunig
public void makeFlash(){
	background(188);
}

/*
int _numRibbons = 5;  // 3
int _numParticles = 20; // 40 //  20 is good
float _randomness = .05; // .2
RibbonManager ribbonManager;

float _a, _b, _centx, _centy, _x, _y;
float _noiseoff;
int _angle;

*/
