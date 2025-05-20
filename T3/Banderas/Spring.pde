
class Spring
{
  PVector dir;
  PVector F;
  float l0;
  float Epe;
  FlagType tipe;
  
  float elong;
  //define el muelle con 2 extremos
  Particle a,b;
  
  Spring (Particle a_, Particle b_, FlagType t)
  {
    a = a_;
    b = b_;
    l0 = PVector.sub(b.getPos(),a.getPos()).mag();
    dir = PVector.sub(b_.getPos(),a_.getPos());
    tipe = t;
    
    F = new PVector(0,0);
  
  }
  FlagType getTipe()
  {
    return tipe;
  }
  
  Particle getParticle(Particle p)
  {
     Particle res = new Particle(new PVector(0,0));
  //  println(F);
      if (p == a)
        res = b;        // Fuerza que actúa sobre la particula a
      else if (p == b)
        res = a; 
      else
        println("No está esa particula");
        
      //println("f:" + F + " -f:" + res);
      return res;
  }
  
  //Función que actualiza las fuerzas del muelle en distintos sentidos
  void update()
  {
    F.set(0, 0);
    dir = PVector.sub(b.getPos(), a.getPos());
    float elong = dir.mag() - l0;
    dir.normalize();
    // Fuerza elástica
    F = PVector.mult(dir.copy(), k * elong);
    
    a.applyForce(F);
    b.applyForce(PVector.mult(F,-1));
  } //<>//
  
  //Funcion que devuelve la fuerza en funcion de la particula
  PVector getForce(Particle p)
  {
    PVector res = new PVector(0,0);
  //  println(F);
      if (p == a)
        res = F.copy();        // Fuerza que actúa sobre la particula a
      else if (p == b)
        res = PVector.mult(F.copy(),-1);
      else
        println("No está esa particula");
        
      //println("f:" + F + " -f:" + res);
      return res.copy();
  }
  
  void display()
  {
    strokeWeight(2);
    stroke(0);
    stroke(255, 0, 0); 
    line(a._s.x, a._s.y, b._s.x, b._s.y);
  }
}
