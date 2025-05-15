// Class for a simple particle with no rotational motion
public class Particle
{
   float _m;            // Mass of the particle (kg)
   PVector _s;          // Position of the particle (m)
   PVector _v;          // Velocity of the particle (m/s)
   PVector _a;          // Acceleration of the particle (m/(s·s))
   PVector _F;          // Force applied on the particle (N)

   float _radius;       // Radius of the particle (m)
   color _color;        // Color of the particle (RGBA)
   
   Particle(float m, PVector s, float radius)
   {
      _m = m;
      _s = s;
      _v = new PVector(0.0, 0.0);
      _radius = radius;
      _color = color(255,0,0);
      
      _a = new PVector(0.0, 0.0);
      _F = new PVector(0.0, 0.0);
      
   }

   void setPos(PVector s)
   {
      _s = s;
   }

   void setVel(PVector v)
   {
      _v = v;
   }
  

   PVector getForce()
   {
      return _F;
   }

   float getRadius()
   {
      return _radius;
   }

   float getColor()
   {
      return _color;
   }
   PVector getVelocidad()
   {
      return _v;
   }
   PVector getPosicion()
   {
      return _s;
   }

   void update(float timeStep)
   {
      updateForce();
      
      _a = PVector.div(_F,_m);
      _v.add(PVector.mult(_a,timeStep));
      _s.add(PVector.mult(_v,timeStep));

   }

   void updateForce() {
    // Cálculo de la altura sumergida
    float h = _s.y + _radius - hA; // h es la altura sumergida en el agua
    
    // Asegurarse de que la partícula no esté completamente fuera del agua
    if (h < 0) {
        h = 0; // Si la partícula está completamente fuera del agua
    }
    
    // Cálculo del volumen sumergido de la esfera
    // Solo se calcula si la partícula está sumergida
    float Vs = 0;
    if (h > 0) {
        if (h >= _radius) {
            Vs = (4.0 / 3.0) * PI * pow(_radius, 3); // Volumen completo de la esfera si está completamente sumergida
        } else {
            // Fórmula del volumen de un segmento esférico
            float a = sqrt(2 * h * _radius - h * h); // Radio de la sección esférica sumergida
            Vs = (PI * h * (3 * pow(a, 2) + h * h)) / 6; // Volumen del segmento esférico
        }
    }
    
    // Calcular la fuerza de flotación 
    PVector Fb = new PVector(0, -9.8 * density * Vs); 
    
    // Calcular la fuerza de gravedad 
    PVector gravedad = new PVector(0, 9.8); 
    PVector fPeso = PVector.mult(gravedad, _m);
    
    // Calcular la fuerza de friccion
    PVector fFriccion = new PVector(-_v.x,-_v.y);
    fFriccion.mult(KD);
    
    // Fuerza total
    _F = fPeso;
    _F.add(fFriccion);
    _F.add(Fb); 
}



 

   void draw()
   {
      fill(_color);
      stroke(_color);
      strokeWeight(1); 
      ellipseMode(RADIUS);
     
     ellipse(_s.x, _s.y, _radius,_radius); 
   }
}
