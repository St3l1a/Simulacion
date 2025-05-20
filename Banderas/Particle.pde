
class Particle
{
  PVector _s; //posicion
  PVector _v; //vesidad
  PVector _a; //aceleracion
  PVector _F;
  float _m; 
  int mode;
  
  ArrayList<Spring> muelles;
  
  Particle(PVector pos)
  {
    _s = pos.copy();
    _v = new PVector(0,0);
    _a = new PVector(0,0);
    _F = new PVector(0,0);
    muelles = new ArrayList<Spring>();
    _m = mass;
   
  }
  
   void update(float timeStep)
   {
      updateForce(); //<>//
      
      updateForce();
    _a = PVector.div(_F, _m);
    _v.add(PVector.mult(_a, timeStep)); // Actualizar velocidad primero
    _s.add(PVector.mult(_v, timeStep)); //<>//
      
      _F =  new PVector(0,0);
   }

   void updateForce()
   {
     
     //PESO
    PVector Fg = PVector.mult( gravity,_m); //<>//
    _F.add(Fg);
    
    //VIENTO
  
  
    //Friccion aire
    PVector damping = PVector.mult(_v, -KA);  
    _F.add(damping);
    
    
    //Muelle
    
   // println(_F);
   }
   
   void addSpring(Spring s)
   { 
     boolean  repetido = false;
     for(int i = 0; i < muelles.size(); i++)
       if(muelles.get(i) == s)
         repetido = true;
         
     if(repetido == false)
       muelles.add(s);
   }
  
  void applyForce(PVector f){
    _F.add(f);
  }
  
  PVector getPos()
  {
   return _s.copy(); 
  }
  void display()
  {
    stroke(0);
    strokeWeight(2);
    fill(175, 120);
    ellipse(_s.x, _s.y, 2*R, 2*R);

    
  }
  
  
}
  
