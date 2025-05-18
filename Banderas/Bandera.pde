
class Bandera
{
  PVector longitud;  //Longitud total
  PVector nMuelles;  //Nº de muelles
  PVector origen;  //Posicion origen
  PVector lMuelle;  //Longitud reposo de muelles
  FlagType tipo;
  
  Particle[][] _particles;
  PVector[][] fuerzas;
  ArrayList<Spring> _muelles;
  
  Bandera (PVector longitud_, PVector nMu, PVector _origen, FlagType t)
  {
    longitud = longitud_.copy();
    nMuelles = nMu.copy();
    origen = _origen.copy();
    lMuelle = new PVector(longitud.x/nMuelles.x, longitud.y/nMuelles.y);
    tipo = t;
    
    
     _particles = new Particle[(int)nMuelles.x+1][(int)nMuelles.y+1];
     _muelles = new ArrayList<Spring>();
     fuerzas = new PVector[(int)nMuelles.x+1][(int)nMuelles.y+1];
    
    //PARTICULAS
    for(int i = 0; i < _particles.length; i++){//x
      for(int j = 0; j <_particles[0].length ;j++){//y
        PVector pos = new PVector(origen.x + lMuelle.x * i, origen.y + lMuelle.y * j);
       _particles[i][j] = new Particle (pos);
      }
    }
    
    
    //MUELLES
    //Structured
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
    
    //Shear
    if(tipo != FlagType.Structured)
    {
       for(int i = 0; i < _particles.length; i++){//x
        for(int j = 0; j <_particles[0].length ;j++){//y
        
            if(i+1 < _particles.length && j > 0 )//diag derecha arriba
            {
              //println("Pos actu:" + i + ","+ j +"Pos sig:" + (i+1) + ","+ (j-1));
              Spring s = new Spring(_particles[i][j], _particles[i+1][j-1]);
              _muelles.add(s);//x
              _particles[i][j].addSpring(s);
              _particles[i+1][j-1].addSpring(s);
             
            }
            
            if(i+1 < _particles.length && j+1 < _particles[0].length )// diag derecha abajo
            {
              //println("Pos actu:" + i + ","+ j +"Pos sig:" + (i+1) + ","+ (j+1));
              Spring s = new Spring(_particles[i][j], _particles[i+1][j+1]);
              _muelles.add(s);//x
              _particles[i][j].addSpring(s);
              _particles[i+1][j+1].addSpring(s);
              
              
            }
          }
        }
      
    }
    //Bend
    else if(tipo == FlagType.Bend)
    {
      for(int i = 0; i < _particles.length; i++){//x
        for(int j = 0; j <_particles[0].length ;j++){//y
          
            if(i - 2 >= 0)//horizontales
            {
             // println("Pos actu:" + i + ","+ j +"Pos sig:" + (i-2) + ","+ (j));
              Spring s = new Spring(_particles[i][j], _particles[i-2][j]);
              _muelles.add(s);//x
              _particles[i][j].addSpring(s);
              _particles[i-2][j].addSpring(s);
              
            }
              
            if(j-2 >= 0)//verticales
            {
              Spring s = new Spring(_particles[i][j], _particles[i][j-2]);
              _muelles.add(s);//y
              _particles[i][j].addSpring(s);
              _particles[i][j-2].addSpring(s);
            }
          }
        }
    }
        
    
    
  }
  
  void update(float ts)
  {
    
    for(int i = 0; i < _muelles.size(); i++)
       _muelles.get(i).update();
      
    /*
    for(int i = 0; i < _particles.length; i++){//x
      for(int j = 0; j < _particles[0].length ;j++){//y
        fuerzas[i][j].set(0,0);
        Particle VertexPos = _particles[i][j];
        
        fuerzas[i][j] = gravity;
        fuerzas[i][j].add(getForce( i-1, j , VertexPos, Lcuerda, k));
      }
    }*/
    
    
    
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
  
 /* PVector getForce(int nx, int ny, PVector currentPos, float restLength, float k) {
  // Comprobamos si el vecino existe dentro de los límites
  if (nx < 0 || nx >= sx || ny < 0 || ny >= sy) {
    return new PVector(0, 0, 0); // fuerza nula si está fuera de la malla
  }

  PVector neighborPos = vert[nx][ny]; // posición del nodo vecino
  PVector dir = PVector.sub(neighborPos, currentPos); // vector entre los puntos

  float dist = dir.mag(); // distancia actual
  if (dist == 0) return new PVector(0, 0, 0); // evita división por 0

  float displacement = dist - restLength; // cuánto se estira o comprime el muelle

  dir.normalize(); // dirección unitaria
  dir.mult(k * displacement); // ley de Hooke: F = -k * Δx

  return dir;
}*/


  
}
