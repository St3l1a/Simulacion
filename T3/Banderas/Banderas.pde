

float _timeStep;        // Simulation time-step (s)
float _simTime = 0.0;   // Simulated time (s)

 //Podemos modificar este valor para añadir más pelos a la simulación
Bandera bandera;


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


void initSimulation()
{
   _simTime = 0.0;
   _timeStep = TS;

   bandera = new Bandera (Lcuerda, NMUELLES, b1);
   bandera = new Bandera (Lcuerda, NMUELLES, b1);
   bandera = new Bandera (Lcuerda, NMUELLES, b1);
}


void restartSimulation()
{
   initSimulation();
}

void updateSimulation()
{
  _simTime += _timeStep;
  
  bandera.update(_simTime);
}

void draw()
{
  background(255);
  fill(255,0,0);
  
  bandera.display();
  updateSimulation();
}
