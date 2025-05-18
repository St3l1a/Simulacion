public class DampedSpring {
  float _l0; 
  PVector _F;      
  color _color;
  Particle a,b;
  PVector dir;
  float _ke, _ka;

  // Constructor de la clase
  DampedSpring(Particle p1, Particle p2, color c, float l, float ke, float ka) {
    a = p1;
    b = p2;
    _l0 = l;
    _color = c;
    _ke = ke;
    _ka = ka;
    
    _F = new PVector(0.0, 0.0, 0.0);
    dir = new PVector(0.0,0.0,0.0);
    
  }
  
  
  void update()
  {
    _F.set(0,0);

    dir = PVector.sub(b.getPos(),a.getPos());
    float elong = dir.mag() - _l0; //obtenemos la elongación actual
    dir.normalize();
     _F = PVector.mult(dir.copy(), _ke * elong);
     
  }

  //Funcion que devuelve la fuerza en funcion de la particula
  PVector getForce(Particle p)
  {
    PVector res = new PVector(0,0);

      if (p == a)
        res = _F.copy();        // Fuerza que actúa sobre la particula a
      else if (p == b)
        res = PVector.mult(_F.copy(), -1);
      else
        println("No está esa particula");

     // println("f:" + F + " -f:" + res);
      return res;
  }
   
  
  void display(){
    PVector _pos1 = a.getPos();
    PVector _pos2 = b.getPos();
    fill(_color);
    stroke(_color);
    line(_pos1.x, _pos1.y, _pos1.z, _pos2.x, _pos2.y, _pos2.z);
  }
  
}
