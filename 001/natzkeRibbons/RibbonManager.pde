//================================= objects
// modified from original code by http://jamesalliban.wordpress.com/


//======== manager

class RibbonManager {
  int _numRibbons;       // 画面内のリボンの数
  int _numParticles;     // リボンの軌跡のポイント数
  float _randomness;     // 複雑度
  Ribbon[] ribbons;      // ribbon array
  
  RibbonManager(int _numRibbons, int _numParticles, float _randomness) {
    this._numRibbons = _numRibbons;
    this._numParticles = _numParticles;
    this._randomness = _randomness;
    init();
  }

  void init() {
    addRibbon();
  }

  void addRibbon() {
    ribbons = new Ribbon[_numRibbons];
    for (int i = 0; i < _numRibbons; i++) {
      color ribbonColour = _colArr[int(random(numcols))];
      ribbons[i] = new Ribbon(_numParticles, ribbonColour, _randomness);
    }
  }
  //
  // addition
  // 色指定でリボンを生成する
  // Deprecated:
  //   グローバルで色情報を持たないと、メソッドのリレーが激しい。
  // 
  void addRibbon(color[] colarr) {
    ribbons = new Ribbon[_numRibbons];
    for (int i = 0; i < _numRibbons; i++) {
      color ribbonColour = colarr[int(random(numcols))]; // 600のうち、任意の1色を選択する
      ribbons[i] = new Ribbon(_numParticles, ribbonColour, _randomness);
    }
  }

  void update(float currX, float currY)  {
    for (int i = 0; i < _numRibbons; i++) {
      float randX = currX;
      float randY = currY;
      
      ribbons[i].update(randX, randY);
    }
  }
  
  // まんま、配下のRibbonインスタンスに受け渡す
  void setRadiusMax(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].radiusMax = value; } }
  void setRadiusDivide(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].radiusDivide = value; } }
  void setGravity(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].gravity = value; } }
  void setFriction(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].friction = value; } }
  void setMaxDistance(int value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].maxDistance = value; } }
  void setDrag(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].drag = value; } }
  void setDragFlare(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].dragFlare = value; } }

  //
  // RibbonConfigインスタンスを用いたパラメータ設定
  // 
  // restart(/init)は不要. drawの都度参照されているフィールドなので
  //
  void setRibbonConfig(RibbonConfig c){
    println("RibbonManager.setRibbonConfig!");
    setRadiusMax(c.radiusMax);
    setRadiusDivide(c.radiusDivide);
    setGravity(c.gravity);
    setFriction(c.friction);
    setMaxDistance(c.maxDistance);
    setDrag(c.drag);
    setDragFlare(c.dragFlare);
  }
}
