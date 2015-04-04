//======== ribbon  

class Ribbon {
  int _numRibbons;          // 未使用では？
  float _randomness;        // 
  int _numParticles;        // length of the Particle Array (max number of points)
  int particlesAssigned = 0;        // current amount of particles currently in the Particle array - 払い出し済みのparticle数                                

  RibbonParticle[] particles;       // particle array
  color ribbonColor;

  // RibbonConfig...
  float radiusMax = 8;              // maximum width of ribbon
  float radiusDivide = 10;          // distance between current and next point / this = radius for first half of the ribbon
  float gravity = .03;              // gravity applied to each particle
  float friction = 1.1;             // friction applied to the gravity of each particle
  int maxDistance = 40;             // if the distance between particles is larger than this the drag comes into effect
  float drag = 2;                   // if distance goes above maxDistance - the points begin to drag. high numbers = less drag 大きいほど引っぱり少ない
  float dragFlare = .008;           // degree to which the drag makes the ribbon flare out
  // ...RibbonConfig

  Ribbon(int _numParticles, color ribbonColor, float _randomness) {
    this._numParticles = _numParticles;
    this.ribbonColor = ribbonColor;
    this._randomness = _randomness;
    init();
  }
  
  // experimental
  // [要検証] confを有効とするには、init()でParticleをnewする前に、configを設定する必要がある?
  Ribbon(int _numParticless, color ribbonColor, float _randomness, RibbonConfig rc){
    this._numParticles = _numParticles;
    this.ribbonColor = ribbonColor;
    this._randomness = _randomness;

    setRibbonConfig(rc);
    // this.radiusMax    = rc.radiusMax;
    // this.radiusDivide = rc.radiusDivide;
    // this.gravity      = rc.gravity;
    // this.friction     = rc.friction;
    // this.maxDistance  = rc.maxDistance;
    // this.drag         = rc.drag;
    // this.dragFlare    = rc.dragFlare;

    init();
  }

  void init() {
    particles = new RibbonParticle[_numParticles];
  }
  
  // addition
  void setRibbonConfig(RibbonConfig rc){

    println("-- Ribbon.setRibbonConfig!");

    this.radiusMax    = rc.radiusMax;
    this.radiusDivide = rc.radiusDivide;
    this.gravity      = rc.gravity;
    this.friction     = rc.friction;
    this.maxDistance  = rc.maxDistance;
    this.drag         = rc.drag;
    this.dragFlare    = rc.dragFlare;
  }
  
  // update. 毎フレーム呼ばれる処理
  void update(float randX, float randY){
    addParticle(randX, randY);
    drawCurve();
  }
  
  // 軌跡リストの更新
  // arrayの前方が古い要素
  // arrayの末尾に最新のRibbonインスタンスを追加
  void addParticle(float randX, float randY) {
    if(particlesAssigned == _numParticles) {
      for (int i = 1; i < _numParticles; i++) {
        particles[i-1] = particles[i];
      }
      particles[_numParticles - 1] = new RibbonParticle(_randomness, this);
      particles[_numParticles - 1].px = randX;
      particles[_numParticles - 1].py = randY;
      return;
    } else {
      particles[particlesAssigned] = new RibbonParticle(_randomness, this);
      particles[particlesAssigned].px = randX;
      particles[particlesAssigned].py = randY;
      ++particlesAssigned;
    }
    if (particlesAssigned > _numParticles) ++particlesAssigned;
  }
  
  // 軌跡パーティクルの描画
  void drawCurve() {
    smooth();

    // particleの属性を更新
    for (int i = 1; i < particlesAssigned - 1; i++) {
      RibbonParticle p = particles[i];
      p.calculateParticles(particles[i-1], particles[i+1], _numParticles, i);
    }

    // particleの描画
    fill(30);
    for (int i = particlesAssigned - 3; i > 1 - 1; i--) {
      RibbonParticle p = particles[i];
      RibbonParticle pm1 = particles[i-1];
      fill(ribbonColor, 255);
      if (i < particlesAssigned-3) {
        noStroke();
        beginShape();
        vertex(p.lcx2, p.lcy2);
        bezierVertex(p.leftPX, p.leftPY, pm1.lcx2, pm1.lcy2, pm1.lcx2, pm1.lcy2);
        vertex(pm1.rcx2, pm1.rcy2);
        bezierVertex(p.rightPX, p.rightPY, p.rcx2, p.rcy2, p.rcx2, p.rcy2);
        vertex(p.lcx2, p.lcy2);
        endShape();
      }
    }
  }
}
