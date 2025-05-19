

float _timeStep;        // Simulation time-step (s)
float _simTime = 0.0;   // Simulated time (s)

 //Podemos modificar este valor para añadir más pelos a la simulación
ArrayList<Bandera> banderas;


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

    banderas = new ArrayList<Bandera>();
    banderas.add( new Bandera (Lcuerda, NMUELLES, b1, FlagType.Structured));
    banderas.add( new Bandera (Lcuerda, NMUELLES, b2, FlagType.Shear));
    banderas.add( new Bandera (Lcuerda, NMUELLES, b3, FlagType.Bend));
    
}


void restartSimulation()
{
   initSimulation();
}

void updateSimulation()
{
  _simTime += _timeStep;
  
  for(int i = 0; i < banderas.size(); i++)
  {
    banderas.get(i).update(_simTime);
  }
}

void draw()
{
  background(255);
  fill(255,0,0);
  
  for(int i = 0; i < banderas.size(); i++)
  {
    banderas.get(i).display();
  }
  updateSimulation();
}
