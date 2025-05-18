// Use PeasyCam for 3D rendering //<>// //<>//
import peasy.*;

// Camera:
PeasyCam _camera;   // mouse-driven 3D camera

// Simulation and time control:
int _lastTimeDraw = 0;        // Last measure of time in draw() function (ms)
float _deltaTimeDraw = 0.0;   // Time between draw() calls (s)
float _simTime = 0.0;         // Simulated time (s)
float _elapsedTime = 0.0;     // Elapsed (real) time (s)
float _timeStep;              // Simulation time-step (s)


Malla m;
Ground g;
Bola b;
// Main code:

void settings()
{
  if (FULL_SCREEN)
  {
    fullScreen(P3D);
    DISPLAY_SIZE_X = displayWidth;
    DISPLAY_SIZE_Y = displayHeight;
  } 
  else
  {
    size(DISPLAY_SIZE_X, DISPLAY_SIZE_Y, P3D);
  }
}

void setup()
{
  frameRate(DRAW_FREQ);
  _lastTimeDraw = millis();
  
  float aspect = float(DISPLAY_SIZE_X)/float(DISPLAY_SIZE_Y);  
  perspective((FOV*PI)/180, aspect, NEAR, FAR);
  _camera = new PeasyCam(this, 0);
  _camera.setDistance(CAMERA_DIST); 
  initSimulation();
}

void keyPressed()
{
   if (key == 'r' || key == 'R')
      restartSimulation();
   else if (key == '+')
      _timeStep *= 1.1;
   else if (key == '-')
      _timeStep /= 1.1;
}

void restartSimulation()
{
  initSimulation();
}

void stop()
{
   endSimulation();
}

void initSimulation()
{
  _simTime = 0.0;
  _elapsedTime = 0.0;
  _timeStep = TS*TIME_ACCEL;
  
  g = new Ground();
  b = new Bola(new PVector(0,alturaSuelo - RB,0), RB, cPart);
  m = new Malla();
  
  m.addBola(b);
}

void updateSimulation()
{
  _simTime += _timeStep;
  m.update(_simTime);
  
}

void endSimulation()
{
}

void printInfo()
{
  pushMatrix();
  {
    camera();
    fill(0);
    textSize(20);
    
    text("Frame rate = " + 1.0/_deltaTimeDraw + " fps", width*0.025, height*0.05);
    text("Elapsed time = " + _elapsedTime + " s", width*0.025, height*0.075);
    text("Simulated time = " + _simTime + " s ", width*0.025, height*0.1);
  }
  popMatrix();
}

void drawStaticEnvironment()
{
  strokeWeight(0);


  fill(255, 0, 0);//x
  box(200.0, 0.25, 0.25);

  fill(0, 255, 0);//y
  box(0.25, 200.0, 0.25);

  fill(0, 0, 255);//z
  box(0.25, 0.25, 200.0);
  strokeWeight(1);
  fill(0, 255, 255);
  
  g.display(); 
//  b.display();
}

void drawDynamicEnvironment()
{
  m.display();
}

void draw()
{
  int now = millis();
  _deltaTimeDraw = (now - _lastTimeDraw)/1000.0;
  _elapsedTime += _deltaTimeDraw;
  _lastTimeDraw = now;
  //println("\nDraw step = " + _deltaTimeDraw + " s - " + 1.0/_deltaTimeDraw + " Hz");

  background(BACKGROUND_COLOR[0], BACKGROUND_COLOR[1], BACKGROUND_COLOR[2]);
  drawStaticEnvironment();
  drawDynamicEnvironment();

  if (REAL_TIME)
  {
    float expectedSimulatedTime = TIME_ACCEL*_deltaTimeDraw;
    float expectedIterations = expectedSimulatedTime/_timeStep;
    int iterations = 0; 

    for (; iterations < floor(expectedIterations); iterations++)
      updateSimulation();

    if ((expectedIterations - iterations) > random(0.0, 1.0))
    {
      updateSimulation();
      iterations++;
    }

    //println("Expected Simulated Time: " + expectedSimulatedTime);
    //println("Expected Iterations: " + expectedIterations);
    //println("Iterations: " + iterations);
  } 
  else
    updateSimulation();

  printInfo();
}
