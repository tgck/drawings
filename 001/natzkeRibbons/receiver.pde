import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setupReceiver(){		
	oscP5 = new OscP5(this,12000);

	oscP5.plug(this,"test","/test");	// dummy
	oscP5.plug(this,"restart","/restart");	// スケッチの初期化
	
	oscP5.plug(this,"setNumRibbons","/setNumRibbons");	// リボン数変更.(restartあり)
	oscP5.plug(this,"setNumParticles","/setNumParticles");	// パーティクル数変更.(restartあり)
	oscP5.plug(this,"setRandomness","/setRandomness");	// ランダムネス変更.(restartあり)

	oscP5.plug(this,"setFramerate","/setFramerate");	// フレームレート変更
	oscP5.plug(this,"resetFramerate","/resetFramerate");

	// 描画系 - 背景
	oscP5.plug(this,"changeTargetBGColour","/changeTargetBGColour");	// TODO
	oscP5.plug(this,"setRandomBackGround","/setRandomBackGround");	// 背景色変化

	// 描画系 - リボン
	oscP5.plug(this,"changeRibbonColour","/changeRibbonColour");	// リボン色をスイッチする
	oscP5.plug(this,"updateRibbonConfig","/updateRibbonConfig");	// パーティクル設定の更新
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
	}
}

// // FrameRate // // 
public void resetFramerate(){
	println("### plug event method. received a message /resetFramerate.");
	frameRate(FPS);
	setRandomness(0.2);
}

// // RibbonConfig // //
public void updateRibbonConfig(float radMax, float radDiv, float gravity, float friction, 
								int maxDist, float drag, float dragFlare){
	
	println("### plug event method. received a message /updateRibbonConfig.");

	// 検討[FIXED]: リボン設定にどの経路で触りにいくべきか
	// --> メインルーチンでは、Ribbonには触らずRibbonManagerのメソッドへのアクセスのみ
	ribbonManager.setRibbonConfig(
		new RibbonConfig(radMax, radDiv, gravity, friction,
			maxDist, drag, dragFlare));
}
