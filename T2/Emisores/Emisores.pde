
// Simulation and time control:

float _timeStep;        // Simulation time-step (s)
float _simTime = 0.0;   // Simulated time (s)

// System variables:

ParticleSystem _ps;
tipoExplosion tipo;

// Main code:

void settings()
{
   size(1280, 720);
}

void setup()
{
   frameRate(100);
   background(0);

   initSimulation();
}

void keyPressed()
{
   if (key == 'r' || key == 'R')
      restartSimulation();
   else if (key == 'e' || key == 'E')
      tipo = tipoExplosion.ELIPSE;
   else if (key == 'c' || key == 'C')
      tipo = tipoExplosion.CIRCULO;
   else if (key == 's' || key == 'S')
      tipo = tipoExplosion.SPRAY;
   else if (key == '+')
      _timeStep *= 1.1;
   else if (key == '-')
      _timeStep /= 1.1;
}



void initSimulation()
{

   _simTime = 0.0;
   _timeStep = 0.02;
   tipo = tipoExplosion.CIRCULO;

   initParticleSystem();
}


void initParticleSystem()
{
   PVector pos = new PVector(width/2,height);
   
   _ps = new ParticleSystem(pos);  
 
   
}
void mousePressed()
{
  PVector raton = new PVector(mouseX,mouseY);
  color col = color(random(0,255),random(0,255),random(0,255));
   
    
    if(tipo == tipoExplosion.SPRAY)
    {
      for (int i = 0; i < nPart; i++) 
      { 
        int n = i % nPart;
        PVector posPS = new PVector(width/2, height);
        float anglePos = atan2(raton.y - posPS.y, raton.x - posPS.x); //angulo desde el centro del spray al raton
        float angleE = n * (anguloSpray / nPart);         
        float angle = (anglePos - anguloSpray/2) + angleE;   // lo centramos alrededor del ángulo base

        
        PVector vel = PVector.fromAngle(angle);
        vel.mult(random(100,130));
        
        _ps.addParticle(M,posPS,vel,R,col,LS);
      }
    }
    else
    {
      for (int i = 0; i < nPart; i++) 
      { 
        int n = i % nPart;
        float angle = n * (TWO_PI/nPart); // Espaciado uniforme en el círculo
        PVector vel = PVector.fromAngle(angle); // Vector unitario en esa dirección
        PVector pos = new PVector(raton.x ,raton.y); 
        
        if(tipo == tipoExplosion.ELIPSE)
        {
          vel.x *= xElipse;
          vel.y *= yElipse;
        }
        
        vel.mult(random(40,50)); // Ajustar velocidad aleatoria
        
        _ps.addParticle(M,pos,vel,R,col,LS);
    
        }
    }
    
  

}

void restartSimulation()
{
   initSimulation();
}


void draw()
{
   drawStaticEnvironment();
   drawMovingElements();
   updateSimulation();

}

void drawStaticEnvironment()
{
   background(0);
   stroke(255);
   fill(255);
   textSize(20);
   text("Tipo de explosion: " + tipo, width*0.3, height*0.025);
}

void drawMovingElements()
{
   _ps.draw();
}

void updateSimulation()
{
   _ps.update(_timeStep);
}
