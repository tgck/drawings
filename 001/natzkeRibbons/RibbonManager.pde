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
      color ribbonColour = colArr[int(random(numcols))];
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
  
  // まんま、Ribbonインスタンスに受け渡す
  void setRadiusMax(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].radiusMax = value; } }
  void setRadiusDivide(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].radiusDivide = value; } }
  void setGravity(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].gravity = value; } }
  void setFriction(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].friction = value; } }
  void setMaxDistance(int value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].maxDistance = value; } }
  void setDrag(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].drag = value; } }
  void setDragFlare(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].dragFlare = value; } }
}
