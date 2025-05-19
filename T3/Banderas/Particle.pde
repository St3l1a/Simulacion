
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
      updateForce();
      
      _a = PVector.div(_F,_m);
      _v.add(PVector.mult(_a,timeStep));
      _s.add(PVector.mult(_v,timeStep));
     // println("F:" + _F + " a:" + _a);
       _F =  new PVector(0,0);
   }

   void updateForce()
   {
    
     //gravedad
    PVector Fg = PVector.mult(gravity,_m);
    _F.add(Fg);
    
    //Viento
    PVector Fv = PVector.mult(dirViento,mViento * random(0,5));
   // _F.add(Fv);
    //Friccion aire
    PVector damping = PVector.mult(_v, -KA);  // Ajusta el coeficiente según comportamiento
    _F.add(damping);

    //Muelle
    for(int i = 0; i < muelles.size(); i++)
    {
       _F.add(muelles.get(i).getForce(this)); 
      // println(muelles.get(i).getForce(this));
    }
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
  
