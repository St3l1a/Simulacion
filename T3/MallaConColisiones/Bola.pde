
// Class for a simple particle with no rotational motion
public class Bola
{
   PVector _s;          // Position of the particle (m)
   float _radius;       // Radius of the particle (m)
   color _color;        // Color of the particle (RGBA)
   
   Bola(PVector s, float radius, color c)
   {
      _s = s;
      _radius = radius;
      _color = c;
      
   }
   PVector getPos()
   {
    return _s.copy();
    
   }
   
   float getRadio()
   {
     return _radius;
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
