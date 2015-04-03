//
// managing colors !!!!
//
//

//
// ribbonManagerがaddRibbon()する前に、
// globalな _colArr を書き換えてやる必要がある。 
//

//================================= colour sampling
// 画像ファイルを元に、600の長さを持つcolor配列を作成する。
// 画像のサイズは 30x20ピクセル。(横3:縦2)
// 

final int numcols = 600; // 30x20
color[] _colArr = new color[numcols];  // global
ArrayList<color[]> colorCollection; // そのうち、色管理クラスを作成する
int _colIndex; // 色指定のインデックス

// 所定のColor配列に、ファイルからColorを詰めていく
color[] sampleColour(String path){
  color[] colarr = new color[numcols];
  PImage img;
  img = loadImage(path);
  image(img, 0, 0);
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

//
// [deprecated]
//
void sampleColour() {
  PImage img;
  img = loadImage("tricolpalette.jpg");
  image(img,0,0);
  for (int count=0, x=0; x < img.width; x++){
    for (int y=0; y < img.height; y++) {
      if (count < numcols) {
        color c = get(x,y);
        _colArr[count] = c;
      }
      count++;
    }
  }  
}

// 
// addition
// 
void changeRibbonColour(int i){

	if ( i < 0 || i > colorCollection.size()) {
 		println("Error: out of index for color change. colors variations is [" + colorCollection.size() + "]");
 		println("     : argument is [" + i + "]");
 	}
 	_colIndex = i;
  	_colArr = colorCollection.get(_colIndex);
	restart();

	println("color changes to index[" + _colIndex + "]");
}

// 
// addition
//	色のローテーション
// 
void changeRibbonColour(){
	_colIndex++;
	_colIndex %= colorCollection.size();
	_colArr = colorCollection.get(_colIndex);
	
	restart();
	println("color changes to index[" + _colIndex + "]");
}

//
// 背景色の変更
//
void changeTargetBGColour(color col){
  _BGColor = _targetBGColor = col;
}

// Experimental
void setRandomBackGround(){

  // アルファ
  int which = millis()%8;
  int tmpBaseColor = 0;

  println("setRandomBackGround!");
  println("debug:whichBGColor=" + which);
  switch (which) {
    case 0: tmpBaseColor = #FF8888; break;
    case 1: tmpBaseColor = #88FF88; break;
    case 2: tmpBaseColor = #8888FF; break;
    case 3: tmpBaseColor = #FFFF88; break;
    case 4: tmpBaseColor = #88FFFF; break;
    case 5: tmpBaseColor = #888888; break;
    case 6: tmpBaseColor = #444444; break;
    case 7: tmpBaseColor = #000000; break;
  };

  _BGColor = _targetBGColor = color(tmpBaseColor, 40);
  println("debug:_BGColor=" + _BGColor);
}
