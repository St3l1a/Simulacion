
class Bandera
{
  PVector longitud;  //Longitud total
  PVector nMuelles;  //Nº de muelles
  PVector origen;  //Posicion origen
  PVector lMuelle;  //Longitud reposo de muelles
  
  Particle[][] _particles;
  ArrayList<Spring> _muelles;
  
  Bandera (PVector longitud_, PVector nMu, PVector _origen)
  {
    longitud = longitud_.copy();
    nMuelles = nMu.copy();
    origen = _origen.copy();
    lMuelle = new PVector(longitud.x/nMuelles.x, longitud.y/nMuelles.y);
    
    
     _particles = new Particle[(int)nMuelles.x+1][(int)nMuelles.y+1];
     _muelles = new ArrayList<Spring>();
    
    //PARTICULAS
    for(int i = 0; i < _particles.length; i++){//x
      for(int j = 0; j <_particles[0].length ;j++){//y
        PVector pos = new PVector(origen.x + lMuelle.x * i, origen.y + lMuelle.y * j);
       _particles[i][j] = new Particle (pos);
      }
    }
    
    //MUELLES
    for(int i = 0; i < _particles.length; i++){//x
      for(int j = 0; j <_particles[0].length ;j++){//y
          if(i >0)//horizontales
          {
            Spring s = new Spring(_particles[i][j], _particles[i-1][j]);
            _muelles.add(s);//x
            _particles[i][j].addSpring(s);
            _particles[i-1][j].addSpring(s);
            
          }
            
          if(j > 0)//verticales
          {
            Spring s = new Spring(_particles[i][j], _particles[i][j-1]);
            _muelles.add(s);//y
            _particles[i][j].addSpring(s);
            _particles[i][j-1].addSpring(s);
          }
      }
    }
    
  }
  
  void update(float ts)
  {
    
    
    for(int i = 0; i < _muelles.size(); i++)
       _muelles.get(i).update();
      
    
    for(int i = 0; i < _particles.length; i++){//x
      for(int j = 0; j < _particles[0].length ;j++){//y
      if (!((i == 0 && j == 0) || (i == 0 && j == _particles[0].length - 1)))//si no son las que sujetan la bandera
         _particles[i][j].update(ts);
      
        
      }
    }
    
  }
  
  void display()
  {
    stroke(0);  

    line(origen.x, origen.y, origen.x, height);

    stroke(255, 0, 0);  // línea roja

    for(int i = 0; i < _particles.length; i++){//x
      for(int j = 0; j < _particles[0].length ;j++){//y
       
       _particles[i][j].display();
      }
    }
    
    for(int i = 0; i < _muelles.size(); i++){//x
       _muelles.get(i).display();
      
    }
    
  }
  

  
}
