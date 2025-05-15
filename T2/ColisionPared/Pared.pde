class Pared {
  PVector a, b,n1,n2,ab;
  
  Pared(PVector _a, PVector _b) {
    a = _a.copy();
    b = _b.copy();
    ab = PVector.sub(_a,_b);
    
    n1 = new PVector(-ab.x, ab.y);
    n2 = new PVector(ab.x, -ab.y);
  }
  
  Boolean inside(PVector x) {
    return (x.x >= a.x && x.x <= b.x) && (x.y >= a.y && x.y <= b.y);
  }
  
  void display() {
    stroke(0);
    noFill();
    rect(a.x, a.y, b.x - a.x, b.y - a.y);
    line(a.x, a.y, b.x, b.y);
  }
  
  PVector getAB()
  {
    return ab;
  }
  PVector getA()
  {
    return a;
  }
  PVector getB()
  {
    return b;
  }
}
