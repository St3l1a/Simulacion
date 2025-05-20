// Problema 1 - Muelle //<>//

// Ecuacion Diferencial:
// s' = v(t)
// v' = a(s(t), v(t))
// siendo:
//      a(s(t), v(t)) = [Fmuelle + Fpeso ]/m
//      Fpeso = mg; siendo g(0, -9.8) m/s²
//      Fmuelle = Ks(s(t) - s(reposo)) -Kd·v(t)


// Parameters of the problem:
final float   M = 12.0;   // Particle mass (kg)
final float   Gc = 9.801;   // Gravity constant (m/(s*s))
final PVector G  = new PVector(0.0, -Gc);   // Acceleration due to gravity (m/(s*s))

PVector S0,S1;
PVector _s = new PVector();   // Position of the particle (m)
PVector _v = new PVector();   // Velocity of the particle (m/s)
PVector _a = new PVector();   // Accleration of the particle (m/(s*s))
PVector _v0 = new PVector();

/////////////////////////////////////////////////////////////////////
// Parameters of the numerical integration:
float         SIM_STEP = .1;   // Simulation time-step (s)
enum IntegratorType 
{
  NONE,
  EXPLICIT_EULER,   
  SIMPLECTIC_EULER, 
  HEUN, 
  RK2,  
  RK4  
}
IntegratorType integrator = IntegratorType.EXPLICIT_EULER;  // ODE integration method

/////////////////////////////////////////////////////////////////////
// Draw values:
final boolean FULL_SCREEN = false;
final int     DRAW_FREQ = 60;   // Draw frequency (Hz or Frame-per-second)
int           DISPLAY_SIZE_X = 800;   // Display width (pixels)
int           DISPLAY_SIZE_Y = 450;   // Display height (pixels)

final int []  BACKGROUND_COLOR = {200, 200, 255};
final int []  REFERENCE_COLOR = {0, 255, 0};
final int []  OBJECTS_COLOR = {255, 0, 0};
final float   OBJECTS_SIZE = 50.0;   // Size of the objects (pixels)
final PVector DISPLAY_CENTER = new PVector(0.0, 0.0);   // World position that corresponds with the center of the display (m)


// Time control:
int _lastTimeDraw = 0;   // Last measure of time in draw() function (ms)
float _deltaTimeDraw = 0.0;   // Time between draw() calls (s)
float _simTime = 0.0;   // Simulated time (s)
float _elapsedTime = 0.0;   // Elapsed (real) time (s)

// Output control:

PrintWriter _output;
final String FILE_NAME = "data.txt";

////////////////////////////////////////////////////////////////////////////77

void settings()
{
  if (FULL_SCREEN)
  {
    fullScreen();
    DISPLAY_SIZE_X = displayWidth;
    DISPLAY_SIZE_Y = displayHeight;
  } 
  else
    size(DISPLAY_SIZE_X, DISPLAY_SIZE_Y);
}

void setup()
{
  
  frameRate(DRAW_FREQ);
  _lastTimeDraw = millis();

  initSimulation();
}

void initSimulation()
{
  _output = createWriter(FILE_NAME);
  WriteSimulationState("t, sx, sy, vx, vy, E");
  WriteSimulationState("----------------------------");

  _simTime = 0.0;
  _elapsedTime = 0.0;
  
  S0 = new PVector(0,-30);   // Particle's start position (pixels)
  S1 = new PVector(200,-200);

  _v0.set(0,0);
  _s = S0.copy();
  _v.set(_v0.x, _v0.y);
  _a.set(0.0, 0.0);
}


void draw()
{
  //background(255);
  updateSimulation();
  drawScene();
}



void drawScene()
{
  background(255);
  textSize(20);
  text("Integrator: " + integrator.toString(), width*0.025, height*0.075);
  
  translate(width/2, height/3); 
  strokeWeight(6);
  strokeCap(ROUND);
  line(S0.x, -S0.y, _s.x, -_s.y - OBJECTS_SIZE/2); //-S0.y -> para que la particula llegue al (0,0) de donde está el muelle
  line(S1.x, -S1.y, _s.x, -_s.y - OBJECTS_SIZE/2);
  fill(OBJECTS_COLOR[0], OBJECTS_COLOR[1], OBJECTS_COLOR[2]);
  strokeWeight(1);
  
  circle(_s.x, -_s.y, OBJECTS_SIZE);
  
  fill(100);
  
}


void updateSimulation()
{
  switch (integrator)
  {
  case EXPLICIT_EULER:
    updateSimulationExplicitEuler();
    break;

  case SIMPLECTIC_EULER:
    updateSimulationSimplecticEuler();
    break;

  case HEUN:
    updateSimulationHeun();
    break;

  case RK2:
    updateSimulationRK2();
    break;

  case RK4:
    updateSimulationRK4();
    break;
  }
  
  _simTime += SIM_STEP;
  
  
}
// Ecuacion Diferencial:
// s' = v(t)
// v' = a(s(t), v(t))
// being: 
//      a(s(t), v(t)) = [Fmuelle + Fpeso ]/m

//      Fpeso = mg; siendo g(0, -9.8) m/s²
//      Fmuelle = Ks(s(t) - s(reposo)) -Kd·v(t)

PVector calculateAcceleration(PVector s, PVector v)
{
  float kr=1; //0.120
  float ks=3.2; //1.2
  PVector Fpeso = PVector.mult(G,M);// masa*gravedad
  PVector Fmuelle = PVector.mult(PVector.sub(S0,s), ks);//ks(s0-s)
  
  PVector Fmuelle1 = PVector.mult(PVector.sub(S1,s), ks);
  
  PVector Famort = PVector.mult(v,-kr);// -kr*v
  PVector f = PVector.add(Fmuelle, Famort);//Sumamos las fuerzas del muelle
  
  f.add(Fpeso);//sumamos la fuerza del peso
  f.add(Fmuelle1);//Sumamos el segundo muelle
  
  PVector a = PVector.div(f,M);//dividimos el sumatorio de las fuerzas entre la masa
  
  return a; // calcular la aceleracion que sufre el muelle
}



void keyPressed()
{
  if (key == 'r' || key == 'R')
  {
    initSimulation();
  }
  else if (key == '1')
  {
    integrator = IntegratorType.EXPLICIT_EULER;
  }
  else if (key == '2')
  {
    integrator = IntegratorType.SIMPLECTIC_EULER;
  }
  else if (key == '3')
  {
    integrator = IntegratorType.HEUN;
  }
  else if (key == '4')
  {
    integrator = IntegratorType.RK2;
  }
  else if (key == '5')
  {
    integrator = IntegratorType.RK4;
  }
 
}

void stop()
{
  _output.flush();
  _output.close();
}

void updateSimulationExplicitEuler()
{
  // s(t+h) = s(t) + h*v(t)
  // v(t+h) = v(t) + h*a(s(t),v(t))
  
  _a = calculateAcceleration(_s, _v);
  _s.add(PVector.mult(_v, SIM_STEP));
  _v.add(PVector.mult(_a, SIM_STEP));// Calcula la derivada en t

}

void updateSimulationSimplecticEuler()
{
  // s(t+h) = s(t) + h*v(t+h)
  // v(t+h) = v(t) + h*a(s(t),v(t))
  _a = calculateAcceleration(_s, _v);
  _v.add(PVector.mult(_a, SIM_STEP));//Calcula la derivada de S en t+h
  _s.add(PVector.mult(_v, SIM_STEP));
  
}

void updateSimulationHeun()
{
  // s^(t+h) = s(t) + h*v(t)
  // v^(t+h) = v(t) + h*a(s(t),v(t))

  // s(t+h) = s(t) + (h/2)*[v(t) + v^(t+h)]
  // v(t+h) = v(t) + (h/2)*[a(s(t),v(t)) + a(s^(t+h),v^(t+h))]
  
  _a = calculateAcceleration(_s, _v);
  PVector _s2 = PVector.add(_s,PVector.mult(_v, SIM_STEP)); //s^(t+h)
  PVector _v2 = PVector.add(_v,PVector.mult(_a, SIM_STEP)); //v^(t+h)
  PVector _a2 = calculateAcceleration(_s2, _v2); //a(s^(t+h),v^(t+h))
  
  _s.add(PVector.mult(PVector.add(_v,_v2),SIM_STEP/2)); //s(t+h)
  _v.add(PVector.mult(PVector.add(_a,_a2),SIM_STEP)); //v(t+h)
  
  
}

void updateSimulationRK2()
{

  _a = calculateAcceleration(_s, _v);
  PVector s1 = PVector.add(_s, PVector.mult(_v, SIM_STEP*0.5));  
  PVector v1 = PVector.add(_v, PVector.mult(_a, SIM_STEP*0.5));
  
  PVector a2 = calculateAcceleration(s1, v1);
  PVector k2v = PVector.mult(a2, SIM_STEP);
  PVector k2s = PVector.mult(v1, SIM_STEP);
  
  _v.add(k2v);
  _s.add(k2s);
 
}


void updateSimulationRK4()
{
  // k1v = a(s(t),v(t))*h
  // k1s = v(t)*h  
  _a = calculateAcceleration(_s,_v);
  PVector k1v = PVector.mult(_a,SIM_STEP);
  PVector k1s = PVector.mult(_v,SIM_STEP);
  
  // k2v = a(s(t)+k1s/2, v(t)+k1v/2)*h
  // k2s = (v(t)+k1v/2)*h
  PVector s1 = PVector.add(_s, PVector.mult(k1s, 0.5)); //Calculo la s que usaré para calcular la proxima aceleracion
  PVector v1 = PVector.add(_v, PVector.mult(k1v,0.5)); //Calculo la v que usaré para calcular la proxima aceleracion y la proxima k
  PVector a2 = calculateAcceleration(s1, v1);
  PVector k2v = PVector.mult(a2, SIM_STEP);
  PVector k2s = PVector.mult(v1, SIM_STEP);
  
  // k3v = a(s(t)+k2s/2, v(t)+k2v/2)*h
  // k3s = (v(t)+k2v/2)*h
  PVector s2 = PVector.add(_s, PVector.mult(k2s,0.5));
  PVector v2 = PVector.add(_v, PVector.mult(k2v, 0.5));
  PVector a3 = calculateAcceleration(s2, v2);
  PVector k3v = PVector.mult(a3, SIM_STEP);
  PVector k3s = PVector.mult(v2, SIM_STEP);
  
  // k4v = a(s(t)+k3s, v(t)+k3v)*h
  // k4s = (v(t)+k3v)*h
  PVector s3 = PVector.add(_s,k3s);
  PVector v3 = PVector.add(_v, k3v);
  PVector a4 = calculateAcceleration(s3, v3);
  PVector k4v = PVector.mult(a4, SIM_STEP);
  PVector k4s = PVector.mult(v3, SIM_STEP);
  
  // v(t+h) = v(t) + (1/6)*k1v + (1/3)*k2v + (1/3)*k3v +(1/6)*k4v  
  // s(t+h) = s(t) + (1/6)*k1s + (1/3)*k2s + (1/3)*k3s +(1/6)*k4s  
  _v.add(PVector.add(PVector.div(k4v,6),PVector.add(PVector.div(k3v,3),PVector.add(PVector.div(k1v,6), PVector.div(k2v,3)))));
  _s.add(PVector.add(PVector.div(k4s,6),PVector.add(PVector.div(k3s,3),PVector.add(PVector.div(k1s,6), PVector.div(k2s,3)))));
  
}

void WriteSimulationState(String data)
{
  _output.println(data);
}
