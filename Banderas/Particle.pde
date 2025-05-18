
class Particle
{
  PVector _s; //posicion
  PVector _v; //vesidad
  PVector _a; //aceleracion
  PVector _F,Fm;
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
    Fm = new PVector(0,0);
    _m = mass;
   
  }
  
   void update(float timeStep)
   {
  //   println("INI: F:" + _F + " a:" + _a+ " v:" + _v + " s:" + _s);
      updateForce(); //<>//
      
      _a = new PVector(0,0);
      PVector a = PVector.div(_F,_m);
      _a = a.copy(); //<>//
      _v.add(PVector.mult(_a,timeStep));
      _s.add(PVector.mult(_v,timeStep));
     println("ACT: F:" + _F + " a:" + _a+ " v:" + _v + " s:" + _s+ " m:" + _m);
      _F =  new PVector(0,0);
      Fm = new PVector(0,0);
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
    for(int i = 0; i < muelles.size(); i++)
    {
     // println(_F);
      // _F.add(muelles.get(i).getForce(this)); 
      // println(muelles.get(i).getForce(this) + " f:" + _F);
    }
    _F.add(Fm);
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
    Fm = f.copy();
     println(Fm);
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
  
