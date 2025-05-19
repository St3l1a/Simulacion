// Problem description: //<>//
//
//  implementar una simulación de billar francés (sin troneras) 
//  en el que 5 bolas se sitúen sobre una mesa de billar, en posiciones inicialmente aleatorias
//

// Simulation and time control:

float _timeStep;        // Simulation time-step (s)
float _simTime = 0.0;   // Simulated time (s)

// Output control:

boolean _writeToFile = true;
PrintWriter _output;
boolean _computeParticleCollisions = true;
boolean _computePlaneCollisions = true;
boolean velocidadesIniciales = true;  // Velocidad inicial en las bolas
boolean atraccion = false; 

// System variables:

ArrayList<Particle> _ps;
PlaneSection _plane;


// Performance measures:
float _Tint = 0.0;    // Integration time (s)
float _Tdata = 0.0;   // Data-update time (s)
float _Tcol1 = 0.0;   // Collision time particle-plane (s)
float _Tcol2 = 0.0;   // Collision time particle-particle (s)
float _Tsim = 0.0;    // Total simulation time (s) Tsim = Tint + Tdata + Tcol1 + Tcol2
float _Tdraw = 0.0;   // Rendering time (s)
int id;
// Main code:

void settings()
{
   size(DISPLAY_SIZE_X, DISPLAY_SIZE_Y);
}

void setup()
{
   frameRate(DRAW_FREQ);
   background(BACKGROUND_COLOR[0], BACKGROUND_COLOR[1], BACKGROUND_COLOR[2]);

   initSimulation();
}

void stop()
{
   endSimulation();
}

void keyPressed()
{
   if (key == 'r' || key == 'R')
      restartSimulation();
   else if (key == 'c' || key == 'C')
      _computeParticleCollisions = !_computeParticleCollisions;
   else if (key == 'p' || key == 'P')
      _computePlaneCollisions = !_computePlaneCollisions;
   else if (key == 'v' || key == 'V')  //Permite cambiar si al empezar la simulación las bolas tienen una velocidad inicial random
      velocidadesIniciales = !velocidadesIniciales;
   else if (key == 'a' || key == 'A')  //Permite cambiar si al está la fuerza de atraccion
      atraccion = !atraccion;
   else if (key == '+')
      _timeStep *= 1.1;
   else if (key == '-')
      _timeStep /= 1.1;
  
}

void mousePressed()
{
   // Convertir a metros
   PVector mousePos = new PVector(mouseX, mouseY);
   PVector v = new PVector(random(-10,10), random(-10,10));
   
   _ps.add(new Particle(id, M, mousePos, v,R,C));
   id++;
}


void initSimulation()
{
   if (_writeToFile)
   {
      _output = createWriter(FILE_NAME);
      writeToFile("t, n, Tsim");
   }

   _simTime = 0.0;
   _timeStep = TS;
   id = 0;

   _plane = new PlaneSection(esquinaSupIzq.x, esquinaSupIzq.y , esquinaInfDer.x, esquinaInfDer.y,false);
   _ps = new ArrayList<Particle>(); 
}


void restartSimulation()
{
   initSimulation();
}

void endSimulation()
{
   if (_writeToFile)
   {
      _output.flush();
      _output.close();
   }
}

void draw()
{
   drawStaticEnvironment();
   drawMovingElements();
    updateSimulation();
}

void drawStaticEnvironment()
{
   background(BACKGROUND_COLOR[0], BACKGROUND_COLOR[1], BACKGROUND_COLOR[2]);
   
  _plane.draw();
   
}

void drawMovingElements()
{
  for(int i = 0; i < _ps.size(); i++)
  {
    _ps.get(i).draw();
  }
}

void updateSimulation()
{
  for(int i = 0; i < _ps.size(); i++)
  {
    _ps.get(i).update(_timeStep);
    _ps.get(i).planeCollision(_plane);
    _ps.get(i).particleCollision(_ps);
    _ps.get(i).particleColor(_plane);
  }
  _simTime += _timeStep;

}

void writeToFile(String data)
{
   _output.println(data);
}

void displayInfo()
{
   stroke(TEXT_COLOR[0], TEXT_COLOR[1], TEXT_COLOR[2]);
   fill(TEXT_COLOR[0], TEXT_COLOR[1], TEXT_COLOR[2]);
   textSize(20);
   text("Time integrating equations: " + _Tint + " ms", width*0.3, height*0.025);
   text("Time updating collision data: " + _Tdata + " ms", width*0.3, height*0.050);
   text("Time computing collisions (planes): " + _Tcol1 + " ms", width*0.3, height*0.075);
   text("Time computing collisions (particles): " + _Tcol2 + " ms", width*0.3, height*0.100);
   text("Total simulation time: " + _Tsim + " ms", width*0.3, height*0.125);
   text("Time drawing: " + _Tdraw + " ms", width*0.3, height*0.150);
   text("Total step time: " + (_Tsim + _Tdraw) + " ms", width*0.3, height*0.175);
   text("Fps: " + frameRate + "fps", width*0.3, height*0.200);
   text("Simulation time step = " + _timeStep + " s", width*0.3, height*0.225);
   text("Simulated time = " + _simTime + " s", width*0.3, height*0.250);
   
   text("Atraccion: " + atraccion, width*0.3, height*0.300);
}
