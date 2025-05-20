
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
    if(viento)
      viento();
  
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
  
void viento()
{
    PVector n = new PVector(0,0);
    ArrayList<Spring> m = new ArrayList<Spring>();
    
    for(int i = 0; i < muelles.size(); i++)//Obtengo los muelles de structured
    {
        if(muelles.get(i).getTipe()  == FlagType.Structured)
          m.add(muelles.get(i));
    }
    
    if(m.size() > 0)
    {
      
        for(int i = 1; i < m.size(); i++)
        {
           Particle part1 = m.get(i-1).getParticle(this); 
           PVector pos1 = part1.getPos();
           Particle part2 = m.get(i).getParticle(this); 
           PVector pos2 = part2.getPos();

           PVector edge = PVector.sub(pos2, pos1);
           PVector normal = new PVector(-edge.y, edge.x);
           normal.normalize();

           n.add(normal);
        }
        n.div(m.size());
        n.normalize();
    }
    
    
    // Viento constante con un pequeño ruido positivo, imitando tu fórmula
    float windX = 0.12 + random(1,3) * 0.1;
    float windY = 0.012 + random(1,3) * 0.01;
    PVector v = new PVector(windX, windY);
    v.normalize();
    float mV = mViento * random(1,2);

    float pEscalar = abs(n.dot(v));


    PVector f = PVector.mult(v, mV * pEscalar);

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
  
