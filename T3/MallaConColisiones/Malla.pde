public class Malla {
  
  Particle[][] _particles;
  ArrayList<DampedSpring> _springs;
  ArrayList<Bola> bolas;
  PVector pos;
  float lMuelle;
  
  
  Malla() {
    pos = new PVector(-SC/2, HC, -SC/2);
    _particles = new Particle[NC][NC];
    _springs = new ArrayList<DampedSpring>();
    bolas = new ArrayList<Bola>();
    
    lMuelle = SC/NC; 
    int id = 0;
    
    
    
    //Particulas
    for(int i = 0; i < NC; i++)//X
    {
      for(int j = 0; j< NC; j++)//Y
      {
          
        float x = i * lMuelle;
        float z = j*lMuelle;
        
        PVector p = new PVector(pos.x + x, pos.y,pos.z + z);
        //println("x:" + p.x + " z:" + p.z);
        PVector v = new PVector(0, 0, 0); 
        _particles[i][j] = new Particle(id, MC, p, v, R, CNodo);
        id++;
        }
      }
    
    
      //Muelles
      for(int i = 0; i < NC; i++)//X
      {
        for(int j = 0; j< NC; j++)//Y
        {
            
           //MUELLES HORIZONTALES Y VERTICALES
           if(i >0)
            {
              DampedSpring s = new DampedSpring(_particles[i][j], _particles[i-1][j], CMuelle, lMuelle, KE, KA);
              _springs.add(s);//x
              _particles[i][j].addSpring(s);
              _particles[i-1][j].addSpring(s);
              
            }
            if(j > 0)
            {
              DampedSpring s = new DampedSpring(_particles[i][j], _particles[i][j-1], CMuelle, lMuelle,  KE, KA);
              _springs.add(s);//y
              _particles[i][j].addSpring(s);
              _particles[i][j-1].addSpring(s);
            }
        }
      }
      
  }
  
  
  void display(){
     
     for (int x = 0; x < NC; x++) 
     {
      for (int y = 0; y < NC; y++) 
      {
          _particles[x][y].display();
      }
    }
   
     for(int i = 0; i < _springs.size(); i++)
     {
        _springs.get(i).display(); 
     }
  }
  
  void update (float timeStep){
    //Muelles
    for(int i = 0; i < _springs.size(); i++)
    {
      _springs.get(i).update();
    }
    
    //Particulas
   for (int x = 0; x < NC; x++) {
        for (int y = 0; y < NC; y++) {
            _particles[x][y].planeCollision(); 
            _particles[x][y].objectCollision(bolas); 
            _particles[x][y].update(timeStep);
          
        }
     }
  }
  
  void addBola(Bola b)
  {
     bolas.add(b); 
  }
  
  
}
