// Class for a simple particle with no rotational motion
public class Particle
{
   int _id;             // Id. of the particle

   float _m;            // Mass of the particle (kg)
   PVector _s;          // Position of the particle (m)
   PVector _v;          // Velocity of the particle (m/s)
   PVector _a;          // Acceleration of the particle (m/(s·s))
   PVector _F;          // Force applied on the particle (N)

   float _radius;       // Radius of the particle (m)
   color _color;        // Color of the particle (RGBA)
   //
   //
   //
      
   Particle( int id, float m, PVector s, PVector v, float radius, color c)
   {
      _id = id;
      _m = m;
      _s = s;
      _v = v;
      _radius = radius;
      _color = c;
      
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
      
      _a = PVector.div(_F,_m);
      _v.add(PVector.mult(_a,timeStep));
      _s.add(PVector.mult(_v,timeStep));

   }

   void updateForce()
   {
    PVector dirFriccion = new PVector(-_v.x, -_v.y);
    float magnitudV = _v.mag();
    PVector Ffriccion = PVector.mult(PVector.mult(dirFriccion,magnitudV),KD);
    
    _F = Ffriccion;
    
   }

    void planeCollision(PlaneSection plane)
   {    
      
        float d = plane.getDistance(_s);
        boolean lado = plane.checkSide(_s);
        float absD = abs(d);
        
         if(d < R && lado) // Si está dentro y la distancia es menor que el radio o si se ha salido al otro lado
         {
            
           //Desplazar lo que se ha atravesado
           float atraviesa = R-absD;
           PVector desplazamiento = PVector.mult(plane.getNormal(), atraviesa);
           _s.add(desplazamiento);

           //Calcular nueva velocidad
           float nv = plane.getNormal().dot(_v);
           PVector Vn = PVector.mult(plane.getNormal(),nv);
           PVector Vt = PVector.sub(_v,Vn);
           
           PVector vSalida = PVector.sub(Vt,PVector.mult(Vn,CR1));
           _v = vSalida;
        }
        else if(d < R && !lado) // Si está dentro y la distancia es menor que el radio o si se ha salido al otro lado
         {
            
           //Desplazar lo que se ha atravesado
           float atraviesa = R-absD;
           PVector desplazamiento = PVector.mult(plane.getNormal(), atraviesa);
           _s.sub(desplazamiento);

           //Calcular nueva velocidad
           float nv = plane.getNormal().dot(_v);
           PVector Vn = PVector.mult(plane.getNormal(),nv);
           PVector Vt = PVector.sub(_v,Vn);
           
           PVector vSalida = PVector.sub(Vt,PVector.mult(Vn,CR1));
           _v = vSalida;
      }
      
   }
   void particleColor(PlaneSection p)
   {
      PVector p1 = p.getPoint1();
      PVector p2 = p.getPoint2();
      _color = color(255);
      
      if(_s.x > p1.x && _s.x < p2.x && _s.y > p1.y && _s.y < p2.y)
      {
         if(p.checkSide(_s))
            _color = color(255,0,0);
        else
            _color = color(0,255,0);
         
         noFill(); 
         float w = p2.x - p1.x;   // ancho
          float h = p2.y - p1.y;   // alto
          rect(p1.x, p1.y, w, h);

      }
      
   }

   void particleCollision( ArrayList<Particle> _ps)
   {
      for(int i=0; i<_ps.size();i++)
      {
        if(_id != _ps.get(i).getId())
        {
          PVector d = PVector.sub(_s, _ps.get(i).getPosicion());
          float magD = d.mag();
          
          if(magD < R*2)
          {
              float atraviesa = 2*R-magD;
              PVector normal = d.normalize();
              PVector desplazamiento = PVector.mult(normal, atraviesa/2);
              _s.add(desplazamiento);
              _ps.get(i).setPos(_ps.get(i).getPosicion().sub(desplazamiento));
              
              
              //Calcular nueva velocidad
             float nv = normal.dot(_v);
             PVector Vn = PVector.mult(normal,nv);
             PVector Vt = PVector.sub(_v,Vn);
             
             PVector vSalida = PVector.sub(Vt,PVector.mult(Vn,CR2));
             _v = vSalida;
             PVector vSalida2 = new PVector(-vSalida.x, -vSalida.y);
             _ps.get(i).setVel(vSalida2);
             
          }
          
        }
      }
   }


   void draw()
   {
      stroke(0);   
      strokeWeight(1); 
      fill(_color);
      ellipseMode(RADIUS);
     
     ellipse(_s.x, _s.y, _radius,_radius); 
   }
}
