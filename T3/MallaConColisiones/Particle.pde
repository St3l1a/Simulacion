
// Class for a simple particle with no rotational motion
public class Particle
{
  // ParticleSystem _ps;  // Reference to the parent ParticleSystem
   int _id;             // Id. of the particle

   float _m;            // Mass of the particle (kg)
   PVector _s;          // Position of the particle (m)
   PVector _v;          // Velocity of the particle (m/s)
   PVector _a;          // Acceleration of the particle (m/(s·s))
   PVector _F;          // Force applied on the particle (N)
   PVector Fcol;
   PVector Fobj;

   float _radius;       // Radius of the particle (m)
   color _color;        // Color of the particle (RGBA)
   ArrayList<DampedSpring> _connectedSprings;
   
   Particle( int id, float m, PVector s, PVector v, float radius, color c)
   {
    //  _ps = ps;
      _id = id;
      _m = m;
      _s = s;
      _v = v;
      _radius = radius;
      _color = c;
      
      _a = new PVector(0.0, 0.0);
      _F = new PVector(0.0, 0.0);
      Fcol = new PVector(0,0,0);
      Fobj = new PVector(0,0,0);
       _connectedSprings = new ArrayList<DampedSpring>();
      
   }

   void setPos(PVector s)
   {
      _s = s;
   }

   void setVel(PVector v)
   {
      _v = v;
   }
  void addSpring(DampedSpring s) 
  {
    _connectedSprings.add(s);
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
      
      _a = PVector.div(_F,_m);
      _v.add(PVector.mult(_a,timeStep));
      _s.add(PVector.mult(_v,timeStep));
      
       Fcol.set(0,0,0);
      Fobj.set(0,0,0);
      _F.set(0,0,0);
    
   }

   void updateForce()
   {
    
      PVector gravedad = new PVector(0, G, 0); // Aceleración gravitatoria
      PVector fPeso = PVector.mult(gravedad, _m); // Fuerza = masa * gravedad
      _F.add(fPeso);   
     
      for (DampedSpring s : _connectedSprings)
      {
        _F.add(s.getForce(this));
     //   println(s.getForce(this));
      }
      //Añadimos fuerza de muelle del suelo
       _F.add(Fcol);
       _F.add(Fobj);
      
   }
  
   void planeCollision()
   {    
     if(_s.y + _radius > alturaSuelo-50)
     {
        float x = _s.y +_radius - alturaSuelo+2.1 -R;
       
         Fcol = PVector.mult(new PVector(0,-1,0), x * KEsuelo);
         
         // Calculamos la fuerza de friccion
        PVector dirFriccion = new PVector(-_v.x, -_v.y);
        float magnitudV = _v.mag();
        PVector Ffriccion = PVector.mult(PVector.mult(dirFriccion,magnitudV),KAsuelo);
        Fcol.add(Ffriccion);
        
     }
       
   }
     
  void objectCollision(ArrayList<Bola> bolas)
  {
    for (int i = 0; i < bolas.size(); i++)
    {
      Bola b = bolas.get(i);
      PVector dir = PVector.sub(_s, b.getPos());  // Vector desde la bola hasta la partícula
      float dist = dir.mag();
      float minDist = _radius + b.getRadio();     // Distancia mínima para no colisionar
      
      if (dist < minDist)
      {
        float x = minDist - dist;
        dir.normalize();
        
        Fobj = PVector.mult(dir, x * KEbola);
         
        PVector dirFriccion = new PVector(-_v.x, -_v.y, -_v.z);
        float magnitudV = _v.mag();
        PVector Ffriccion = PVector.mult(PVector.mult(dirFriccion.normalize(),magnitudV),KAbola);
        Fobj.add(Ffriccion);
        
      }
    }
}

   
   PVector getPos()
   {
     return _s.copy();
   }


   void display()
   {
      pushMatrix();
      translate(_s.x,_s.y,_s.z);
      fill(_color);
      stroke(_color);
      strokeWeight(1); 
      sphere(_radius);
      popMatrix();
   }
}
