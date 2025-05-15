
class Muelle
{
  PVector ancho, fA, fB;
  
  float len;
  float Epe;
  
  float elong;
  //define el muelle con 2 extremos
  Extremo a;
  Extremo b;
  
  Muelle (Extremo a_, Extremo b_, float l)
  {
    a = a_;
    b = b_;
    len = l;
    ancho = new PVector(b.loc.x - a.loc.x, b.loc.y - a.loc.y);
    fA = new PVector();
    fB = new PVector();
  }
  
  //Función que actualiza las fuerzas del muelle en distintos sentidos
  void update()
  {
    ancho.x = b.loc.x - a.loc.x;
    ancho.y = b.loc.y - a.loc.y;
    elong = ancho.mag() - len; //obtenemos la elongación actual
    ancho.normalize();
    
    //Suma de fuerzas que se ejercen sobre los muelles:
    fA.x = k* ancho.x* elong - (a.vel.x - b.vel.x)*am; //Fuerza elástica - Fuerza damping o de amortiguamiento
    fA.y = k* ancho.y* elong - (a.vel.y - b.vel.y)*am; //Fuerza elástica - Fuerza damping o de amortiguamiento
    a.applyForce(fA);  //Esta fuerza se debe aplicar a los dos extremos
    
    fB.x = -k* ancho.x* elong - (b.vel.x - a.vel.x)*am;
    fB.y = -k* ancho.y* elong - (b.vel.y - a.vel.y)*am;
    b.applyForce(fB);
  }
  void display()
  {
    strokeWeight(2);
    stroke(0);
    line(a.loc.x, a.loc.y, b.loc.x, b.loc.y);
  }
}
