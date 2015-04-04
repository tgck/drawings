// tani
class RibbonConfig {
  float radiusMax;
  float radiusDivide;
  float gravity;
  float friction;
  int maxDistance;
  float drag;
  float dragFlare;

  // default by this original author
  RibbonConfig() {
    radiusMax    = 8.0;
    radiusDivide = 10.0;
    gravity      = 0.0;
    friction     = 1.1;
    maxDistance  = 40;
    drag         = 2.5;
    dragFlare    = .15;
  }

  // OSCメッセージによるnewのためのメソッド
  RibbonConfig(float radMax, float radDiv, float gravity, float friction, int maxDist, float drag, float dragFlare){
    this.radiusMax    = radMax;
    this.radiusDivide = radDiv;
    this.gravity      = gravity;
    this.friction     = friction;
    this.maxDistance  = maxDist;
    this.drag         = drag;
    this.dragFlare    = dragFlare;
  }
}
