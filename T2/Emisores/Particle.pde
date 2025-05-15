// Class for a simple particle with no rotational motion
public class Particle
{
   ParticleSystem _ps;  // Reference to the parent ParticleSystem
   int _id;             // Id. of the particle

   float _ttl;
   float _lifeSpan;
   float _m;            // Mass of the particle (kg)
   PVector _s;          // Position of the particle (m)
   PVector _v;          // Velocity of the particle (m/s)
   PVector _a;          // Acceleration of the particle (m/(s·s))
   PVector _F;          // Force applied on the particle (N)

   float _radius;       // Radius of the particle (m)
   color _color;        // Color of the particle (RGBA)
   
   Particle(ParticleSystem ps, int id, float m, PVector s, PVector v, float radius, color c, float lifeSpan)
   {
      _ps = ps;
      _id = id;
      _m = m;
      _s = s;
      _v = v;
      _radius = radius;
      _color = c;
      _lifeSpan = lifeSpan;
      _ttl = _lifeSpan;
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
   int getId()
   {
      return _id;
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
      
      _ttl-= timeStep;
      _a = PVector.div(_F,_m);
      _v.add(PVector.mult(_a,timeStep));
      _s.add(PVector.mult(_v,timeStep));

   }

   void updateForce()
   {
     PVector gravedad = new PVector(0,9.8);
      PVector fPeso = PVector.mult(gravedad, _m);
    
      _F = fPeso;
      
    
   }
   
   boolean isDead()
   {
      return (_ttl <= 0.0);
   }

  
   void draw()
   {
     float opacidad = _ttl/_lifeSpan;
      fill(_color, 255*opacidad);
      stroke(_color, 255*opacidad);
      strokeWeight(1); 
      ellipseMode(RADIUS);
     
     ellipse(_s.x, _s.y, _radius,_radius); 
   }
}
